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


const tableIds = {
    "customers": "customer_id",
    "vehicles": "license_plate_number",
    "vehicle_types": "vin",
    "rentals": "rental_id"
}

const queryOptions = {
    "customers": {
        "customer_id": null,
        "email": null,
        "first_name": null,
        "surname": null,
        "phone_number": null
    },
    "vehicles": {
        "license_plate_number": null,
        "vehicle_type": null,
    },
    "vehicle_types": {
        "brand": null,
        "model": null,
        "manufactured_year": null,
        "vin": null,
    },
    "rentals": {
        "lend_date": null,
        "return_date": null,
        "vehicle_id": null,
        "rental_id": null,
        "customer_id": null
    }

}




const defaultQueries = {
    "vehicle_types": "select * from vehicle_types where vin in (select distinct(vehicle_type) from vehicles)",
    "customers": "select * from vehicle_types right join (select customers.customer_id,first_name,surname,email,phone_number,license_issue_location,drivers_license,license_expiration_date,preferred_vehicle,address,preferred_dropoff,preferred_pickup,credit_card_expiration_date,billing_address, concat(substr(credit_card_number,1,4),'-xxxx-xxxx-xxxx') as credit_card_number, coalesce(count,0) as count from customers left join (select count(*) as count,customer_id from rentals group by customer_id) as x on x.customer_id = customers.customer_id) as y on y.preferred_vehicle = vin",
    "vehicles": "select * from vehicles,vehicle_types where vehicles.vehicle_type = vehicle_types.vin",
    "rentals": "select first_name,surname,drivers_license,phone_number,email,address,rentals.* from customers,rentals where customers.customer_id = rentals.customer_id"
}

const updateChecks = {
    "customers": {
        "email": {
            query: 'select customer_id from customers where email = ? and customer_id != ?',
            failString: 'Different Customer With The Same Email Already Exists',
            otherParams: ["__id"],
            bool: empty
        },
        "phone_number": {
            query: 'select customer_id from customers where phone_number = ? and customer_id != ?',
            failString: 'Different Customer With The Same Phone Number Already Exists',
            otherParams: ["__id"],
            bool: empty
        },
        "preferred_pickup": {
            query: 'select store_id from stores where store_id = ?',
            failString: 'Preferred Pickup Location Does Not Exist',
            otherParams: ["__id"],
            bool: notEmpty
        },
        "preferred_dropoff": {
            query: 'select store_id from stores where store_id = ?',
            failString: 'Preferred Dropoff Location Does Not Exist',
            otherParams: ["__id"],
            bool: notEmpty
        },
        "preferred_vehicle": {
            query: 'select vin from vehicle_types where vin = ? and vin in (select distinct(vehicle_type) from vehicles)',
            failString: 'No Cars Of The Specified Type Exist',
            otherParams: ["__id"],
            bool: notEmpty
        },
        "drivers_license": {
            query: 'select customer_id from customers where drivers_license = ? and customer_id != ?',
            failString: `Different Customer with the same driver's license exits`,
            otherParams: ["__id"],
            bool: empty
        }
    },

    "vehicles": {
        "vehicle_type": {
            query: 'select vin from vehicle_types where vin = ?',
            failString: 'No Vehicle Model WIth The Specified VIN Exists',
            otherParams: ["vehicle_type"],
            bool: notEmpty
        }
    }
}
/*
 * Used in inserts
 */
