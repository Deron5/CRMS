const mysql = require('mysql2');
const conn = mysql.createConnection({
    host: "localhost",  //host ip address
    user: "root", //username
    password: "", //password for the user
    database: "crms", //database name
    dateStrings: true,
});

const loginQuery = `select role from customers where email = ? and password = ?`;

const customerRentalsQuery = `select * from rentals, customers, vehicle_types, vehicles 
                            where rentals.customer_id = customers.customer_id and 
                            rentals.vehicle_id = vehicles.license_plate_number and 
                            vehicles.vehicle_type = vehicle_types.vin`;

const FIRST_RENTAL_VID = "select count(vehicle_id) as count,vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc limit 1"

function empty(res) {
    return !res.length
}

function notEmpty(res) {
    return res.length
}

const defaultQueries = {
    "vehicle_types": "select * from vehicle_types where vin in (select distinct(vehicle_type) from vehicles)",
    "customers": "select * from vehicle_types right join (select customers.customer_id,first_name,surname,email,phone_number,license_issue_location,drivers_license,license_expiration_date,preferred_vehicle,address,preferred_dropoff,preferred_pickup,credit_card_expiration_date,billing_address, concat(substr(credit_card_number,1,4),'-xxxx-xxxx-xxxx') as credit_card_number, coalesce(count,0) as count from customers left join (select count(*) as count,customer_id from rentals group by customer_id) as x on x.customer_id = customers.customer_id) as y on y.preferred_vehicle = vin"
    // "customers": "select customers.customer_id,first_name,surname,email,phone_number,license_issue_location,drivers_license,license_expiration_date,preferred_vehicle,address,preferred_dropoff,preferred_pickup,credit_card_expiration_date,billing_address, concat(substr(credit_card_number,1,4),'-xxxx-xxxx-xxxx') as credit_card_number, coalesce(count,0) from customers left join (select count(*) as count,customer_id from rentals group by customer_id) as x on x.customer_id = customers.customer_id"
}

/*
 * Used in inserts
 */
const insertChecks = {
    "customers":[
                {
                    query:'select customer_id from customers where email = ?',
                    paramNames:["email"],
                    failString: 'Customer With The Same Email Already Exists',
                    bool: empty
                },
                {
                    query:'select customer_id from customers where phone_number = ?',
                    paramNames:["phone_number"],
                    failString:'Customer With The Same Phone Number Already Exists',
                    bool: empty
                },
                {
                    query:'select store_id from stores where store_id = ?',
                    paramNames:["preferred_pickup"],
                    failString:'Preferred Pickup Location Does Not Exist',
                    bool: notEmpty
                },
                {
                    query:'select store_id from stores where store_id = ?',
                    paramNames:["preferred_dropoff"],
                    failString:'Preferred Dropoff Location Does Not Exist',
                    bool: notEmpty
                },
                {
                    query:'select vin from vehicle_types where vin = ? and vin in (select distinct(vehicle_type) from vehicles)',
                    paramNames:["preferred_vehicle"],
                    failString: 'No Cars Of The Specified Type Exist',
                    bool: notEmpty
                },
                {
                    query:'select customer_id from customers where drivers_license = ? ',
                    paramNames:["drivers_license"],
                    failString: `User with the same driver's license exits`,
                    bool: empty
                }
            ]
}


conn.connect(function (err) {
    if (err) throw err;
    console.log("Connected!");
});

const NO_RESULTS = JSON.stringify('NO_RESULTS');

const RENTAL_DAYS = "select sum(datediff(lend_date,return_date)) as days, count(lend_date) as count from rentals where vehicle_id = ?";

const RENTAL_DAYS_YEAR = "select sum(datediff(lend_date,return_date)) as days, count(lend_date) as count from rentals where vehicle_id = ? and YEAR(lend_date) = ?";

const RENTAL_DAYS_YEAR_MONTH = "select sum(datediff(lend_date,return_date)) as days, count(lend_date) as count from rentals where vehicle_id = ? and YEAR(lend_date) = ? and MONTH(lend_date) = ?";

