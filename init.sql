-- MySQL dump 10.13  Distrib 8.0.18, for Linux (x86_64)
--
-- Host: localhost    Database: otus
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `addresses`
--
create database otus;
use otus;
DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `street_id` int(10) unsigned DEFAULT NULL,
  `building_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `apartment` int(11) DEFAULT NULL,
  `postal_code` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`address_id`),
  KEY `addresses_FK_1` (`street_id`),
  KEY `addresses_FK_2` (`street_id`),
  KEY `addresses_FK` (`user_uuid`),
  CONSTRAINT `addresses_FK` FOREIGN KEY (`user_uuid`) REFERENCES `users` (`uuid`),
  CONSTRAINT `addresses_FK_1` FOREIGN KEY (`street_id`) REFERENCES `streets` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES (1,'2f6d7c57-346a-11ea-9545-0242c0a84002',2,'10',12,'1000'),(2,'45ea8083-346a-11ea-9545-0242c0a84002',1,'20',13,'1100'),(3,'8ed9dd6a-346a-11ea-9545-0242c0a84002',3,'30',14,'1200'),(4,'8ed9e006-346a-11ea-9545-0242c0a84002',4,'40',15,'2000');
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `region_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cities_FK` (`region_id`),
  KEY `cities_name_IDX` (`name`) USING BTREE,
  CONSTRAINT `cities_FK` FOREIGN KEY (`region_id`) REFERENCES `regions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Moscow',1),(2,'Solnechnogorsk',1),(3,'Smolensk',2),(4,'London',3);
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `countries_name_IDX` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (2,'England'),(1,'Russia');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf16 COLLATE utf16_latvian_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf16 COLLATE=utf16_latvian_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'RUB'),(2,'GBP');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manufacturers`
--

DROP TABLE IF EXISTS `manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manufacturers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manufacturers`
--

LOCK TABLES `manufacturers` WRITE;
/*!40000 ALTER TABLE `manufacturers` DISABLE KEYS */;
INSERT INTO `manufacturers` VALUES (1,'Sony'),(2,'Microsoft'),(3,'Atari');
/*!40000 ALTER TABLE `manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `offers`
--

DROP TABLE IF EXISTS `offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `offers` (
  `offer_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `price_value` int(10) unsigned NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `currency_id` int(10) unsigned DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`offer_id`),
  KEY `products_prices_FK_1` (`price_id`),
  KEY `offers_product_id_IDX` (`product_id`,`active`) USING BTREE,
  KEY `offers_FK` (`currency_id`),
  KEY `offers_product_id_time_IDX` (`product_id`,`start_time`,`end_time`) USING BTREE,
  CONSTRAINT `offers_FK` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `products_prices_FK` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `products_prices_FK_1` FOREIGN KEY (`price_id`) REFERENCES `prices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `offers`
--

LOCK TABLES `offers` WRITE;
/*!40000 ALTER TABLE `offers` DISABLE KEYS */;
INSERT INTO `offers` VALUES (52,37,1,10000,1,1,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(53,37,2,8000,1,1,'2019-11-01 00:00:00','2019-12-01 00:00:00'),(54,37,3,120,1,2,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(55,37,4,90,1,2,'2019-11-01 00:00:00','2019-12-01 00:00:00'),(56,38,1,2000,1,1,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(57,38,3,20,1,2,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(58,39,1,20000,1,1,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(59,39,2,16000,1,1,'2019-11-01 00:00:00','2019-12-01 00:00:00'),(60,39,3,240,1,2,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(61,39,4,180,1,2,'2019-11-01 00:00:00','2019-12-01 00:00:00'),(62,40,1,4000,1,1,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(63,40,3,40,1,2,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(64,41,1,11000,1,1,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(65,41,2,9000,1,1,'2019-11-01 00:00:00','2019-12-01 00:00:00'),(66,41,3,140,1,2,'2018-11-01 00:00:00','2022-11-01 00:00:00'),(67,41,4,100,1,2,'2019-11-01 00:00:00','2019-12-01 00:00:00'),(68,42,3,1000,1,2,'2008-11-01 00:00:00','2010-11-01 00:00:00');
/*!40000 ALTER TABLE `offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `close_time` datetime DEFAULT NULL,
  `status` int(10) unsigned DEFAULT NULL,
  `address_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`order_id`,`address_id`),
  KEY `orders_status_IDX` (`status`) USING BTREE,
  KEY `orders_FK` (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
/*!50100 PARTITION BY KEY (address_id)
PARTITIONS 5 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (2,'2019-11-03 00:00:00','2019-11-14 00:00:00',5,2),(4,'2019-12-28 00:00:00',NULL,4,4),(1,'2019-11-02 00:00:00','2019-11-15 00:00:00',5,1),(3,'2019-12-31 00:00:00',NULL,4,3);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_offers`
--

