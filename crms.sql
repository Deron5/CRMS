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

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stores` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  `location` varchar(255) not null,
  PRIMARY KEY (`store_id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;


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


DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) not NULL,
  `surname` varchar(50) not NULL,
  `email` varchar(255) not NULL,
  `phone_number` varchar(14) not NULL,
  `drivers_license` varchar(14) not NULL,
  `license_issue_location` varchar(255) not NULL,
  `license_expiration_date` date not NULL,
  `preferred_vehicle` varchar(17) DEFAULT NULL,
  `address` varchar(255) not null,
  `preferred_dropoff` int default NULL,
  `preferred_pickup` int default NULL,
  `credit_card_number` varchar(19) not NULL,
  `credit_card_name` varchar(100) not null,
  `cvn` varchar(4) not null,
  `credit_card_expiration_date` date not null,
  PRIMARY KEY (`customer_id`),
  FOREIGN KEY (`preferred_vehicle`) references vehicle_types(`vin`),
  FOREIGN KEY (`preferred_pickup`) references stores(`store_id`),
  FOREIGN KEY (`preferred_dropoff`) references stores(`store_id`)
) ;


DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `interior_colour` varchar(10) not NULL,
  `exterior_colour` varchar(10) not NULL,
  `license_plate_number` varchar(10) NOT NULL,
  `odometer_reading` int  not null,
  `vehicle_type` varchar(17) NOT NULL,
  `condition` varchar(255) not null,
  PRIMARY KEY (`license_plate_number`),
  FOREIGN KEY (`vehicle_type`) references vehicles(`vin`)
) ;


DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `vehicle_id` varchar(10) NOT NULL,
  `rental_rate` varchar(255) not NULL,
  `lend_date` date not NULL,
  `return_date` date  not NULL,
  `returned_date` date default NULL,
  `lent_condition` varchar(255)  not NULL,
  `return_condition` varchar(255) default NULL,
  `rental_fee` float not NULL,
  `payment_method` varchar(10) not NULL,
  `extra_charges` varchar(255) default  null,
  PRIMARY KEY (`rental_id`),
  FOREIGN KEY (`vehicle_id`) references vehicles(`license_plate_number`),
  FOREIGN KEY (`customer_id`) references customers(`customer_id`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--



-- Dumping data for table `stores`
--

-- Table structure for table `vehicle_types`
--



--
-- Table structure for table `vehicles`
--




-- LOCK TABLES `customers` WRITE;
-- UNLOCK TABLES;

-- LOCK TABLES `vehicle_types` WRITE;
-- UNLOCK TABLES;


-- LOCK TABLES `rentals` WRITE;
-- UNLOCK TABLES;


-- LOCK TABLES `vehicles` WRITE;
-- UNLOCK TABLES;