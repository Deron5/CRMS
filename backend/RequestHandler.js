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

conn.connect(function (err) {
    if (err) throw err;
    console.log("Connected!");
});

const NO_RESULTS = 'empty result-set';

const RENTALS_QUERY = "select * from rentals where vehicle_id = ?";

const FIRST_RENTAL = "select * from rentals order by vehicle_id limit 1";
const NEXT_RENTAL_QUERY = "select * from rentals where vehicle_id = (select min(vehicle_id) from rentals where vehicle_id > ?)";
const PREV_RENTAL_QUERY = "select * from rentals where vehicle_id = (select max(vehicle_id) from rentals where vehicle_id < ?)";


const CAR_TYPE_QUERY = "select * from vehicles, vehicle_types where vehicles.license_plate_number = ? and vehicles.vehicle_type = vehicle_types.vin"


const UNIQUE_RENTALS_QUERY = "select distinct vehicle_id from rentals";

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

class RequestHandler{

      //handles all search queries by constructing the query string based on the parameters sent.
      async Query(params){
        $format = true;

        if (get_object_vars(params) < 1)
            return NONE_;

        if (!property_exists(params, "table"))
            return json_encode({"error" : " TABLE NOT SPECIFIED"});

    }

    //returns data for a vehicle report
    async vehicle_report(){
      
    }

    //returns data for a customer rental report
    async customer_report(){

    }

    //returns data for a rental report
    async rental_report(){
        return new Promise((resolve,reject)=>{
            resolve(JSON.stringify(["stuffstuff"]));
        })
    }

    //returns data for a vehicle availability report
    async availability_report()
    {

    }

    async late_return_report()
    {

    }

    async vehicleType(vid){
        const res = await new Promise((resolve,reject)=>{
            conn.query(CAR_TYPE_QUERY,[vid], (err,results)=>{
                    if(err) {
                        reject(new Error(err.message))
                    }
                    else if(!results.length) {
                        reject(NO_RESULTS);
                    }
                    else{//do something with data
                        resolve(results)
                    }
                })
            });
        return res;
    }

    //takes a vehicle id and gets all rentals related to said vehicle
    //returns an object with the data and the vehicle info
    async rentals(vid)
    {
        const res = await new Promise((resolve,reject)=>{
            conn.query(RENTALS_QUERY,[vid], (err,results)=>{
                    if(err) {
                        reject(new Error(err.message))
                    }
                    else if(!results.length) {
                        reject(NO_RESULTS);
                    }
                    else{//do something with data
                        this.vehicleType(vid).then(res=>{
                            let data = {rentals: results, typeinfo: res}

                            resolve(JSON.stringify(data))

                        }).catch(err => reject(new Error(err.message)))
                    }
                })
            });
        return res;

    }


    async getRentalVehicles(){
        const res = await new Promise((resolve,reject)=>{
            conn.query(UNIQUE_RENTALS_QUERY, (err,results)=>{
                let data = []
                if(err) reject(new Error(err.message))
                else if(!results.length){
                    reject(NO_RESULTS);
                }else{
                    results.forEach(res => {
                        data.push(res.vehicle_id)
                    });
                    
                    data = {ids:data,first:null};
                    this.rentals(data.ids[0]).then(res=>{
                        data.first = JSON.parse(res);
                        resolve(JSON.stringify(data));
                    }).catch( err => reject(new Error(err.message)))

                }
            })
        });
        return res;
    }


    async login(params){
        const res = await new Promise((resolve,reject)=>{
            conn.query(loginQuery,[params.email,params.password], (err,results)=>{
                if(err) reject(new Error(err.message));
                else if(!results.length)
                    reject(JSON.stringify({msg:"Invalid Login Credentials",res:results,params:params,err:err}))
                else{
                    resolve(JSON.stringify(results[0]));
                }
            });
        })
        return res;
    }

}

module.exports = RequestHandler;