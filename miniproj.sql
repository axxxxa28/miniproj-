-- MySQL dump 10.13  Distrib 9.2.0, for macos15 (arm64)
--
-- Host: localhost    Database: miniproj
-- ------------------------------------------------------
-- Server version	9.2.0

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
-- Table structure for table `Asset`
--

DROP TABLE IF EXISTS `Asset`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Asset` (
  `asset_id` int NOT NULL,
  `asset_name` varchar(255) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `war_exp` date DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `asset_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Department` (`dept_id`),
  CONSTRAINT `asset_chk_1` CHECK ((`status` in (_utf8mb4'Available',_utf8mb4'In Use',_utf8mb4'Under Maintenance',_utf8mb4'Retired')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Asset`
--

LOCK TABLES `Asset` WRITE;
/*!40000 ALTER TABLE `Asset` DISABLE KEYS */;
INSERT INTO `Asset` VALUES (301,'Projector','Available','2026-05-20',1),(302,'3D Printer','In Use','2025-11-12',2),(303,'CNC Machine','Under Maintenance','2027-03-15',3),(304,'Surveying Equipment','Retired','2023-08-10',4),(305,'Microcontroller Kit','Available','2026-01-01',5),(306,'Spectrometer','In Use','2025-06-30',6),(307,'Whiteboard','Available','2028-10-05',7),(308,'Biotech Analyzer','Under Maintenance','2027-02-14',8),(309,'Chemistry Lab Kit','Available','2025-12-31',9),(310,'Business Simulation Software','In Use','2026-07-19',10);
/*!40000 ALTER TABLE `Asset` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Budget`
--

DROP TABLE IF EXISTS `Budget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Budget` (
  `sr_no` int NOT NULL,
  `dept_id` int DEFAULT NULL,
  `total_budget` decimal(10,2) DEFAULT NULL,
  `rem_amt` decimal(10,2) DEFAULT NULL,
  `approval_date` date DEFAULT NULL,
  PRIMARY KEY (`sr_no`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `budget_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Budget`
--

LOCK TABLES `Budget` WRITE;
/*!40000 ALTER TABLE `Budget` DISABLE KEYS */;
INSERT INTO `Budget` VALUES (1,1,10000.00,8000.00,'2024-01-10'),(2,2,15000.00,14000.00,'2024-01-15');
/*!40000 ALTER TABLE `Budget` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cost`
--

DROP TABLE IF EXISTS `Cost`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cost` (
  `sr_no` int NOT NULL,
  `cost_type_id` int DEFAULT NULL,
  `asset_id` int DEFAULT NULL,
  `amnt` decimal(10,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`sr_no`),
  KEY `cost_type_id` (`cost_type_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `cost_ibfk_1` FOREIGN KEY (`cost_type_id`) REFERENCES `Cost_Type` (`cost_type_id`),
  CONSTRAINT `cost_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cost`
--

LOCK TABLES `Cost` WRITE;
/*!40000 ALTER TABLE `Cost` DISABLE KEYS */;
INSERT INTO `Cost` VALUES (1,1,301,500.00,'2024-02-20'),(2,2,302,1200.00,'2024-02-25');
/*!40000 ALTER TABLE `Cost` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Cost_Type`
--

DROP TABLE IF EXISTS `Cost_Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Cost_Type` (
  `cost_type_id` int NOT NULL,
  `cost_type` varchar(255) NOT NULL,
  PRIMARY KEY (`cost_type_id`),
  UNIQUE KEY `cost_type` (`cost_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cost_Type`
--

LOCK TABLES `Cost_Type` WRITE;
/*!40000 ALTER TABLE `Cost_Type` DISABLE KEYS */;
INSERT INTO `Cost_Type` VALUES (1,'repair'),(2,'Upgrade');
/*!40000 ALTER TABLE `Cost_Type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deadstock`
--

DROP TABLE IF EXISTS `deadstock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deadstock` (
  `deadstock_id` int NOT NULL AUTO_INCREMENT,
  `asset_id` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `action_date` date DEFAULT NULL,
  `handled_by` int DEFAULT NULL,
  `comments` text,
  PRIMARY KEY (`deadstock_id`),
  KEY `asset_id` (`asset_id`),
  KEY `handled_by` (`handled_by`),
  CONSTRAINT `deadstock_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`) ON DELETE SET NULL,
  CONSTRAINT `deadstock_ibfk_2` FOREIGN KEY (`handled_by`) REFERENCES `Employee` (`emp_id`) ON DELETE SET NULL,
  CONSTRAINT `deadstock_chk_1` CHECK ((`status` in (_utf8mb4'Reuse',_utf8mb4'Recycle',_utf8mb4'Resell',_utf8mb4'Donate',_utf8mb4'Dispose')))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deadstock`
--

LOCK TABLES `deadstock` WRITE;
/*!40000 ALTER TABLE `deadstock` DISABLE KEYS */;
INSERT INTO `deadstock` VALUES (1,301,'Recycle','2024-03-01',NULL,'Recycled old monitors'),(2,302,'Resell','2024-03-05',NULL,'Sold outdated laptops'),(3,303,'Dispose','2024-03-10',NULL,'Disposed of broken chairs'),(4,304,'Donate','2024-03-15',NULL,'Donated desks and tables'),(5,305,'Reuse','2024-03-20',NULL,'Reused old projectors in lab'),(6,306,'Recycle','2024-03-25',NULL,'Recycled non-functional printers'),(7,307,'Dispose','2024-04-01',NULL,'Disposed expired batteries'),(8,308,'Resell','2024-04-05',NULL,'Sold old CPUs'),(9,309,'Donate','2024-04-10',NULL,'Donated bookshelves'),(10,310,'Reuse','2024-04-15',NULL,'Reused old whiteboards in classrooms');
/*!40000 ALTER TABLE `deadstock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DeadStock_Recipient`
--

DROP TABLE IF EXISTS `DeadStock_Recipient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DeadStock_Recipient` (
  `deadstock_id` int NOT NULL,
  `recipient` varchar(255) NOT NULL,
  PRIMARY KEY (`deadstock_id`),
  CONSTRAINT `deadstock_recipient_ibfk_1` FOREIGN KEY (`deadstock_id`) REFERENCES `DeadStock` (`deadstock_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DeadStock_Recipient`
--

LOCK TABLES `DeadStock_Recipient` WRITE;
/*!40000 ALTER TABLE `DeadStock_Recipient` DISABLE KEYS */;
INSERT INTO `DeadStock_Recipient` VALUES (2,'XYZ Company'),(4,'Local School'),(8,'TechRefurb'),(9,'Community Center');
/*!40000 ALTER TABLE `DeadStock_Recipient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `dept_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Computer Science','Building A'),(2,'Mechanical','Building B'),(3,'Electrical','Building C'),(4,'Civil','Building D'),(5,'Electronics','Building E'),(6,'Physics','Building F'),(7,'Mathematics','Building G'),(8,'Biology','Building H'),(9,'Chemistry','Building I'),(10,'Business Administration','Building J');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Electronics`
--

DROP TABLE IF EXISTS `Electronics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Electronics` (
  `sr_no` varchar(50) NOT NULL,
  `asset_id` int DEFAULT NULL,
  PRIMARY KEY (`sr_no`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `electronics_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Electronics`
--

LOCK TABLES `Electronics` WRITE;
/*!40000 ALTER TABLE `Electronics` DISABLE KEYS */;
INSERT INTO `Electronics` VALUES ('E001',301),('E007',301),('E002',302),('E008',302),('E003',305),('E009',305),('E004',306),('E010',306),('E005',309),('E006',310);
/*!40000 ALTER TABLE `Electronics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Electronics_details`
--

DROP TABLE IF EXISTS `Electronics_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Electronics_details` (
  `asset_id` int DEFAULT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `model` varchar(255) DEFAULT NULL,
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `electronics_details_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Electronics_details`
--

LOCK TABLES `Electronics_details` WRITE;
/*!40000 ALTER TABLE `Electronics_details` DISABLE KEYS */;
INSERT INTO `Electronics_details` VALUES (301,'Sony','VPL-DX221'),(301,'BenQ','MW612'),(302,'Ultimaker','S3'),(302,'Prusa','MK3S+'),(305,'Arduino','Mega 2560'),(305,'Raspberry Pi','4B'),(306,'Thermo Fisher','Nicolet iS10'),(306,'Bruker','Alpha II'),(309,'Sigma-Aldrich','Chemistry Kit'),(310,'SAP','Business One');
/*!40000 ALTER TABLE `Electronics_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `emp_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employee`
--

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES (101,'Alice Johnson','alice@example.com','Professor',1),(102,'Bob Smith','bob@example.com','Professor',2),(103,'Charlie Brown','charlie@example.com','Professor',3),(104,'David Williams','david@example.com','Professor',4),(105,'Eve Davis','eve@example.com','Professor',5),(106,'Frank Miller','frank@example.com','Professor',6),(107,'Grace Wilson','grace@example.com','Professor',7),(108,'Henry Moore','henry@example.com','Professor',8),(109,'Isabel Clark','isabel@example.com','Professor',9),(110,'Jack Lewis','jack@example.com','Professor',10);
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Furniture`
--

DROP TABLE IF EXISTS `Furniture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Furniture` (
  `sr_no` varchar(50) NOT NULL,
  `asset_id` int DEFAULT NULL,
  PRIMARY KEY (`sr_no`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `furniture_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Furniture`
--

LOCK TABLES `Furniture` WRITE;
/*!40000 ALTER TABLE `Furniture` DISABLE KEYS */;
INSERT INTO `Furniture` VALUES ('F005',301),('F001',307),('F002',308),('F003',309),('F004',310);
/*!40000 ALTER TABLE `Furniture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Furniture_Details`
--

DROP TABLE IF EXISTS `Furniture_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Furniture_Details` (
  `asset_id` int NOT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  CONSTRAINT `furniture_details_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Furniture_Details`
--

LOCK TABLES `Furniture_Details` WRITE;
/*!40000 ALTER TABLE `Furniture_Details` DISABLE KEYS */;
INSERT INTO `Furniture_Details` VALUES (301,'Projector Stand'),(307,'Whiteboard'),(308,'Lab Table'),(309,'Chemical Cabinet'),(310,'Office Desk');
/*!40000 ALTER TABLE `Furniture_Details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Maintenance`
--

DROP TABLE IF EXISTS `Maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Maintenance` (
  `main_id` int NOT NULL,
  `main_date` date DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `asset_id` int DEFAULT NULL,
  PRIMARY KEY (`main_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `Supplier` (`supplier_id`),
  CONSTRAINT `maintenance_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`),
  CONSTRAINT `maintenance_chk_1` CHECK ((`status` in (_utf8mb4'Pending',_utf8mb4'Completed')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Maintenance`
--

LOCK TABLES `Maintenance` WRITE;
/*!40000 ALTER TABLE `Maintenance` DISABLE KEYS */;
INSERT INTO `Maintenance` VALUES (1,'2024-02-01',1,'Completed',301),(2,'2024-03-15',2,'Pending',302);
/*!40000 ALTER TABLE `Maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notification`
--

DROP TABLE IF EXISTS `Notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notification` (
  `sr_no` int NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `rec_id` int DEFAULT NULL,
  PRIMARY KEY (`sr_no`),
  KEY `rec_id` (`rec_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`rec_id`) REFERENCES `Employee` (`emp_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notification`
--

LOCK TABLES `Notification` WRITE;
/*!40000 ALTER TABLE `Notification` DISABLE KEYS */;
INSERT INTO `Notification` VALUES (1,'Projector maintenance completed','2024-02-21 10:00:00',101),(2,'New purchase order approved','2024-03-22 14:30:00',102);
/*!40000 ALTER TABLE `Notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PurchaseOrder`
--

DROP TABLE IF EXISTS `PurchaseOrder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PurchaseOrder` (
  `po_id` int NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `total_cost` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`po_id`),
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `purchaseorder_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `Supplier` (`supplier_id`),
  CONSTRAINT `purchaseorder_chk_1` CHECK ((`status` in (_utf8mb4'Pending',_utf8mb4'Approved',_utf8mb4'Rejected')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PurchaseOrder`
--

LOCK TABLES `PurchaseOrder` WRITE;
/*!40000 ALTER TABLE `PurchaseOrder` DISABLE KEYS */;
INSERT INTO `PurchaseOrder` VALUES (1,'Pending','2024-04-15',1,10,'2024-03-20',5000.00),(2,'Approved','2024-05-01',2,5,'2024-03-25',2500.00);
/*!40000 ALTER TABLE `PurchaseOrder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ReqAlloc`
--

DROP TABLE IF EXISTS `ReqAlloc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ReqAlloc` (
  `req_id` int NOT NULL,
  `dept_id` int DEFAULT NULL,
  `asset_id` int DEFAULT NULL,
  `req_date` date DEFAULT NULL,
  `alloc_date` date DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`req_id`),
  KEY `dept_id` (`dept_id`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `reqalloc_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Department` (`dept_id`),
  CONSTRAINT `reqalloc_ibfk_2` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`),
  CONSTRAINT `reqalloc_chk_1` CHECK ((`status` in (_utf8mb4'Pending',_utf8mb4'Approved',_utf8mb4'Rejected')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ReqAlloc`
--

LOCK TABLES `ReqAlloc` WRITE;
/*!40000 ALTER TABLE `ReqAlloc` DISABLE KEYS */;
INSERT INTO `ReqAlloc` VALUES (1,1,301,'2024-03-01','2024-03-10',2,'Approved'),(2,2,302,'2024-03-05',NULL,1,'Pending');
/*!40000 ALTER TABLE `ReqAlloc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `student_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `dept_id` (`dept_id`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `Department` (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (201,'Tom Anderson','tom@example.com',1),(202,'Sara White','sara@example.com',2),(203,'Mike Green','mike@example.com',3),(204,'Emma Harris','emma@example.com',4),(205,'Noah Adams','noah@example.com',5),(206,'Olivia Scott','olivia@example.com',6),(207,'Liam Hall','liam@example.com',7),(208,'Sophia King','sophia@example.com',8),(209,'James Wright','james@example.com',9),(210,'Charlotte Martin','charlotte@example.com',10);
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `supplier_id` int NOT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `phone_no` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` text,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` VALUES (1,'Tech Supplies','John Doe','1234567890','tech@example.com','123 Tech Street'),(2,'Lab Solutions','Jane Smith','0987654321','lab@example.com','456 Science Ave');
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Supplier_Type`
--

DROP TABLE IF EXISTS `Supplier_Type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Supplier_Type` (
  `supplier_id` int DEFAULT NULL,
  `supplier_type` varchar(50) DEFAULT NULL,
  KEY `supplier_id` (`supplier_id`),
  CONSTRAINT `supplier_type_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `Supplier` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Supplier_Type`
--

LOCK TABLES `Supplier_Type` WRITE;
/*!40000 ALTER TABLE `Supplier_Type` DISABLE KEYS */;
INSERT INTO `Supplier_Type` VALUES (1,'Electronics'),(2,'Scientific Equipment');
/*!40000 ALTER TABLE `Supplier_Type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transport`
--

DROP TABLE IF EXISTS `Transport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transport` (
  `sr_no` varchar(50) NOT NULL,
  `asset_id` int DEFAULT NULL,
  `lio_plate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`sr_no`),
  KEY `asset_id` (`asset_id`),
  CONSTRAINT `transport_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transport`
--

LOCK TABLES `Transport` WRITE;
/*!40000 ALTER TABLE `Transport` DISABLE KEYS */;
INSERT INTO `Transport` VALUES ('T001',303,'AB123CD'),('T002',304,'EF456GH'),('T003',307,'IJ789KL'),('T004',308,'MN012OP'),('T005',309,'QR345ST');
/*!40000 ALTER TABLE `Transport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Transport_Details`
--

DROP TABLE IF EXISTS `Transport_Details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Transport_Details` (
  `asset_id` int NOT NULL,
  `manuf` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  CONSTRAINT `transport_details_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `Asset` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Transport_Details`
--

LOCK TABLES `Transport_Details` WRITE;
/*!40000 ALTER TABLE `Transport_Details` DISABLE KEYS */;
INSERT INTO `Transport_Details` VALUES (303,'Mazak'),(304,'Leica'),(307,'Expo'),(308,'GE'),(309,'Labconco');
/*!40000 ALTER TABLE `Transport_Details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-17  0:23:10
