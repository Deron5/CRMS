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
  `role` tinyint UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `prefered_vehicle` (`prefered_vehicle`),
  KEY `preferred_pickup` (`preferred_pickup`),
  KEY `prefered_dropoff` (`prefered_dropoff`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
CREATE TABLE IF NOT EXISTS `rentals` (
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

DROP TABLE IF EXISTS `stores`;
CREATE TABLE IF NOT EXISTS `stores` (
  `store_id` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`store_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `interior_colour` varchar(10) DEFAULT NULL,
  `exterior_colour` varchar(10) DEFAULT NULL,
  `license_plate_number` varchar(10) NOT NULL,
  `odometer_reading` int DEFAULT NULL,
  `vehicle_type` varchar(17) NOT NULL,
  PRIMARY KEY (`license_plate_number`),
  KEY `vehicle_type` (`vehicle_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_types`
--

DROP TABLE IF EXISTS `vehicle_types`;
CREATE TABLE IF NOT EXISTS `vehicle_types` (
  `brand` varchar(25) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  `manufactured_year` year DEFAULT NULL,
  `vin` varchar(17) NOT NULL,
  PRIMARY KEY (`vin`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
