-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: crms
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `surname` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `drivers_license` varchar(15) DEFAULT NULL,
  `issue_location` varchar(255) DEFAULT NULL,
  `expiration_date` date DEFAULT NULL,
  `prefered_vehicle` varchar(10) DEFAULT NULL,
  `rental_duration` varchar(5) DEFAULT NULL,
  `prefered_dropoff` int DEFAULT NULL,
  `preferred_pickup` int DEFAULT NULL,
  `password` varchar(25) DEFAULT NULL,
  `role` tinyint unsigned DEFAULT NULL,
  `credit_card_number` varchar(19) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `prefered_vehicle` (`prefered_vehicle`),
  KEY `preferred_pickup` (`preferred_pickup`),
  KEY `prefered_dropoff` (`prefered_dropoff`),
  KEY `email` (`email`(250))
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (57,'Hallie','O\'Reilly','josue49@example.com','+85(9)097319871','57 ul',NULL,'2010-04-29',NULL,NULL,NULL,NULL,'137c90ac46a8446464f62e9c5',NULL,NULL),(5848511,'Fabian','Zemlak','nbeatty@example.com','+97(6)898927420','79 ho',NULL,'2005-03-10',NULL,NULL,NULL,NULL,'2e2ce7a409fa0b1ce7c7626f3',NULL,NULL),(68465534,'Monte','Bayer','dudley.kemmer@example.net','467.675.0658','60 ve',NULL,'2003-11-07',NULL,NULL,NULL,NULL,'3bb22f3d2783c08e96cea8cfd',NULL,NULL),(327153,'Electa','Dickinson','hjakubowski@example.com','(918)950-1584','06 fg',NULL,'1971-03-28',NULL,NULL,NULL,NULL,'83f4ca58a884504867c0ec08d',NULL,NULL),(13,'Lilian','Padberg','sfadel@example.com','427.338.4971','53 la',NULL,'2008-03-20',NULL,NULL,NULL,NULL,'3a760aae4abd61c73266e3a62',NULL,NULL),(8809403,'Marquis','Willms','litzy.crist@example.org','(221)767-6479x8','63 nv',NULL,'1997-12-06',NULL,NULL,NULL,NULL,'0d40f97e3337a9d9729b76d13',NULL,NULL),(18065,'Rodger','Volkman','sebastian43@example.org','719-994-4033x43','56 yw',NULL,'2001-04-19',NULL,NULL,NULL,NULL,'f9f0eeb83dee6cc5cda444cef',NULL,NULL),(6175481,'Makayla','Mertz','ylesch@example.net','249-649-7101x53','69 im',NULL,'1984-05-09',NULL,NULL,NULL,NULL,'ae6af88e1da51b6c04676ddfb',NULL,NULL),(688518,'Althea','Reynolds','hunter03@example.net','1-040-958-7553x','48 db',NULL,'2022-12-10',NULL,NULL,NULL,NULL,'b526bb467723008b52ce90f1d',NULL,NULL),(15356304,'Maryjane','O\'Reilly','graham.florian@example.org','+37(2)815075091','90 ct',NULL,'2017-10-25',NULL,NULL,NULL,NULL,'901902cd0d741b19c8d14c967',NULL,NULL),(4,'Rosanna','Krajcik','whitney10@example.org','495.872.2978x86','78 bq',NULL,'1979-11-27',NULL,NULL,NULL,NULL,'e0f78ba3e19c99de44867954b',NULL,NULL),(0,'Ebony','Nader','fyundt@example.net','1-000-543-9898','42 nr',NULL,'1991-11-26',NULL,NULL,NULL,NULL,'72ee2669148b4da54ec93870b',NULL,NULL),(370,'Marianna','Kiehn','colby79@example.org','271.279.8274','05 tw',NULL,'1989-12-21',NULL,NULL,NULL,NULL,'e6807114c9c0e76d31e7a520a',NULL,NULL),(1,'Jayson','Bechtelar','blanca00@example.net','01687264854','51 ie',NULL,'2013-07-02',NULL,NULL,NULL,NULL,'8f5b0b78a4208b08623705304',NULL,NULL),(8695096,'Arlo','Armstrong','cjohnson@example.com','039-693-9158x86','82 oi',NULL,'1973-09-21',NULL,NULL,NULL,NULL,'ff2ab1ade187eaa63294e827c',NULL,NULL),(1655106,'Moses','Smitham','marlene36@example.org','1-327-205-0587','30 hw',NULL,'1979-12-25',NULL,NULL,NULL,NULL,'57a6c241367e6ee665365b809',NULL,NULL),(810640,'Chanelle','Wehner','deontae49@example.org','(633)386-2924x0','43 at',NULL,'2002-04-09',NULL,NULL,NULL,NULL,'0ff941560d4f6b5acc861e4bf',NULL,NULL),(59465,'Levi','Cremin','alueilwitz@example.org','(263)087-4379','45 xu',NULL,'2003-09-04',NULL,NULL,NULL,NULL,'f4622d8f3bf2827906827d460',NULL,NULL),(95,'Leila','Smitham','libbie.marquardt@example.net','1-832-038-4402x','34 rj',NULL,'2011-01-18',NULL,NULL,NULL,NULL,'8c7a11ed4dc31f3d021e40885',NULL,NULL),(15315,'Alejandrin','Greenholt','rebert@example.com','1-728-780-5468x','19 ak',NULL,'1974-09-07',NULL,NULL,NULL,NULL,'fea0694c824019d724eb516a8',NULL,NULL),(412419,'Peggie','Grant','jarrett57@example.com','464.457.4474x85','07 em',NULL,'2003-01-01',NULL,NULL,NULL,NULL,'88c497c0f3b7334962e8beead',NULL,NULL),(898973,'Nikita','Aufderhar','caltenwerth@example.com','1-575-662-1404x','60 jt',NULL,'2018-11-24',NULL,NULL,NULL,NULL,'bd334907b09954cd25c8c1ddd',NULL,NULL),(1620566,'Casimir','Schuppe','madalyn.bechtelar@example.com','1-551-667-7401x','31 bk',NULL,'2018-10-05',NULL,NULL,NULL,NULL,'d19b0782e0b1399efe597db4f',NULL,NULL),(3473235,'Evans','Donnelly','cruickshank.elda@example.net','219.964.3730x15','58 iv',NULL,'1978-06-13',NULL,NULL,NULL,NULL,'27c2067c144ffb827d907e06c',NULL,NULL),(7580881,'Landen','Stokes','connor09@example.com','(214)449-5441x3','41 qm',NULL,'2002-02-03',NULL,NULL,NULL,NULL,'4eaf83165c7a6656040871370',NULL,NULL),(10,NULL,NULL,'admin@crms.com',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'password',10,NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `customer_id` int NOT NULL,
  `vehicle_id` varchar(10) NOT NULL,
  `rental_Rate` varchar(255) DEFAULT NULL,
  `additional_charges` varchar(255) DEFAULT NULL,
  `lend_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  `lent_condition` varchar(255) DEFAULT NULL,
  `return_condition` varchar(255) DEFAULT NULL,
  `rental_fee` float DEFAULT NULL,
  `payment_method` varchar(10) DEFAULT NULL,
  `paid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`customer_id`,`vehicle_id`),
  KEY `vehicle_id` (`vehicle_id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (0,'2',NULL,NULL,'2005-02-06','0000-00-00','l',NULL,212,'Visa',NULL),(1,'262',NULL,NULL,'2007-08-11','1986-03-27','t',NULL,180,'Visa',NULL),(4,'29269',NULL,NULL,'2009-07-09','0000-00-00','b',NULL,415,'Visa',NULL),(13,'4',NULL,NULL,'2017-06-26','1974-11-23','c',NULL,409,'MasterCard',NULL),(57,'4998701',NULL,NULL,'1977-08-09','0000-00-00','o',NULL,246,'Visa',NULL);
/*!40000 ALTER TABLE `rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`store_id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
/*!40000 ALTER TABLE `stores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle_types`
--

DROP TABLE IF EXISTS `vehicle_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle_types` (
  `brand` varchar(25) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `manufactured_year` year DEFAULT NULL,
  `vin` varchar(17) NOT NULL,
  PRIMARY KEY (`vin`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_types`
--

LOCK TABLES `vehicle_types` WRITE;
/*!40000 ALTER TABLE `vehicle_types` DISABLE KEYS */;
INSERT INTO `vehicle_types` VALUES ('c','b',2014,'facere'),('j','d',1972,'a'),('i','x',1976,'ipsum'),('q','f',1991,'quaerat'),('g','f',2005,'tempore'),('y','c',2013,'in'),('b','g',1987,'placeat'),('z','m',1992,'aut'),('k','z',2005,'quos'),('f','z',1982,'enim');
/*!40000 ALTER TABLE `vehicle_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `interior_colour` varchar(10) DEFAULT NULL,
  `exterior_colour` varchar(10) DEFAULT NULL,
  `license_plate_number` varchar(10) NOT NULL,
  `odometer_reading` int DEFAULT NULL,
  `vehicle_type` varchar(17) NOT NULL,
  PRIMARY KEY (`license_plate_number`),
  KEY `vehicle_type` (`vehicle_type`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES ('i','e','84128479',7,'a'),('m','q','5614',8,'aut'),('h','c','4998701',4,'enim'),('y','n','4',9,'facere'),('a','j','68681294',9,'in'),('o','e','711692691',5,'ipsum'),('w','z','2',7,'placeat'),('y','h','262',8,'quaerat'),('s','f','29269',4,'quos'),('d','f','5',4,'tempore');
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-02 17:19:37