const insertChecks = {
    "customers": [
        {
            query: 'select customer_id from customers where email = ?',
            paramNames: ["email"],
            failString: 'Customer With The Same Email Already Exists',
            bool: empty
        },
        {
            query: 'select customer_id from customers where phone_number = ?',
            paramNames: ["phone_number"],
            failString: 'Customer With The Same Phone Number Already Exists',
            bool: empty
        },
        {
            query: 'select store_id from stores where store_id = ?',
            paramNames: ["preferred_pickup"],
            failString: 'Preferred Pickup Location Does Not Exist',
            bool: notEmpty
        },
        {
            query: 'select store_id from stores where store_id = ?',
            paramNames: ["preferred_dropoff"],
            failString: 'Preferred Dropoff Location Does Not Exist',
            bool: notEmpty
        },
        {
            query: 'select vin from vehicle_types where vin = ? and vin in (select distinct(vehicle_type) from vehicles)',
            paramNames: ["preferred_vehicle"],
            failString: 'No Cars Of The Specified Type Exist',
            bool: notEmpty
        },
        {
            query: 'select customer_id from customers where drivers_license = ? ',
            paramNames: ["drivers_license"],
            failString: `User with the same driver's license exits`,
            bool: empty
        }
    ],
    "vehicles": [
        {
            query: 'select license_plate_number from vehicles where license_plate_number = ?',
            paramNames: ["license_plate_number"],
            failString: 'Vehicle With The Same License Plate Already In The Fleet',
            bool: empty
        },
        {
            query: 'select vin from vehicle_types where vin = ?',
            paramNames: ["vehicle_type"],
            failString: 'Specified VIN Does Not Exist! ',
            bool: notEmpty
        },
    ],
    "vehicle_types": [
        {
            query: 'select vin from vehicle_types where vin = ?',
            paramNames: ["vin"],
            failString: 'Model With The Same VIN Already In The Fleet',
            bool: empty
        }
    ],
    "rentals": [
        {
            query: 'select license_plate_number from vehicles where license_plate_number = ?',
            paramNames: ["vehicle_id"],
            failString: 'The Specified Vehicle Does Not Exist',
            bool: notEmpty
        },
        {
            query: 'select rental_id from rentals where returned_date is null and customer_id = ?',
            paramNames: ["customer_id"],
            failString: 'Customer Has An Outstanding Rental',
            bool: empty
        }
    ]
}


conn.connect(function (err) {
    if (err) throw err;
    console.log("Connected!");
});

const NO_RESULTS = JSON.stringify({ error: 'NO_RESULTS' });

const RENTAL_DAYS = "select sum(if(datediff(return_date,lend_date)=0,1,datediff(return_date,lend_date))) as days, count(lend_date) as count from rentals where vehicle_id = ?";

const RENTAL_DAYS_YEAR = "select sum(if(datediff(return_date,lend_date)=0,1,datediff(return_date,lend_date))) as days, count(lend_date) as count from rentals where vehicle_id = ? and YEAR(lend_date) = ?";

const RENTAL_DAYS_YEAR_MONTH = "select sum(if(datediff(return_date,lend_date)=0,1,datediff(return_date,lend_date))) as days, count(lend_date) as count from rentals where vehicle_id = ? and YEAR(lend_date) = ? and MONTH(lend_date) = ?";

const RENTAL_MONTH_COUNTS = "select count(lend_date) as count, MONTH(lend_date) as month from rentals where vehicle_id = ? and YEAR(lend_date) = ? group by month(lend_date)";

const FIRST_LAST_RENTAL_VID = "(select count(vehicle_id) as count, vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc limit 1) union (select count(vehicle_id) as count, vehicle_id from rentals group by vehicle_id order by count asc, vehicle_id desc limit 1)";

const RENTAL_FROM_ROW = "select count(vehicle_id) as count,vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc limit ?, 1"

const CAR_TYPE_QUERY = "select * from vehicles, vehicle_types where vehicles.license_plate_number = ? and vehicles.vehicle_type = vehicle_types.vin"

const AVAILABLE_VEHICLES = "select * from vehicles where vehicles.license_plate_number not in (select distinct(vehicle_id) from rentals where returned_date is not null or lend_date > ?)"

const NONE_ = "No Data!";

const queryRegex = new RegExp(".+where.+[^)]$|.+where.+\(.+\)")

class RequestHandler {

