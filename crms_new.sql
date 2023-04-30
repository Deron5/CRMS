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

use crms;

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(14) NOT NULL,
  `drivers_license` varchar(14) NOT NULL,
  `license_issue_location` varchar(255) NOT NULL,
  `license_expiration_date` date NOT NULL,
  `preferred_vehicle` varchar(17) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `preferred_dropoff` int DEFAULT NULL,
  `preferred_pickup` int DEFAULT NULL,
  `credit_card_number` varchar(19) NOT NULL,
  `credit_card_name` varchar(100) NOT NULL,
  `cvn` varchar(4) NOT NULL,
  `credit_card_expiration_date` date NOT NULL,
  `billing_address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  KEY `preferred_vehicle` (`preferred_vehicle`),
  KEY `preferred_pickup` (`preferred_pickup`),
  KEY `preferred_dropoff` (`preferred_dropoff`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'Amy','Summers','Amy.Summers@salinas-ross.biz','422-4318','36751940132777','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-12-07','2T1BU4EE1DC120460','4146 Castillo Crescent\nJohnstad, NM 83681',7,2,'4389148593129697357','Amy Summers','780','2024-04-04','10566 Bell Views Suite 955\nEast Brianna, ID 38121'),(2,'Savannah','Harris','Savannah.Harris@marquez.net','241-4608','28089420590134','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-07-16','1GBJK39U02F121041','Unit 7183 Box 0460\nDPO AE 08906',6,4,'1769619208423374262','Savannah Harris','209','2023-09-08','29000 Fuller Rapids Suite 988\nEast Laura, ID 44494'),(3,'Heather','Collier','Heather.Collier@mcgee.com','825-8243','87290890325174','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-09-06','3N1BC1AS5AL383513','08873 Moore Plains Suite 884\nPort Timothyfort, OK 61021',2,7,'2175955973332669497','Heather Collier','552','2024-12-07','97922 Christian Run\nStephaniefurt, UT 11984'),(4,'Amanda','Carter','Amanda.Carter@wade-tanner.com','367-7878','01075136826633','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-10-12','4A37L2EF0BE002977','32331 Gonzalez Club Suite 479\nEast Lindsaymouth, DE 20670',7,5,'4399452694032089088','Amanda Carter','109','2024-11-13','2311 Hannah Centers\nStewartbury, MI 93382'),(5,'Cynthia','Hood','Cynthia.Hood@yu-richardson.com','418-9509','80673087757141','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-09-02','3N1BC1AS5AL383513','983 Blankenship Place\nLake Kevin, MD 46354',4,3,'7191344642182087184','Cynthia Hood','828','2023-09-09','70301 Brown Harbor Suite 525\nEast Shanefort, AZ 59658'),(6,'Cynthia','Melendez','Cynthia.Melendez@andrews.com','416-8007','32703808084256','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-02-21','4S3BNAE62G3020305','854 Vargas Islands Apt. 579\nHannahfurt, OR 75447',3,2,'8386896489307028260','Cynthia Melendez','196','2024-05-19','70154 Alexis Drive\nNew Elizabethtown, IA 96514'),(7,'Megan','Warren','Megan.Warren@christian-wells.com','431-3564','41353606790007','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-05-22','4S3BNAE62G3020305','88274 Smith Mall\nJoyceport, OR 71722',1,1,'9881358320251727956','Megan Warren','065','2024-08-25','34574 Raymond Port Apt. 160\nEast Laura, RI 67396'),(8,'Sylvia','Carter','Sylvia.Carter@gray.com','261-4226','36912317475250','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-06-11','JA4JZ4AX0EZ600236','65245 Jeffrey Prairie\nFarrellport, KY 36490',3,4,'7657442385323229858','Sylvia Carter','063','2023-09-16','07448 Williams Trafficway\nBradleyfort, WI 26085'),(9,'Adrian','Brown','Adrian.Brown@johnson.com','412-1272','28982153862720','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-08-30','4A37L2EF0BE002977','Unit 9359 Box 5639\nDPO AA 04597',1,6,'7557213618149689585','Adrian Brown','838','2024-01-07','053 Mario Lakes Suite 607\nRodriguezside, ND 66501'),(10,'Samantha','Johnson','Samantha.Johnson@kim-smith.info','421-0506','73156828411924','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-09-04','4A37L2EF0BE002977','446 Lyons Crossroad\nMalloryland, MA 90354',1,1,'6981767808738922766','Samantha Johnson','148','2024-06-22','82057 Rodriguez Wells Apt. 464\nMeganland, IL 10087'),(11,'Logan','Carpenter','Logan.Carpenter@beasley-santos.biz','421-8728','34986604614988','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-02-17','4A37L2EF0BE002977','7174 Diaz Road Apt. 706\nGrahamview, TX 65962',2,4,'4254350350986163499','Logan Carpenter','254','2023-07-30','748 Robert Mills Apt. 353\nLake Juliemouth, WY 67311'),(12,'John','Grant','John.Grant@rodriguez.com','232-7725','81744812090708','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-09-13','KMHCT6AE8FU222364','9244 George Roads Apt. 148\nSouth Charles, SD 49545',3,4,'2216211262395748686','John Grant','479','2023-05-18','Unit 9009 Box 1317\nDPO AP 03725'),(13,'Travis','Bowman','Travis.Bowman@bell.net','260-4212','62905496635459','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-08-12','JA4JZ4AX0EZ600236','USNV Moran\nFPO AP 23318',3,5,'4896991701107775419','Travis Bowman','758','2023-09-29','Unit 1492 Box 1946\nDPO AP 30263'),(14,'Lisa','Nelson','Lisa.Nelson@hill.com','239-2952','26695465655514','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-12-15','KMHCT6AE8FU222364','6949 Cisneros Alley Apt. 546\nLake Kristenside, FL 31348',1,6,'6313123430494224109','Lisa Nelson','816','2024-10-09','675 Alexander Port Apt. 842\nLake Julie, AK 10891'),(15,'Frank','Graves','Frank.Graves@smith.biz','419-1034','95706730521628','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-11-10','JA4JZ4AX0EZ600236','13430 Dakota Loop\nRachaeltown, UT 89167',4,3,'6121831594958660910','Frank Graves','404','2024-04-07','2860 Stanley Port Suite 170\nWest Dianatown, NV 45507'),(16,'Mary','Thornton','Mary.Thornton@mitchell.info','433-8334','93281369787108','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2024-12-08','JA4JZ4AX0EZ600236','011 Robyn Island Apt. 945\nSouth Tracyfurt, FL 85603',3,1,'2628588516763199782','Mary Thornton','226','2024-03-03','398 Dustin Cape\nTurnerport, AZ 89149'),(17,'Jennifer','Bradford','Jennifer.Bradford@morales.com','235-2461','38630529681604','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-11-13','1GBJK39U02F121041','086 Fuller Station\nEast Robertmouth, AL 98716',3,5,'3730424984040296480','Jennifer Bradford','103','2024-11-04','32792 Ramirez Glen\nEast Casey, NJ 82768'),(18,'Robert','Thomas','Robert.Thomas@berger.biz','958-5371','84435248451165','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-08-05','3N1BC1AS5AL383513','44437 Anthony Village Apt. 816\nFrancoland, MO 40666',4,4,'5869117002798994399','Robert Thomas','170','2024-10-07','3890 Smith Ports Apt. 981\nWest Kimhaven, MT 25648'),(19,'Kathy','Kim','Kathy.Kim@chandler.biz','367-5498','67362950698286','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-05-05','5XYZUDLB1HG390130','670 Roberts Forge Apt. 286\nJosephside, IN 97570',3,1,'6209725128998221181','Kathy Kim','027','2023-10-17','9502 Patricia Fields\nTroymouth, OK 37577'),(20,'Trevor','Morgan','Trevor.Morgan@beck.com','823-8733','72828655223458','Pine East - W Blvd, Bridgetown, St. Michael, Barbados','2023-08-29','4S3BNAE62G3020305','966 Hall Tunnel\nEast Regina, FL 93269',6,6,'7238501176412958547','Trevor Morgan','828','2023-07-31','0479 Decker Green Suite 736\nEast Karenville, IL 33989');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentals`
