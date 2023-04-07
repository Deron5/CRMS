const mysql = require('mysql2');
const conn = mysql.createConnection({
    host: "localhost",  //host ip address
    user: "root", //username
    password: "", //password for the user
    database: "crms", //database name
});

const loginQuery = `select role from customers where email = ? and password = ?`;

const customerRentalsQuery = `select * from rentals, customers, vehicle_types, vehicles 
                            where rentals.customer_id = customers.customer_id and 
                            rentals.vehicle_id = vehicles.license_plate_number and 
                            vehicles.vehicle_type = vehicle_types.vin`;

const FIRST_RENTAL_VID = "select count(vehicle_id) as count,vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc limit 1"

conn.connect(function (err) {
    if (err) throw err;
    console.log("Connected!");
});

const NO_RESULTS = 'NO_RESULTS';

const RENTALS_YEAR_MONTH_QUERY = "select * from rentals where vehicle_id = ? and YEAR(lend_date) = ? and MONTH(date) = ?"

const RENTAL_DAYS = "select sum(datediff(lend_date,return_date)) as days, count(lend_date) as count from rentals where vehicle_id = ?";

const RENTAL_DAYS_YEAR = "select sum(datediff(lend_date,return_date)) as days, count(lend_date) as count from rentals where vehicle_id = ? and YEAR(lend_date) = ?";

const RENTAL_DAYS_YEAR_MONTH = "select sum(datediff(lend_date,return_date)) as days, count(lend_date) as count from rentals where vehicle_id = ? and YEAR(lend_date) = ? and MONTH(lend_date) = ?";

const RENTAL_MONTH_COUNTS = "select count(lend_date) as count, MONTH(lend_date) as month from rentals group by month(lend_date) where vehicle_id = ? and year = ?";

const SPECIFIC_YEAR_RENTALS_QUERY = "select * from rentals where vehicle_id = ? and Year(lend_date)> ? order by lend_date"

const FIRST_LAST_RENTAL_VID = "(select count(vehicle_id) as count, vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc limit 1) union (select count(vehicle_id) as count, vehicle_id from rentals group by vehicle_id order by count asc, vehicle_id desc limit 1)";

// const NEXT_RENTAL_VID = "select min(vehicle_id) from rentals where vehicle_id > ?";
// const PREV_RENTAL_VID = "select max(vehicle_id) from rentals where vehicle_id < ?";

// const LAST_RENTAL_VID = "select max(vehicle_id) from rentals"

const RENTAL_FROM_ROW = "select count(vehicle_id) as count,vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc limit ?, 1"

const CAR_TYPE_QUERY = "select * from vehicles, vehicle_types where vehicles.license_plate_number = ? and vehicles.vehicle_type = vehicle_types.vin"

/** Queries //just didn't bother making them variables yet
 customer rentals history;
select * from rentals, customers, vehicle_types, vehicles where rentals.customer_id = ? and rentals.vehicle_id = vehicles.license_plate_number and vehicles.vehicle_type = vehicle_types.vin; 
select * from customers where customer_id = ?

rental history report;
select * from rentals, vehicle_types, vehicles where rentals.vehicle_id = ? and rentals.vehicle_id = vehicles.license_plate_number and vehicles.vehicle_type = vehicle_types.vin; 

late return report;
select * from rentals, customers where rentals.customer_id = customers.customer_id and rentals.return_condition is null;


vehicle turnover report
1) get unique vehicles
    select distinct vehicle_id from rentals;
2) send that back to the user with the turnover rate for the first vehicle
3) user clicks next and searches for the remaining  
select * from rentals,vehicles, vehicle_types where rentals.vehicle_id = ? and rentals.vehicle_id = vehicles.license_plate_number and vehicles.vehicle_type = vehicle_types.vin;



vehicle availability report (how would i do this?)


default rental query
select * from rentals,vehicles, vehicle_types where rentals.vehicle_id = ? and vehicles.vehicle_type = vehicle_types.vin;


default customer_rental query
 */

/* Query Template

        const res = await new Promise((resolve,reject)=>{
            conn.query(UNIQUE_RENTALS_QUERY, (err,results)=>{
                    if(err) {
                        reject(new Error(err.message))
                    }
                    else if(!results.length) {
                        reject(NO_RESULTS);
                    }
                    else{//do something with data

                    }
                })
            });
        return res;
*/

const NONE_ = "No Data!";

class RequestHandler {

    //handles all search queries by constructing the query string based on the parameters sent.
    async Query(params) {
        $format = true;

        if (get_object_vars(params) < 1)
            return NO_RESULTS;

        if (!property_exists(params, "table"))
            return json_encode({ "error": " TABLE NOT SPECIFIED" });

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
                        reject(NO_RESULTS )
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
                                    reject(NO_RESULTS )
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
                    reject(NO_RESULTS);
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
                }else if(Object.hasOwn(params,"lend_date") && params.lend_date ){
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
                    reject(NO_RESULTS);
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
                        reject(NO_RESULTS);
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