DROP TABLE IF EXISTS `orders_offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_offers` (
  `order_id` bigint(20) unsigned NOT NULL,
  `amount` int(10) unsigned DEFAULT NULL,
  `offer_id` bigint(20) unsigned NOT NULL,
  KEY `orders_products_FK` (`offer_id`),
  KEY `orders_products_FK_1` (`order_id`),
  CONSTRAINT `orders_products_FK` FOREIGN KEY (`offer_id`) REFERENCES `offers` (`offer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_offers`
--

LOCK TABLES `orders_offers` WRITE;
/*!40000 ALTER TABLE `orders_offers` DISABLE KEYS */;
INSERT INTO `orders_offers` VALUES (1,1,53),(1,2,56),(2,1,59),(2,2,62),(3,1,52),(4,1,54);
/*!40000 ALTER TABLE `orders_offers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,'regular_ru'),(2,'black_friday_2019_ru'),(3,'regular_en'),(4,'black_friday_2019_en');
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `manufacturer_id` int(10) unsigned NOT NULL,
  `provider_id` int(10) unsigned NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `product_characteristics` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_name_IDX` (`name`) USING BTREE,
  KEY `products_name_active_IDX` (`name`,`active`) USING BTREE,
  KEY `products_FK_2` (`provider_id`),
  KEY `products_FK_1` (`manufacturer_id`),
  CONSTRAINT `products_FK_1` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturers` (`id`),
  CONSTRAINT `products_FK_2` FOREIGN KEY (`provider_id`) REFERENCES `providers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (37,'playstation3',1,1,1,'{\"weight\": {\"size\": 2, \"unit\": \"kg\"}, \"category\": \"Home video game console\"}'),(38,'playstation3 joystick',1,1,1,'{\"weight\": {\"size\": 0.5, \"unit\": \"kg\"}, \"category\": \"Joystick\", \"platform\": \"playstation3\"}'),(39,'playstation4',1,1,1,'{\"weight\": {\"size\": 2, \"unit\": \"kg\"}, \"category\": \"Home video game console\"}'),(40,'playstation4 joystick',1,1,1,'{\"weight\": {\"size\": 0.5, \"unit\": \"kg\"}, \"category\": \"Joystick\", \"platform\": \"playstation4\"}'),(41,'xbox360',2,1,1,'{\"weight\": {\"size\": 3, \"unit\": \"kg\"}, \"category\": \"Home video game console\"}'),(42,'Atari 2600',3,2,0,'{\"weight\": {\"size\": 1, \"unit\": \"kg\"}, \"category\": \"Home video game console\"}');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `providers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES (1,'ASDF'),(2,'MVBN');
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regions`
--

DROP TABLE IF EXISTS `regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `country_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `regions_FK` (`country_id`),
  KEY `regions_name_IDX` (`name`) USING BTREE,
  CONSTRAINT `regions_FK` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regions`
--

LOCK TABLES `regions` WRITE;
/*!40000 ALTER TABLE `regions` DISABLE KEYS */;
INSERT INTO `regions` VALUES (1,'Moscow obl',1),(2,'Smolenskaya obl',1),(3,'Greater London',2);
/*!40000 ALTER TABLE `regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `streets`
--

DROP TABLE IF EXISTS `streets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `streets` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `city_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `streets_FK` (`city_id`),
  KEY `streets_name_IDX` (`name`) USING BTREE,
  CONSTRAINT `streets_FK` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `streets`
--

LOCK TABLES `streets` WRITE;
/*!40000 ALTER TABLE `streets` DISABLE KEYS */;
INSERT INTO `streets` VALUES (1,'Lenina st.',1),(2,'Lenina st.',2),(3,'Lenina st.',3),(4,'Baker st.',4);
/*!40000 ALTER TABLE `streets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `correspondence_language` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `marital_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('2f6d7c57-346a-11ea-9545-0242c0a84002','Alex','Zateev','ru','single','man','mr','1996-09-12'),('45ea8083-346a-11ea-9545-0242c0a84002','Ivan','Ivanov','ru','single','man','mr','1999-10-12'),('8ed9dd6a-346a-11ea-9545-0242c0a84002','Petr','Petrov','ru','single','man','mr','1995-08-12'),('8ed9e006-346a-11ea-9545-0242c0a84002','Anton','Pavlov','en','single','man','mr','1994-05-10');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-11 16:33:37