--

DROP TABLE IF EXISTS `rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentals` (
  `rental_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `vehicle_id` varchar(10) NOT NULL,
  `rental_rate` float DEFAULT NULL,
  `lend_date` date NOT NULL,
  `return_date` date NOT NULL,
  `returned_date` date DEFAULT NULL,
  `lent_condition` varchar(255) NOT NULL,
  `return_condition` varchar(255) DEFAULT NULL,
  `rental_fee` float NOT NULL,
  `payment_method` varchar(10) NOT NULL,
  `extra_charges` varchar(255) DEFAULT '""',
  PRIMARY KEY (`rental_id`),
  KEY `vehicle_id` (`vehicle_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentals`
--

LOCK TABLES `rentals` WRITE;
/*!40000 ALTER TABLE `rentals` DISABLE KEYS */;
INSERT INTO `rentals` VALUES (1,17,'1234567898',15.49,'2023-02-16','2023-05-07',NULL,'brand new',NULL,1239.2,'cash','""'),(2,17,'1234567890',17.95,'2023-04-04','2023-05-10',NULL,'good good',NULL,696.2,'card','{\"baby seat\": 50}'),(3,18,'4234567891',23.44,'2023-03-25','2023-04-28',NULL,'good',NULL,796.96,'card','""'),(4,12,'2234567891',22.96,'2023-03-17','2023-06-18',NULL,'needs servicing',NULL,2135.28,'card','""'),(5,17,'4234567894',20.71,'2023-05-04','2023-05-11',NULL,'superb',NULL,144.97,'cash','""'),(6,4,'2234567892',18.51,'2023-02-16','2023-03-15','2023-03-16','needs repairs','needs repairs',618.28,'card','{\"late fee\": 100}'),(7,16,'2234567899',23.17,'2023-04-04','2023-06-11',NULL,'good good',NULL,1575.56,'cash','""'),(8,19,'1234567896',17.22,'2023-02-08','2023-05-31',NULL,'not so good',NULL,1928.64,'card','""'),(9,20,'2234567894',23.91,'2023-04-21','2023-05-28',NULL,'scratches on the back',NULL,884.67,'card','""'),(10,9,'2234567891',17.78,'2023-02-26','2023-05-23',NULL,'needs servicing',NULL,1529.08,'cash','""'),(11,9,'4234567896',22.49,'2023-04-16','2023-06-24',NULL,'drivable',NULL,1551.81,'cash','""'),(12,5,'2234567893',15.59,'2023-05-10','2023-05-11',NULL,'needs servicing',NULL,15.59,'card','""'),(13,16,'4234567891',21.65,'2023-05-19','2023-06-10',NULL,'good',NULL,476.3,'cash','""'),(14,9,'1234567892',15.93,'2023-01-06','2023-04-08',NULL,'brand new',NULL,1565.56,'card','{\"late fee\": 100}'),(15,15,'1234567890',15.58,'2023-04-28','2023-05-16',NULL,'good good',NULL,280.44,'card','""'),(16,11,'1234567897',23.72,'2023-01-12','2023-04-22',NULL,'good good',NULL,2372,'card','""'),(17,14,'1234567896',18.7,'2023-03-06','2023-04-11',NULL,'not so good',NULL,773.2,'cash','{\"late fee\": 100}'),(18,19,'2234567892',20.4,'2023-06-09','2023-06-23',NULL,'needs repairs',NULL,285.6,'card','""'),(19,12,'4234567894',15.65,'2023-01-23','2023-03-10','2023-03-11','superb','superb',835.55,'cash','{\"late fee\": 100}'),(20,5,'4234567891',23.6,'2023-03-09','2023-06-02',NULL,'good',NULL,2006,'card','""'),(21,5,'3234567899',15.01,'2023-05-10','2023-05-14',NULL,'good',NULL,60.04,'card','""'),(22,16,'2234567894',22.81,'2023-05-26','2023-06-17',NULL,'scratches on the back',NULL,551.82,'cash','{\"baby seat\": 50}'),(23,6,'1234567898',23.4,'2023-03-15','2023-06-18',NULL,'brand new',NULL,2223,'cash','""'),(24,14,'3234567891',15.8,'2023-05-17','2023-06-06',NULL,'good enough',NULL,316,'card','""'),(25,19,'1234567893',23.77,'2023-02-13','2023-06-10',NULL,'brand new',NULL,2831.09,'cash','{\"baby seat\": 50}'),(26,8,'3234567898',20.89,'2023-06-19','2023-06-28',NULL,'decent',NULL,188.01,'card','""'),(27,7,'1234567896',20.76,'2023-05-18','2023-06-20',NULL,'not so good',NULL,735.08,'card','{\"baby seat\": 50}'),(28,9,'3234567890',24.78,'2023-05-29','2023-06-27',NULL,'brand new',NULL,718.62,'cash','""'),(29,11,'1234567890',23.93,'2023-02-20','2023-06-02',NULL,'good good',NULL,2440.86,'card','""'),(30,11,'3234567897',22.43,'2023-02-21','2023-05-09',NULL,'good',NULL,1727.11,'card','""'),(31,5,'4234567890',15.28,'2023-04-21','2023-04-29',NULL,'works fine',NULL,122.24,'cash','""'),(32,4,'2234567893',15.38,'2023-06-28','2023-06-28',NULL,'needs servicing',NULL,0,'card','""'),(33,6,'1234567898',20.25,'2023-06-12','2023-06-15',NULL,'brand new',NULL,60.75,'card','""'),(34,19,'2234567899',15.28,'2023-05-15','2023-05-30',NULL,'good good',NULL,279.2,'cash','{\"baby seat\": 50}'),(35,9,'3234567894',18.12,'2023-03-27','2023-05-13',NULL,'scratches on the back',NULL,851.64,'cash','""'),(36,2,'1234567898',21.84,'2023-01-20','2023-03-26',NULL,'brand new',NULL,1519.6,'cash','{\"late fee\": 100}'),(37,9,'3234567894',19.91,'2023-04-21','2023-05-15',NULL,'scratches on the back',NULL,477.84,'cash','""'),(38,18,'3234567892',16.89,'2023-04-26','2023-05-21',NULL,'left door dented but otherwise good',NULL,422.25,'cash','""'),(39,15,'4234567895',21.17,'2023-06-18','2023-06-19',NULL,'works fine',NULL,21.17,'card','""'),(40,7,'2234567895',22.65,'2023-01-28','2023-01-30','2023-01-31','brand new','brand new',217.95,'card','{\"late fee\": 100, \"baby seat\": 50}'),(41,5,'3234567897',20.79,'2023-02-03','2023-03-10',NULL,'good',NULL,877.65,'card','{\"late fee\": 100, \"baby seat\": 50}'),(42,14,'1234567892',20.24,'2023-04-07','2023-05-29',NULL,'brand new',NULL,1052.48,'cash','""'),(43,17,'3234567895',21.42,'2023-04-12','2023-06-20',NULL,'needs repairs',NULL,1477.98,'cash','""'),(44,7,'2234567899',22.02,'2023-06-03','2023-06-21',NULL,'good good',NULL,396.36,'cash','""'),(45,18,'1234567896',19.68,'2023-02-07','2023-06-14',NULL,'not so good',NULL,2549.36,'card','{\"baby seat\": 50}'),(46,17,'4234567894',18.95,'2023-02-23','2023-04-12','2023-04-13','superb','superb',1078.55,'cash','{\"late fee\": 100, \"baby seat\": 50}'),(47,9,'2234567899',24.05,'2023-03-14','2023-03-21',NULL,'good good',NULL,268.35,'card','{\"late fee\": 100}'),(48,15,'1234567895',24.16,'2023-05-24','2023-06-15',NULL,'brand new',NULL,531.52,'cash','""'),(49,7,'3234567898',15.04,'2023-05-05','2023-06-20',NULL,'decent',NULL,691.84,'card','""'),(50,1,'2234567898',16.52,'2023-04-18','2023-04-26',NULL,'left door dented but otherwise good',NULL,132.16,'cash','""');
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
  `address` varchar(255) NOT NULL,
  PRIMARY KEY (`store_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stores`
--

LOCK TABLES `stores` WRITE;
/*!40000 ALTER TABLE `stores` DISABLE KEYS */;
INSERT INTO `stores` VALUES (1,'Bay Street, St. Michael'),(2,'Sunset Crest, Saint James'),(3,'Wildey, St. Michael'),(4,'Six Roads, St. Philip'),(5,'Warrens Industrial Park, St. Michael'),(6,'Rockley, Christ Church'),(7,'Moon Town, Saint Lucy');
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle_types`
--

LOCK TABLES `vehicle_types` WRITE;
/*!40000 ALTER TABLE `vehicle_types` DISABLE KEYS */;
INSERT INTO `vehicle_types` VALUES ('Toyota','PriusC',2014,'2T1BU4EE1DC120460'),('Chevrolet','Silverado 2500 HD',2013,'1GBJK39U02F121041'),('Subaru','Legacy',2017,'4S3BNAE62G3020305'),('Nissan','Versa',2010,'3N1BC1AS5AL383513'),('Mitsubishi','Eclipse',2011,'4A37L2EF0BE002977'),('Mitsubishi','Outlander',2014,'JA4JZ4AX0EZ600236'),('Hyundai','Santa Fe Sport',2017,'5XYZUDLB1HG390130'),('Hyundai','Accent',2015,'KMHCT6AE8FU222364');
/*!40000 ALTER TABLE `vehicle_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicles` (
  `interior_colour` varchar(10) NOT NULL,
  `exterior_colour` varchar(10) NOT NULL,
  `license_plate_number` varchar(10) NOT NULL,
  `odometer_reading` int NOT NULL,
  `vehicle_type` varchar(17) NOT NULL,
  `condition_` varchar(255) NOT NULL,
  PRIMARY KEY (`license_plate_number`),
  KEY `vehicle_type` (`vehicle_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;


INSERT INTO `vehicles` VALUES ('blue','Sea','1234567890',33546,'5XYZUDLB1HG390130','good good'),
('blue','Cyan','1234567891',96693,'2T1BU4EE1DC120460','right door dented but otherwise good'),
('Azure','Beige','1234567892',31632,'1GBJK39U02F121041','brand new'),
('Mauve','Beige','1234567893',760,'JA4JZ4AX0EZ600236','brand new'),
('yellow','Turquoise','1234567894',57320,'2T1BU4EE1DC120460','right door dented but otherwise good'),
('Pista','Burgundy','1234567895',63071,'2T1BU4EE1DC120460','brand new'),
('Charcoal','Pink','1234567896',16105,'3N1BC1AS5AL383513','not so good'),
('Rust','Jet','1234567897',7255,'4S3BNAE62G3020305','good good'),
('Tan','Pink','1234567898',57797,'JA4JZ4AX0EZ600236','brand new'),
('Crimson','Azure','1234567899',35934,'2T1BU4EE1DC120460','not so good'),
('Maroon','Fuchsia','2234567890',21130,'JA4JZ4AX0EZ600236','brand new'),
('Brunette','Mauve','2234567891',53280,'5XYZUDLB1HG390130','needs servicing'),
('Olive','Crimson','2234567892',31182,'KMHCT6AE8FU222364','needs repairs'),
('Cyan','Grape','2234567893',37429,'4S3BNAE62G3020305','needs servicing'),
('Saffron','Beige','2234567894',7611,'4A37L2EF0BE002977','scratches on the back'),
('Garnet','Pearl','2234567895',82686,'KMHCT6AE8FU222364','brand new'),
('Rosewood','yellow','2234567896',88703,'KMHCT6AE8FU222364','good enough?'),
('Beige','Lavender','2234567897',32375,'4S3BNAE62G3020305','left door dented but otherwise good'),
('Charcoal','Sky','2234567898',17629,'4A37L2EF0BE002977','left door dented but otherwise good'),
('Cream','Charcoal','2234567899',48445,'4A37L2EF0BE002977','good good'),
('Olive','Mustard','3234567890',86274,'JA4JZ4AX0EZ600236','brand new'),
('Mauve','Indigo','3234567891',49359,'JA4JZ4AX0EZ600236','good enough?'),
('Coral','Jet','3234567892',78985,'JA4JZ4AX0EZ600236','left door dented but otherwise good'),
('Rosewood','Rust','3234567893',61232,'3N1BC1AS5AL383513','needs repairs'),
('green','Bronze','3234567894',4440,'5XYZUDLB1HG390130','scratches on the back'),
('Black','Yellow','3234567895',95148,'2T1BU4EE1DC120460','needs repairs'),
('Bronze','Crimson','3234567896',6610,'3N1BC1AS5AL383513','needs servicing'),
('blue','Amber','3234567897',54685,'2T1BU4EE1DC120460','good'),
('Azure','Crimson','3234567898',67364,'KMHCT6AE8FU222364','decent'),
('Green','yellow','3234567899',62414,'4A37L2EF0BE002977','good'),
('Cherry','Crimson','4234567890',9817,'1GBJK39U02F121041','works fine'),
('Lemon','Mustard','4234567891',81165,'5XYZUDLB1HG390130','good'),
('Indigo','Ash','4234567892',18334,'4A37L2EF0BE002977','decent'),
('Silver','White','4234567893',88655,'1GBJK39U02F121041','decent'),
('Lemon','Lilac','4234567894',38913,'KMHCT6AE8FU222364','superb'),
('Amber','Umber','4234567895',2137,'JA4JZ4AX0EZ600236','works fine'),
('Garnet','Indigo','4234567896',81007,'KMHCT6AE8FU222364','drivable');
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

-- Dump completed on 2023-04-25 13:52:15