    async availabilityReport(params){
        let data = {
            available : null,
            rented: null,
            reserved: null,
        }
        let res = null;

        if(params.type == "available"){
            res = await new Promise((resolve, reject) => {
                conn.query("select * from vehicle_types right join (select * from vehicles where license_plate_number not in (select distinct(vehicle_id) from rentals where returned_date is null)) as x on x.vehicle_type = vin;", (err, results) => {
                    if (err) {
                        reject(new Error(err.message))
                    }
                    resolve(JSON.stringify(results))
                })
            });
        }else if(params.type == "rented"){
            res = await new Promise((resolve, reject) => {
                conn.query("select * from vehicle_types right join (select * from vehicles where license_plate_number in (select distinct(vehicle_id) from rentals where returned_date is null and lend_date <= curdate())) as x on x.vehicle_type = vin;", (err, results) => {
                    if (err) {
                        reject(new Error(err.message))
                    }
                    resolve(JSON.stringify(results))
                })
            });
        } else if(params.type == "reserved"){
            res = await new Promise((resolve, reject) => {
                conn.query("select * from vehicle_types right join (select * from vehicles where license_plate_number in (select distinct(vehicle_id) from rentals where lend_date > curdate())) as x on x.vehicle_type = vin;;", (err, results) => {
                    if (err) {
                        reject(new Error(err.message))
                    }
                    resolve(JSON.stringify(results))
                })
            });
        }


        return res;

    }

    async LateReturns(params) {
        const res = await new Promise((resolve, reject) => {
            conn.query("select first_name, surname, drivers_license,phone_number,address,email,rentals.* from customers,rentals where customers.customer_id = rentals.customer_id and rentals.returned_date is null; ", (err, results) => {
                if (err) {
                    reject(new Error(err.message))
                }
                resolve(JSON.stringify(results))
            })
        });
        return res;
    }



    async CustNoOutRental(params) {
        const res = await new Promise((resolve, reject) => {
            conn.query("select customer_id, first_name, surname, drivers_license,phone_number from customers where customer_id not in (select customer_id from rentals where returned_date is null); ", (err, results) => {
                if (err) {
                    reject(new Error(err.message))
                }
                resolve(JSON.stringify(results))
            })
        });
        return res;
    }

    async availableVehicles(params) {
        const res = await new Promise((resolve, reject) => {
            console.log(this.availableVehicles)
            conn.query(AVAILABLE_VEHICLES,[new Date().toISOString().slice(0,10)], (err, results) => {
                if (err) {
                    reject(new Error(err.message))
                }
                resolve(JSON.stringify(results))
            })
        });
        return res;
    }

    async updateQuery(params) {

        const res = await new Promise((resolve, reject) => {
            if (!params)
                resolve("No Data");

            if (!Object.hasOwn(params, "table") || !params.table)
                resolve(JSON.stringify({ error: " TABLE NOT SPECIFIED" }));

            let id = null

            if (Object.hasOwn(params, "editId")) {
                id = params.editId
            }
            else
                id = params[tableIds[params.table]];

            let checks = []
            if (Object.hasOwn(updateChecks, params.table)) {
                let check = updateChecks[params.table]
                for (let key in check) {
                    if (Object.hasOwn(params, key)) {
                        checks.push(new Promise((resolve_, reject_) => {
                            let data = [params[key]];

                            for (let opt of updateChecks[params.table][key].otherParams)
                                if (opt == "__id")//use prev id
                                    data.push(id)
                                else
                                    data.push(params[opt])

                            conn.query(check[key].query, data, (err, res) => {
                                if (err)
                                    reject_(err)
                                if (res == undefined)
                                    console.log(`res: ${res}\nquery: ${check[key].query}\ndata:${data}`)
                                if (check[key].bool(res))
                                    resolve_(JSON.stringify({ null: null }));
                                else//send error back to client
                                    resolve(JSON.stringify({ error: check[key].failString }))
                            })
                        }))
                    }
                }
            }

            //after all checks construct and execute query
            Promise.all(checks).then(pass => {
                let base = `update ${params.table} set `
                let end = ` where ${tableIds[params.table]} = ?`
                let values = [];

                if (!Object.hasOwn(params, "editId"))
                    delete params[tableIds[params.table]]
                delete params.editId
                delete params.table;

                for (const [key, value] of Object.entries(params)) {
                    base += ` ${key} = ?,`
                    values.push(value)
                }

                base = base.slice(0, -1)//get rid of trailing ','

                values.push(id)

                conn.query(base + end, values, (err, result) => {
                    if (err)
                        reject(err)
                    resolve(JSON.stringify({ null: null }));
                })

            }).catch(err => {
                reject(err)
            })

        })

        return res;
    }