const RENTAL_MONTH_COUNTS = "select count(lend_date) as count, MONTH(lend_date) as month from rentals group by month(lend_date) where vehicle_id = ? and year = ?";

const FIRST_LAST_RENTAL_VID = "(select count(vehicle_id) as count, vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc limit 1) union (select count(vehicle_id) as count, vehicle_id from rentals group by vehicle_id order by count asc, vehicle_id desc limit 1)";

const RENTAL_FROM_ROW = "select count(vehicle_id) as count,vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc limit ?, 1"

const CAR_TYPE_QUERY = "select * from vehicles, vehicle_types where vehicles.license_plate_number = ? and vehicles.vehicle_type = vehicle_types.vin"

const NONE_ = "No Data!";

class RequestHandler {

    async Query(params) {
        const res = await new Promise((resolve,reject)=>{
            if (!params)
              resolve(NO_RESULTS);

            if (!Object.hasOwn(params, "table") || !params.table)
                resolve(JSON.stringify({ "error": " TABLE NOT SPECIFIED" }));

            let query = `select * from ${params.table}`;

            if(Object.hasOwn(defaultQueries,params.table))
                query = defaultQueries[params.table];

            conn.query(query,(err,results)=>{
                if(err)
                    reject(err)
                    resolve(JSON.stringify(results))
            })
        })
        return res;
    }

    //general function for adding to all columns;
    async insertQuery(params){

        const res = await new Promise((resolve,reject)=>{
            if (!params)
                resolve("No Data");

            if (!Object.hasOwn(params, "table") || !params.table)
                resolve(JSON.stringify({ error: " TABLE NOT SPECIFIED" }));

            let checks = []

            if(Object.hasOwn(insertChecks,params.table)){
                insertChecks[params.table].forEach(check=>{
                    checks.push(new Promise((resolve_,reject_)=>{
                                let data = [];
                                check.paramNames.forEach(key=>{
                                    if(!Object.hasOwn(params,key) && params[key])
                                        reject_(`Missing ${key} parameter can't validate query`);
                                    data.push(params[key])
                                })
                                conn.query(check.query,data,(err,res)=>{
                                    if(err)
                                        reject_(err)
                                    if(res == undefined)
                                        console.log(`res: ${res}\nquery: ${check.query}\ndata:${data}`)
                                    if(check.bool(res))
                                        resolve_("");
                                    else//send error back to client
                                        resolve(JSON.stringify({error:check.failString}))    
                                })

                        }))
                })
            }

            //after all checks construct and execute query
            Promise.all(checks).then(pass=>{

                let base = `insert into ${params.table}(`
        
                delete params.table;
    
                let values = [];
                let hatena = "Values(";


                for (const [key, value] of Object.entries(params)) {
                    base += `${key},`
                    hatena += "?,";
                    values.push(value)
                  }

                conn.query(`${base.substring(0,base.length-1)}) ${hatena.substring(0,hatena.length-1)})`,values,(err,result)=>{
                    if(err)
                        reject(err)
                    resolve("''");
                })
    
            }).catch(err=>{
                reject(err)
            })

        })

        return res;
    }


    async rental_exists(vid){
        const res = await new Promise((resolve,reject)=>{
            let query = "select exists(select * from rentals where vehicle_id = ?) as exist";
            conn.query(query,[vid],(err,results)=>{
                if(err)
                    reject(err)
                else if(!results)
                    reject("err??? rental_exists")
                else
                    resolve(Boolean(results.exist));

            })
        })

        return res;
    }

    async rentalIdsLike(params){
        let query = `select distinct(vehicle_id) from rentals where vehicle_id regexp ?`;
        const res = await new Promise((resolve,reject)=>{
            conn.query(query,[params.regex],(err,res)=>{
                if(err)
                    reject(err)
                resolve(JSON.stringify(res));
            })
        })
        return res;
    }

