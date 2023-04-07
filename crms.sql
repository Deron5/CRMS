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
  FOREIGN KEY `prefered_vehicle` references vehicle_types(`vin`),
  FOREIGN KEY `preferred_pickup` references stores(`store_id`),
  FOREIGN KEY `prefered_dropoff` references stores(`store_id`),
) ;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `rental_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `vehicle_id` varchar(10) NOT NULL,
  `rental_Rate` varchar(255) DEFAULT not NULL,
  `lend_date` date DEFAULT not NULL,
  `return_date` date DEFAULT not NULL,
  `returned_date` date DEFAULT NULL,
  `lent_condition` varchar(255) DEFAULT not NULL,
  `return_condition` varchar(255) DEFAULT NULL,
  `rental_fee` float DEFAULT NULL,
  `payment_method` varchar(10) DEFAULT NULL,
  `extra_charges` varchar(255) DEFAULT null
  PRIMARY KEY (`rental_id`), /*users can have multiple rentals and possibly rent multiple things on the same day*/
  FOREIGN KEY `vehicle_id` references vehicles(`license_plate_numbe`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
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
  PRIMARY KEY (`location`)
) ;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
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



--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `interior_colour` varchar(10) DEFAULT not NULL,
  `exterior_colour` varchar(10) DEFAULT not NULL,
  `license_plate_number` varchar(10) NOT NULL,
  `odometer_reading` int DEFAULT not null,
  `vehicle_type` varchar(17) NOT NULL,
  `condition` varchar(255) not null,
  PRIMARY KEY (`license_plate_number`),
  FOREIGN KEY `vehicle_type` references vehicles(`vin`)
) ;