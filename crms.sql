-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Mar 29, 2023 at 01:30 AM
-- Server version: 8.0.27
-- PHP Version: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `crms`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` int NOT NULL,
  `first_name` varchar(50) ,
  `surname` varchar(50) ,
  `email` varchar(255) ,
  `phone_number` varchar(15) ,
  `drivers_license` varchar(15) ,
  `issue_location` varchar(255) ,
  `expiration_date` date ,
  `prefered_vehicle` varchar(10) ,
  `rental_duration` varchar(5) ,
  `prefered_dropoff` int ,
  `preferred_pickup` int ,
  `password` varchar(25) ,
  `role` tinyint UNSIGNED ,
  PRIMARY KEY (`customer_id`),
  KEY `prefered_vehicle` (`prefered_vehicle`),
  KEY `preferred_pickup` (`preferred_pickup`),
  KEY `prefered_dropoff` (`prefered_dropoff`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
CREATE TABLE IF NOT EXISTS `rentals` (
  `customer_id` int NOT NULL,
  `vehicle_id` varchar(10) NOT NULL,
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
) ;

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
CREATE TABLE IF NOT EXISTS `stores` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  `store location` varchar(50),
  PRIMARY KEY (`store_id`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `interior_colour` varchar(10) ,
  `exterior_colour` varchar(10) ,
  `license_plate_number` varchar(10) NOT NULL,
  `odometer_reading` int ,
  `vehicle_type` varchar(17) NOT NULL,
  PRIMARY KEY (`license_plate_number`),
  KEY `vehicle_type` (`vehicle_type`)
) ;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_types`
--

DROP TABLE IF EXISTS `vehicle_types`;
CREATE TABLE IF NOT EXISTS `vehicle_types` (
  `brand` varchar(25) ,
  `model` varchar(255) ,
  `manufactured_year` year ,
  `vin` varchar(17) NOT NULL,
  PRIMARY KEY (`vin`)
) ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