    async turnoverFromRowNumber(params){
        const res = await new Promise((resolve,reject)=>{
            console.log(params.row)

            if(params.row < 0)
                conn.query(FIRST_LAST_RENTAL_VID,(err,results)=>{
                    if(err){
                        reject(err);
                    }else if(!results){
                        resolve(NO_RESULTS )
                    }else{
                        let query = "select count(*) as count from (select count(vehicle_id) as count,vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc) as x";
                        console.log("here...");
                        conn.query(query,(err,res)=>{
                            if(err)
                                reject(err);
                            resolve(this.turnover_report({vid: results[1].vehicle_id,row:res.count-1}));
                        })
                    }
                })
            else
                conn.query(RENTAL_FROM_ROW,[params.row], (err,results)=>{
                    if(err){
                            console.log("turnover_next err")
                            console.log(err);
                            reject(err)
                    }else if(!results.length){//either last or first
                            conn.query(FIRST_LAST_RENTAL_VID,(err,res)=>{
                                if(err){
                                    reject(err);
                                }else if(!results){
                                    resolve(NO_RESULTS )
                                }else{
                                    resolve(this.turnover_report({row:0,vid:res[0].vehicle_id}));
                                }
                            })

                    }else{
                            resolve(this.turnover_report({vid: results[0].vehicle_id,row:params.row}));
                    }
                })
            });
        return res;
    }


    //returns data for a vehicle report
    async vehicle_report() {

    }

    //returns data for a customer rental report
    async customer_report() {

    }

    //returns data for a vehicle availability report
    async availability_report() {

    }

    async late_return_report() {

    }

    async vehicleType(vid) {
        const res = await new Promise((resolve, reject) => {
            conn.query(CAR_TYPE_QUERY, [vid], (err, results) => {
                if (err) {
                    reject(new Error(err.message))
                }
                else if (!results.length) {
                    resolve(NO_RESULTS);
                }
                else {//do something with data
                    resolve(results[0])
                }
            })
        });
        return res;
    }

    //takes a vehicle id and gets all rentals related to said vehicle
    //returns an object with the data and the vehicle info
    async getVehicleRentals(params) {
        const res = await new Promise((resolve, reject) => {
            let query_base = "select first_name, surname,email, phone_number,drivers_license, datediff(lend_date,returned_date) as days, rentals.* from rentals, customers where rentals.customer_id = customers.customer_id";
            let query_end = " order by lend_date desc";
            
            let searchParams = [];
            let getInfo = false;

            if(params){
                
                if(Object.hasOwn(params,"vid") && params.vid){
                    query_base+= " and vehicle_id = ?"
                    searchParams.push(params.vid)
                    getInfo = true;
                }else if(Object.hasOwn(params,"lend_date") && params.lend_date){
                    query_base+= " and lend_date >= ?"
                    searchParams.push(params.lend_date)
                }else if(Object.hasOwn(params,"return_date") && params.return_date){
                    query_base+= " and return_date <= ?"
                    searchParams.push(params.return_date)
                }
                    
            }
            
            conn.query(query_base+query_end, searchParams, (err, results) => {
                if (err) {
                    console.log(err)
                    reject(new Error(err.message))
                }
                else if (!results.length) {
                    resolve(NO_RESULTS);
                }
                else {//do something with data
                    
                    let data = { rentals: results}

                    if(getInfo)
                        this.vehicleType(params.vid).then(res => {
                            data.typeinfo = res;
                            resolve(JSON.stringify(data))
                        }).catch(err => {
                            console.log("getVehicleRentals from call to vehicleType")
                            reject(err)
                        })
                    else
                        resolve(JSON.stringify(data))

                   
                }
            })

        });
        return res;

    }