    async Query(params) {
        console.log(params)

        const res = await new Promise((resolve, reject) => {
            if (!params)
                resolve(NO_RESULTS);

            if (!Object.hasOwn(params, "table") || !params.table)
                resolve(JSON.stringify({ "error": " TABLE NOT SPECIFIED" }));

            let query = `select * from ${params.table}`;
            let data = [];

            if (Object.hasOwn(params, "default") && Object.hasOwn(defaultQueries, params.table))
                query = defaultQueries[params.table];

            if (Object.hasOwn(params, "options") && Object.keys(params.options).length) {
                if (queryRegex.test(query)) {
                    if (Object.hasOwn(params, "operators")) {
                        for (let opt in params.options) {
                            if (!params.options[opt])
                                continue;
                            if (Object.hasOwn(queryOptions[params.table], opt)) {
                                if (Object.hasOwn(params.operators, opt))
                                    query += ` and ${opt} ${params.operators[opt]} ?`
                                else
                                    query += ` and ${opt} = ?`
                                data.push(params.options[opt])
                            }
                        }
                        console.log(query)
                    } else {
                        for (let opt in params.options) {
                            if (!params.options[opt])
                                continue;

                            if (Object.hasOwn(queryOptions[params.table], opt)) {
                                query += ` and ${opt} = ?`
                                data.push(params.options[opt])
                            }
                        }
                    }
                } else {
                    query += " where"
                    if (Object.hasOwn(params, "operators")) {
                        for (let opt in params.options) {
                            if (!params.options[opt])
                                continue;

                            if (Object.hasOwn(queryOptions[params.table], opt)) {
                                if (Object.hasOwn(params.operators, opt))
                                    query += ` ${opt} ${params.operators[opt]} ? and`
                                else
                                    query += ` ${opt} = ? and`
                                data.push(params.options[opt])
                            }
                            console.log(query)
                        }
                    }
                    else{
                        console.log("else!!!")
                        for (let opt in params.options) {
                            if (!params.options[opt])
                                continue;
                            if (Object.hasOwn(queryOptions[params.table], opt)) {

                                query += ` ${opt} = ? and`
                                data.push(params.options[opt])
                            }


                        }
                    }
                        
                }

                if (query.slice(-3) == "and")
                    query = query.slice(0, query.length - 3)
                else if (query.slice(-5) == "where")
                    query = query.slice(0, query.length - 3)
            }

            console.log(query)
            console.log(data)

            conn.query(query, data, (err, results) => {
                if (err)
                    reject(err)
                resolve(JSON.stringify(results))
            })
        })
        return res;
    }

