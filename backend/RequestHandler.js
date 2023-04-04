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

const RENTALS_QUERY = "select * from rentals where vehicle_id = ? order by lend_date"

const SPECIFIC_YEAR_RENTALS_QUERY = "select * from rentals where vehicle_id = ? and Year(lend_date)> ? order by lend_date"


const FIRST_RENTAL = "select count(vehicle_id) as c, vehicle_id from rentals group by vehicle_id order by c desc limit 1";

const NEXT_RENTAL_QUERY = "select * from rentals where vehicle_id = (select min(vehicle_id) from rentals where vehicle_id > ?)";
const PREV_RENTAL_QUERY = "select * from rentals where vehicle_id = (select max(vehicle_id) from rentals where vehicle_id < ?)";


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
                        resolve(results[0])
                    }
                })
            });
        return res;
    }

    //takes a vehicle id and gets all rentals related to said vehicle
    //returns an object with the data and the vehicle info
    async getVehicleRentals(params)
    {
        const res = await new Promise((resolve,reject)=>{
            if(params && Object.hasOwn(params,"vid")){
                conn.query(RENTALS_QUERY,[params.vid], (err,results)=>{
                    if(err) {
                        reject(new Error(err.message))
                    }
                    else if(!results.length) {
                        reject(NO_RESULTS);
                    }
                    else{//do something with data
                        this.vehicleType(params.vid).then(res=>{
                            let data = {rentals: results, typeinfo: res}

                            resolve(JSON.stringify(data))

                        }).catch(err => {
                            console.log("getVehicleRentals from call to vehicleType")
                            reject(err)
                        })
                    }
                })
            }else{
                reject(new Error("No vID Given"))
            }    
            
            });
        return res;

    }

    async turnover_report(params){
        const res = await new Promise((resolve,reject)=>{
            if(params && Object.hasOwn(params,"vid")){
                return this.getVehicleRentals(params);
            } else{
                conn.query(FIRST_RENTAL, (err,results)=>{
                    if(err) {
                        reject(new Error(err.message))
                    }
                    else if(!results.length) {
                        reject(NO_RESULTS);
                    }
                    else{//do something with data
                        this.getVehicleRentals({vid:results[0].vehicle_id}).then(data=>{
                            resolve(this.formatTurnoverReport(JSON.parse(data)));
                        }).catch(err=>{
                            console.log("turnover_report from call to getVehicleRentals");
                            reject(err)
                        })
                    }
                })
            }
                
        });
        return res;
    }

    formatTurnoverReport(queryResults) {
        let data = {
            license:queryResults.rentals[0].vehicle_id,
            typeinfo: queryResults.typeinfo,
            monthly_rentals:[8,5,1,2,5,10,5,7,4,3,0,2],
            year_rentals: 0,    
            total_rentals: queryResults.rentals.length,
            avg_rent_time: null,
        }
        let rentDays = 0;
        let current_year = new Date().getFullYear();

        queryResults.rentals.forEach(element => {
            let dateInfo = element.lend_date.split("-").map(Number);
            //dateInfo = [year,month,day]
            if(dateInfo[0] == current_year){
                Monthly_Rentals[dateInfo[1]-1]+=1;
                Year_Rentals+=1;
            }
            rentDays += Math.round((new Date(element.lend_date) -new Date(element.retrun_date) )/((1000 * 60 * 60 * 24)) )
            
        });

        data.avg_rent_time = (rentDays/data.total_rentals) || 0;
        return JSON.stringify(data);
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