    async turnoverHelper(params) {
        const res = await new Promise((resolve, reject) => {

            let data = {
                license: params.vid,
                typeinfo: null,
                monthly_rentals: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                year_rentals: 0,
                total_rentals: 0,
                avg_rent_time: null,
                inde: 0,
                row: params.row,
            }

            let total = 6;
           this.vehicleType(params.vid).then((res) => {
                data.typeinfo = res;
                total-=1;
                if(!total)
                    resolve(JSON.stringify(data))
            }).catch((err) => {
                console.log("turnover_report from call to vehicleType");
                console.log(err);
                reject(err)
            })

            conn.query(RENTAL_DAYS, [params.vid], (err, res) => {
                if (err) {
                    console.log("turnover_report QUERY: RENTAL_DAYS");
                    reject(err);
                } else {
                    data.total_rentals = res.count;
                }
                total-=1;

                if(!total)
                    resolve(JSON.stringify(data))
            })

            let date = new Date()

            conn.query(RENTAL_DAYS_YEAR, [params.vid, date.getFullYear()], (err, res) => {
                if (err) {
                    console.log("turnover_report QUERY: RENTAL_DAYS_YEAR");
                    reject(err)
                } else {
                    data.year_rentals = res.count;
                    data.avg_rent_time = res.days / res.count;
                    total-=1;
                    if(!total)
                        resolve(JSON.stringify(data))
                }
            })

            conn.query(RENTAL_DAYS_YEAR_MONTH, [params.vid, date.getFullYear(), date.getMonth() + 1], (err, res1) => {
                if (err) {
                    console.log("turnover_report QUERY: RENTAL_DAYS_YEAR OUTER");
                    console.log(err)
                    reject(err)
                } else {
                    if (res1.count == 0) {
                        data.inde = -100;
                        total-=2;
                        if(!total)
                            resolve(JSON.stringify(data))
                    } else {
                        total-=1;
                        let year = date.getFullYear();
                        let month = date.getMonth();

                        if (date.getMonth() == 0) {
                            year -= 1;
                            month = 12;
                        }

                        conn.query(RENTAL_DAYS_YEAR_MONTH, [params.vid, year, month], (err, res2 => {
                            if (err)
                                console.log("turnover_report QUERY: RENTAL_DAYS_YEAR_MONTH INNER");
                            if (res2)
                                if (res2.count == 0)
                                    data.inde = 100;
                                else
                                    data.inde = res1.days > res2.days ? ((res1.days - res2.days) / res2.days) * 100 : ((res2.days - res1.days) / res2.days) * -100
                                    total-=1;
                                    if(!total)
                                        resolve(JSON.stringify(data))
            

                        }))
                    }
                }
            })

            conn.query(RENTAL_MONTH_COUNTS, [params.vid, date.getFullYear()], (err, results) => {
                if (!err){
                    console.log("turnoverHelper Query: RENTAL_MONTH_COUNTS")
                    reject(err)
                } else if (results)
                    results.forEach(res => {
                        data.monthly_rentals[res.month - 1] = res.count;
                    });

                    total-=1;
                    if(!total)
                        resolve(JSON.stringify(data))
            })

        })
        return res;
    }

    async turnover_report(params) {
        const res = await new Promise((resolve, reject) => {
            if (params && Object.hasOwn(params, "vid")) {
            
                this.turnoverHelper({vid:params.vid,row: Object.hasOwn(params,"row") ? params.row : 0}).then((data)=>{
                    resolve(data)
                }).catch(err=>{
                    console.log(err);
                    reject(err);
                })

            } else {
                conn.query(FIRST_RENTAL_VID, (err, results) => {
                    if (err) {
                        reject(new Error(err.message))
                    }
                    else if (!results.length) {
                        resolve(NO_RESULTS);
                    }
                    else {//do something with data
                        this.turnoverHelper({vid:results[0].vehicle_id,row: 0}).then((data)=>{
                            resolve(data)
                        }).catch(err=>{
                            console.log(err);
                            reject(err);
                        })
                    }
                })
            }

        });
        return res;
    }

    async login(params) {
        const res = await new Promise((resolve, reject) => {
            conn.query(loginQuery, [params.email, params.password], (err, results) => {
                if (err) reject(new Error(err.message));
                else if (!results.length)
                    reject(JSON.stringify({ msg: "Invalid Login Credentials", res: results, params: params, err: err }))
                else {
                    resolve(JSON.stringify(results[0]));
                }
            });
        })
        return res;
    }

}

module.exports = RequestHandler;