    //general function for adding to all columns;
    async insertQuery(params) {

        const res = await new Promise((resolve, reject) => {
            if (!params)
                resolve("No Data");

            if (!Object.hasOwn(params, "table") || !params.table)
                resolve(JSON.stringify({ error: " TABLE NOT SPECIFIED" }));

            let checks = []

            if (Object.hasOwn(insertChecks, params.table)) {
                insertChecks[params.table].forEach(check => {
                    checks.push(new Promise((resolve_, reject_) => {
                        let data = [];
                        check.paramNames.forEach(key => {
                            if (!Object.hasOwn(params, key) && params[key])
                                reject_(`Missing ${key} parameter can't validate query`);
                            data.push(params[key])
                        })
                        conn.query(check.query, data, (err, res) => {
                            if (err)
                                reject_(err)
                            if (res == undefined)
                                console.log(`res: ${res}\nquery: ${check.query}\ndata:${data}`)
                            if (check.bool(res))
                                resolve_("");
                            else//send error back to client
                                resolve(JSON.stringify({ error: check.failString }))
                        })

                    }))
                })
            }

            //after all checks construct and execute query
            Promise.all(checks).then(pass => {

                let base = `insert into ${params.table}(`

                delete params.table;
                delete params.date;

                let values = [];
                let hatena = "Values(";


                for (const [key, value] of Object.entries(params)) {
                    base += `${key},`
                    hatena += "?,";
                    values.push(value)
                }

                conn.query(`${base.substring(0, base.length - 1)}) ${hatena.substring(0, hatena.length - 1)})`, values, (err, result) => {
                    if (err)
                        reject(err)
                    resolve(JSON.stringify({ null: null }));
                })

            }).catch(err => {
                reject(err)
            })

        })

        return res;
    }


    async rental_exists(vid) {
        const res = await new Promise((resolve, reject) => {
            let query = "select exists(select * from rentals where vehicle_id = ?) as exist";
            conn.query(query, [vid], (err, results) => {
                if (err)
                    reject(err)
                else if (!results)
                    reject("err??? rental_exists")
                else
                    resolve(Boolean(results.exist));

            })
        })

        return res;
    }

    async rentalIdsLike(params) {
        let query = `select distinct(vehicle_id) from rentals where vehicle_id regexp ?`;
        const res = await new Promise((resolve, reject) => {
            conn.query(query, [params.regex], (err, res) => {
                if (err)
                    reject(err)
                resolve(JSON.stringify(res));
            })
        })
        return res;
    }

