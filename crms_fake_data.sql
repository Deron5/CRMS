#
# TABLE STRUCTURE FOR: customers
#

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) ,
  `surname` varchar(50) ,
  `email` varchar(255) ,
  `phone_number` varchar(15) ,
  `drivers_license` varchar(15) ,
  `issue_location` varchar(255) ,
  `expiration_date` date ,
  `prefered_vehicle` varchar(10) ,
  `rental_duration` varchar(5) ,
  `prefered_dropoff` int(11) ,
  `preferred_pickup` int(11) ,
  `password` varchar(25) ,
  `role` tinyint(3) unsigned ,
  PRIMARY KEY (`customer_id`),

) 
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (57, 'Hallie', 'O\'Reilly', 'josue49@example.com', '+85(9)097319871', '57 ul', NULL, '2010-04-29', NULL, NULL, NULL, NULL, '137c90ac46a8446464f62e9c5', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (5848511, 'Fabian', 'Zemlak', 'nbeatty@example.com', '+97(6)898927420', '79 ho', NULL, '2005-03-10', NULL, NULL, NULL, NULL, '2e2ce7a409fa0b1ce7c7626f3', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (68465534, 'Monte', 'Bayer', 'dudley.kemmer@example.net', '467.675.0658', '60 ve', NULL, '2003-11-07', NULL, NULL, NULL, NULL, '3bb22f3d2783c08e96cea8cfd', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (327153, 'Electa', 'Dickinson', 'hjakubowski@example.com', '(918)950-1584', '06 fg', NULL, '1971-03-28', NULL, NULL, NULL, NULL, '83f4ca58a884504867c0ec08d', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (13, 'Lilian', 'Padberg', 'sfadel@example.com', '427.338.4971', '53 la', NULL, '2008-03-20', NULL, NULL, NULL, NULL, '3a760aae4abd61c73266e3a62', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (8809403, 'Marquis', 'Willms', 'litzy.crist@example.org', '(221)767-6479x8', '63 nv', NULL, '1997-12-06', NULL, NULL, NULL, NULL, '0d40f97e3337a9d9729b76d13', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (18065, 'Rodger', 'Volkman', 'sebastian43@example.org', '719-994-4033x43', '56 yw', NULL, '2001-04-19', NULL, NULL, NULL, NULL, 'f9f0eeb83dee6cc5cda444cef', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (6175481, 'Makayla', 'Mertz', 'ylesch@example.net', '249-649-7101x53', '69 im', NULL, '1984-05-09', NULL, NULL, NULL, NULL, 'ae6af88e1da51b6c04676ddfb', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (688518, 'Althea', 'Reynolds', 'hunter03@example.net', '1-040-958-7553x', '48 db', NULL, '2022-12-10', NULL, NULL, NULL, NULL, 'b526bb467723008b52ce90f1d', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (15356304, 'Maryjane', 'O\'Reilly', 'graham.florian@example.org', '+37(2)815075091', '90 ct', NULL, '2017-10-25', NULL, NULL, NULL, NULL, '901902cd0d741b19c8d14c967', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (4, 'Rosanna', 'Krajcik', 'whitney10@example.org', '495.872.2978x86', '78 bq', NULL, '1979-11-27', NULL, NULL, NULL, NULL, 'e0f78ba3e19c99de44867954b', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (0, 'Ebony', 'Nader', 'fyundt@example.net', '1-000-543-9898', '42 nr', NULL, '1991-11-26', NULL, NULL, NULL, NULL, '72ee2669148b4da54ec93870b', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (370, 'Marianna', 'Kiehn', 'colby79@example.org', '271.279.8274', '05 tw', NULL, '1989-12-21', NULL, NULL, NULL, NULL, 'e6807114c9c0e76d31e7a520a', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (1, 'Jayson', 'Bechtelar', 'blanca00@example.net', '01687264854', '51 ie', NULL, '2013-07-02', NULL, NULL, NULL, NULL, '8f5b0b78a4208b08623705304', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (8695096, 'Arlo', 'Armstrong', 'cjohnson@example.com', '039-693-9158x86', '82 oi', NULL, '1973-09-21', NULL, NULL, NULL, NULL, 'ff2ab1ade187eaa63294e827c', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (1655106, 'Moses', 'Smitham', 'marlene36@example.org', '1-327-205-0587', '30 hw', NULL, '1979-12-25', NULL, NULL, NULL, NULL, '57a6c241367e6ee665365b809', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (810640, 'Chanelle', 'Wehner', 'deontae49@example.org', '(633)386-2924x0', '43 at', NULL, '2002-04-09', NULL, NULL, NULL, NULL, '0ff941560d4f6b5acc861e4bf', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (59465, 'Levi', 'Cremin', 'alueilwitz@example.org', '(263)087-4379', '45 xu', NULL, '2003-09-04', NULL, NULL, NULL, NULL, 'f4622d8f3bf2827906827d460', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (95, 'Leila', 'Smitham', 'libbie.marquardt@example.net', '1-832-038-4402x', '34 rj', NULL, '2011-01-18', NULL, NULL, NULL, NULL, '8c7a11ed4dc31f3d021e40885', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (15315, 'Alejandrin', 'Greenholt', 'rebert@example.com', '1-728-780-5468x', '19 ak', NULL, '1974-09-07', NULL, NULL, NULL, NULL, 'fea0694c824019d724eb516a8', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (412419, 'Peggie', 'Grant', 'jarrett57@example.com', '464.457.4474x85', '07 em', NULL, '2003-01-01', NULL, NULL, NULL, NULL, '88c497c0f3b7334962e8beead', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (898973, 'Nikita', 'Aufderhar', 'caltenwerth@example.com', '1-575-662-1404x', '60 jt', NULL, '2018-11-24', NULL, NULL, NULL, NULL, 'bd334907b09954cd25c8c1ddd', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (1620566, 'Casimir', 'Schuppe', 'madalyn.bechtelar@example.com', '1-551-667-7401x', '31 bk', NULL, '2018-10-05', NULL, NULL, NULL, NULL, 'd19b0782e0b1399efe597db4f', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (3473235, 'Evans', 'Donnelly', 'cruickshank.elda@example.net', '219.964.3730x15', '58 iv', NULL, '1978-06-13', NULL, NULL, NULL, NULL, '27c2067c144ffb827d907e06c', NULL);
INSERT INTO `customers` (`customer_id`, `first_name`, `surname`, `email`, `phone_number`, `drivers_license`, `issue_location`, `expiration_date`, `prefered_vehicle`, `rental_duration`, `prefered_dropoff`, `preferred_pickup`, `password`, `role`) VALUES (7580881, 'Landen', 'Stokes', 'connor09@example.com', '(214)449-5441x3', '41 qm', NULL, '2002-02-03', NULL, NULL, NULL, NULL, '4eaf83165c7a6656040871370', NULL);


#
# TABLE STRUCTURE FOR: rentals
#

DROP TABLE IF EXISTS `rentals`;

CREATE TABLE `rentals` (
  `customer_id` int(11) ,
  `vehicle_id` varchar(10) ,
  `rental_Rate` varchar(255) ,
  `additional_charges` varchar(255) ,
  `lend_date` date ,
  `return_date` date ,
  `lent_condition` varchar(255) ,
  `return_condition` varchar(255) ,
  `rental_fee` float ,
  `payment_method` varchar(10) ,
  `paid` tinyint(1) ,
  PRIMARY KEY (`customer_id`,`vehicle_id`),
  KEY `vehicle_id` (`vehicle_id`)
) 

INSERT INTO `rentals` (`customer_id`, `vehicle_id`, `rental_Rate`, `additional_charges`, `lend_date`, `return_date`, `lent_condition`, `return_condition`, `rental_fee`, `payment_method`, `paid`) VALUES (0, '2', NULL, NULL, '2005-02-06', '0000-00-00', 'l', NULL, '212', 'Visa', NULL);
INSERT INTO `rentals` (`customer_id`, `vehicle_id`, `rental_Rate`, `additional_charges`, `lend_date`, `return_date`, `lent_condition`, `return_condition`, `rental_fee`, `payment_method`, `paid`) VALUES (1, '262', NULL, NULL, '2007-08-11', '1986-03-27', 't', NULL, '180', 'Visa', NULL);
INSERT INTO `rentals` (`customer_id`, `vehicle_id`, `rental_Rate`, `additional_charges`, `lend_date`, `return_date`, `lent_condition`, `return_condition`, `rental_fee`, `payment_method`, `paid`) VALUES (4, '29269', NULL, NULL, '2009-07-09', '0000-00-00', 'b', NULL, '415', 'Visa', NULL);
INSERT INTO `rentals` (`customer_id`, `vehicle_id`, `rental_Rate`, `additional_charges`, `lend_date`, `return_date`, `lent_condition`, `return_condition`, `rental_fee`, `payment_method`, `paid`) VALUES (13, '4', NULL, NULL, '2017-06-26', '1974-11-23', 'c', NULL, '409', 'MasterCard', NULL);
INSERT INTO `rentals` (`customer_id`, `vehicle_id`, `rental_Rate`, `additional_charges`, `lend_date`, `return_date`, `lent_condition`, `return_condition`, `rental_fee`, `payment_method`, `paid`) VALUES (57, '4998701', NULL, NULL, '1977-08-09', '0000-00-00', 'o', NULL, '246', 'Visa', NULL);


#
# TABLE STRUCTURE FOR: stores
#

DROP TABLE IF EXISTS `stores`;

CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`store_id`)
) ;

#
# TABLE STRUCTURE FOR: vehicle_types
#

DROP TABLE IF EXISTS `vehicle_types`;

CREATE TABLE `vehicle_types` (
  `brand` varchar(25) ,
  `model` varchar(255) ,
  `manufactured_year` year(4) ,
  `vin` varchar(17),
  PRIMARY KEY (`vin`)
) ;

INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('c', 'b', '2014', 'facere');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('j', 'd', '1972', 'a');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('i', 'x', '1976', 'ipsum');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('q', 'f', '1991', 'quaerat');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('g', 'f', '2005', 'tempore');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('y', 'c', '2013', 'in');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('b', 'g', '1987', 'placeat');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('z', 'm', '1992', 'aut');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('k', 'z', '2005', 'quos');
INSERT INTO `vehicle_types` (`brand`, `model`, `manufactured_year`, `vin`) VALUES ('f', 'z', '1982', 'enim');


#
# TABLE STRUCTURE FOR: vehicles
#

DROP TABLE IF EXISTS `vehicles`;

CREATE TABLE `vehicles` (
  `interior_colour` varchar(10) ,
  `exterior_colour` varchar(10) ,
  `license_plate_number` varchar(10) ,
  `odometer_reading` int(11) ,
  `vehicle_type` varchar(17) ,
  PRIMARY KEY (`license_plate_number`),
  KEY `vehicle_type` (`vehicle_type`)
) ;

INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('i', 'e', '84128479', 7, 'a');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('m', 'q', '5614', 8, 'aut');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('h', 'c', '4998701', 4, 'enim');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('y', 'n', '4', 9, 'facere');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('a', 'j', '68681294', 9, 'in');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('o', 'e', '711692691', 5, 'ipsum');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('w', 'z', '2', 7, 'placeat');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('y', 'h', '262', 8, 'quaerat');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('s', 'f', '29269', 4, 'quos');
INSERT INTO `vehicles` (`interior_colour`, `exterior_colour`, `license_plate_number`, `odometer_reading`, `vehicle_type`) VALUES ('d', 'f', '5', 4, 'tempore');


