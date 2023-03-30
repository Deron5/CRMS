const mysql = require('mysql2');
const conn = mysql.createConnection({
    host: "localhost",  //host ip address
    user: "root", //username
    password: "", //password for the user
    database: "crms", //database name
});

const customerRentalsQuery = `select * from rentals, customers, vehicle_types, vehicles 
                            where rentals.customer_id = customers.customer_id and 
                            rentals.vehicle_id = vehicles.license_plate_number and 
                            vehicles.vehicle_type = vehicle_types.vin`;


conn.connect(function (err) {
    if (err) throw err;
    console.log("Connected!");
});

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
}

module.exports = RequestHandler;