    async turnoverFromRowNumber(params) {
        console.log(params)
        const res = await new Promise((resolve, reject) => {
            if (params.row < 0)
                conn.query(FIRST_LAST_RENTAL_VID, (err, results) => {
                    if (err) {
                        reject(err);
                    } else if (!results) {
                        resolve(NO_RESULTS)
                    } else {
                        let query = "select count(*) as count from (select count(vehicle_id) as count,vehicle_id from rentals group by vehicle_id order by count desc, vehicle_id asc) as x";
                        conn.query(query, (err, res) => {
                            if (err)
                                reject(err);
                            resolve(this.turnover_report({ vid: results[1].vehicle_id, row: res.count - 1 }));
                        })
                    }
                })
            else
                conn.query(RENTAL_FROM_ROW, [params.row], (err, results) => {
                    if (err) {
                        console.log("turnover_next err")
                        console.log(err);
                        reject(err)
                    } else if (!results.length) {//either last or first
                        conn.query(FIRST_LAST_RENTAL_VID, (err, res) => {
                            if (err) {
                                reject(err);
                            } else if (!results) {
                                resolve(NO_RESULTS)
                            } else {
                                resolve(this.turnover_report({ row: 0, vid: res[0].vehicle_id }));
                            }
                        })

                    } else {
                        console.log("else else")
                        console.log(results)
                        resolve(this.turnover_report({ vid: results[0].vehicle_id, row: params.row }));
                    }
                })
        });
        return res;
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
            let query_base = "select first_name, surname,email, phone_number,drivers_license, if(datediff(returned_date,lend_date)=0,1,datediff(returned_date,lend_date)) as days, rentals.* from rentals, customers where rentals.customer_id = customers.customer_id";
            let query_end = " order by lend_date desc";

            let searchParams = [];
            let getInfo = false;

            if (params) {

                if (Object.hasOwn(params, "vid") && params.vid) {
                    query_base += " and vehicle_id = ?"
                    searchParams.push(params.vid)
                    getInfo = true;
                } else if (Object.hasOwn(params, "lend_date") && params.lend_date) {
                    query_base += " and lend_date >= ?"
                    searchParams.push(params.lend_date)
                } else if (Object.hasOwn(params, "return_date") && params.return_date) {
                    query_base += " and return_date <= ?"
                    searchParams.push(params.return_date)
                }

            }

            conn.query(query_base + query_end, searchParams, (err, results) => {
                if (err) {
                    console.log(err)
                    reject(new Error(err.message))
                }
                else if (!results.length) {
                    resolve(NO_RESULTS);
                }
                else {//do something with data

                    let data = { rentals: results }

                    if (getInfo)
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
        console.log("Helper:!!!")
        console.log(params);

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

            let total = 5;
            this.vehicleType(params.vid).then((res) => {
                data.typeinfo = res;
                total -= 1;
                if (!total)
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
                    data.total_rentals += res[0].count;
                }
                total -= 1;
                if (!total)
                    resolve(JSON.stringify(data))
            })

            let date = new Date()

            conn.query(RENTAL_DAYS_YEAR, [params.vid, date.getFullYear()], (err, res) => {
                if (err) {
                    console.log("turnover_report QUERY: RENTAL_DAYS_YEAR");
                    reject(err)
                } else {
                    data.year_rentals = res[0].count;
                    data.avg_rent_time = Math.round(res[0].days / res[0].count);
                    total -= 1;
                    if (!total)
                        resolve(JSON.stringify(data))
                }
            })

            conn.query(RENTAL_DAYS_YEAR_MONTH, [params.vid, date.getFullYear(), date.getMonth() + 1], (err, res1) => {
                if (err) {
                    console.log("turnover_report QUERY: RENTAL_DAYS_YEAR OUTER");
                    console.log(err)
                    reject(err)
                } else {
                    console.log("HERE!!!!!")
                    console.log(res1)
                    let year = date.getFullYear();
                    let month = date.getMonth();

                    if (date.getMonth() == 0) {
                        year -= 1;
                        month = 12;
                    }

                    conn.query(RENTAL_DAYS_YEAR_MONTH, [params.vid, year, month], (err, res2) => {
                        console.log(res2)
                        console.log("Here!!!!@@@@")
                        if (err)
                            console.log("turnover_report QUERY: RENTAL_DAYS_YEAR_MONTH INNER");
                        if (res2)
                            if (res2[0].count == 0)
                                data.inde = 100;
                            else if(res2[0].count == res1[0].count)
                                data.inde = 0
                            else {
                                let cur = res1[0].count
                                let prev = res2[0].count;
                                console.log(cur)
                                console.log(prev)

                                if (cur < prev){
                                    data.inde = (((prev - cur) / prev)) * -100
                                }
                                else if(cur > prev)
                                    data.inde = ((cur - prev) / prev) * 100

                                console.log(total)
                                console.log(data)
                                
                            }
                        total -= 1;
                        if (!total)
                            resolve(JSON.stringify(data))

                    })

                }
            })

            conn.query(RENTAL_MONTH_COUNTS, [params.vid, date.getFullYear()], (err, results) => {
                if (err) {
                    console.log("turnoverHelper Query: RENTAL_MONTH_COUNTS")
                    reject(err)
                } else if (results)
                    results.forEach(res => {
                        data.monthly_rentals[res.month - 1] = res.count;
                    });

                total -= 1;
                if (!total)
                    resolve(JSON.stringify(data))
            })

        })

        return res;
    }

    async turnover_report(params) {
        console.log("turnover: ")
        console.log(params)
        const res = await new Promise((resolve, reject) => {
            if (params && Object.hasOwn(params, "vid")) {

                this.turnoverHelper({ vid: params.vid, row: Object.hasOwn(params, "row") ? params.row : 0 }).then((data) => {
                    console.log("from helper!!!")
                    console.log(data)
                    resolve(data)
                }).catch(err => {
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
                        this.turnoverHelper({ vid: results[0].vehicle_id, row: 0 }).then((data) => {
                            console.log(data)
                            resolve(data)
                        }).catch(err => {
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