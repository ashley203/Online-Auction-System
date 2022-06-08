CREATE DATABASE  IF NOT EXISTS `OnlineAuctionSystem` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `OnlineAuctionSystem`;
-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: cs336.ckksjtjg2jto.us-east-2.rds.amazonaws.com    Database: OnlineAuctionSystem
-- ------------------------------------------------------
-- Server version	5.6.35-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `firstName` varchar(20) NOT NULL DEFAULT '',
  `lastName` varchar(20) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(12) NOT NULL DEFAULT '',
  `password` varchar(200) NOT NULL DEFAULT '',
  `accType` varchar(7) NOT NULL DEFAULT '',
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('Ashley','Mathai','ashley@gmail.com','ash','ash123','admin'),('Ria','Anand','ria@gmail.com','ri','ri123','custRep'),('Katie','Zhuang','katie@gmail.com','kat','kat123','custRep');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clothing`
--

DROP TABLE IF EXISTS `clothing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clothing` (
  `clothing_id` int NOT NULL AUTO_INCREMENT,
  `style` varchar(30) NOT NULL,
  `brand` varchar(50) NOT NULL DEFAULT '',
  `clothing_type` varchar(30) NOT NULL DEFAULT '',
  `color` varchar(20) NOT NULL DEFAULT '',
  `manufacture_date` date NOT NULL,
  PRIMARY KEY (`clothing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shirts`
--

DROP TABLE IF EXISTS `shirts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shirts` (
  `clothing_id` int NOT NULL,
  `shirt_size` varchar(4) NOT NULL,
  `sleeve_length` varchar(20) NOT NULL,
  `neckline` varchar(20) NOT NULL,
  PRIMARY KEY (`clothing_id`),
  FOREIGN KEY (clothing_id) REFERENCES clothing(clothing_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pants`
--

DROP TABLE IF EXISTS `pants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pants` (
  `clothing_id` int NOT NULL,
  `pants_size` varchar(4) NOT NULL,
  `pants_fit` varchar(20) NOT NULL,
  PRIMARY KEY (`clothing_id`),
  FOREIGN KEY (clothing_id) REFERENCES clothing(clothing_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shoes`
--

DROP TABLE IF EXISTS `shoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shoes` (
  `clothing_id` int NOT NULL,
  `shoe_size` varchar(4) NOT NULL,
  `material` varchar(20) NOT NULL,
  `width` varchar(20) NOT NULL,
  PRIMARY KEY (`clothing_id`),
  FOREIGN KEY (clothing_id) REFERENCES clothing(clothing_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auction` (
  `clothing_id` int NOT NULL,
  `end_date` date NOT NULL,
  `end_time` time NOT NULL,
  `min_price` decimal(9,2) NOT NULL,
  `init_price` decimal(9,2) NOT NULL,
  `increment` decimal(9,2) NOT NULL,
  PRIMARY KEY (`clothing_id`),
  FOREIGN KEY (clothing_id) REFERENCES clothing(clothing_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `question`
--

DROP TABLE IF EXISTS `question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question` (
  `question_id` int NOT NULL,
  `question_content` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bid`
--

DROP TABLE IF EXISTS `bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bid` (
  `bid_id` int NOT NULL AUTO_INCREMENT,
  `bidding_price` decimal(9,2) NOT NULL,
  `is_automatic` ENUM('true','false') NOT NULL,
  `upper_limit` decimal(9,2) DEFAULT NULL,
  `bid_increment` decimal(9,2) DEFAULT NULL,
  PRIMARY KEY (`bid_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `asks`
--

DROP TABLE IF EXISTS `asks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `asks` (
  `user_id` varchar(20) NOT NULL DEFAULT '',
  `question_id` int NOT NULL,
  PRIMARY KEY (`user_id`, `question_id`),
  KEY `fk_asks_question` (`question_id`),
  CONSTRAINT `fk_asks_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`),
  CONSTRAINT `fk_asks_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answers` (
  `user_id` varchar(20) NOT NULL DEFAULT '',
  `question_id` int NOT NULL,
  `answer_content` varchar(200) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`, `question_id`),
  KEY `fk_answers_question` (`question_id`),
  CONSTRAINT `fk_answers_question` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`),
  CONSTRAINT `fk_answers_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `seller_sets_auction`
--

DROP TABLE IF EXISTS `seller_sets_auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seller_sets_auction` (
  `username` varchar(12) NOT NULL DEFAULT '',
  `clothing_id` int NOT NULL,
  PRIMARY KEY (`username`,`clothing_id`),
  KEY `fk_sets_username` (`username`),
  CONSTRAINT `fk_sets_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`),
  CONSTRAINT `fk_sets_clothing_id` FOREIGN KEY (`clothing_id`) REFERENCES `auction` (`clothing_id`)  
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `buyer_makes_bid`
--

DROP TABLE IF EXISTS `buyer_makes_bid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `buyer_makes_bid`(
  `username` varchar(12) NOT NULL DEFAULT '',
  `bid_id` int NOT NULL,
  PRIMARY KEY (`username`,`bid_id`),
  KEY `fk_makes_bid_id` (`bid_id`),
  CONSTRAINT `fk_makes_bid_id` FOREIGN KEY (`bid_id`) REFERENCES `bid` (`bid_id`),
  CONSTRAINT `fk_makes_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bid_on_auction`
--

DROP TABLE IF EXISTS `bid_on_auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bid_on_auction`(
  `bid_id` int NOT NULL,
  `clothing_id` int NOT NULL,
  PRIMARY KEY (`bid_id`, `clothing_id`),
  KEY `fk_bid_on_bid_id` (`bid_id`),
  CONSTRAINT `fk_bid_on_bid_id` FOREIGN KEY (`bid_id`) REFERENCES `bid` (`bid_id`),
  CONSTRAINT `fk_bid_on_auction` FOREIGN KEY (`clothing_id`) REFERENCES `auction` (`clothing_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `set_alerts_for`
--

DROP TABLE IF EXISTS `set_alerts_for`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `set_alerts_for`(
  `alert_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(12) NOT NULL DEFAULT '',
  `clothing_id` int NOT NULL,
  `notification` ENUM('higher_bid','upper_limit','won_auction','item_available'),
  `seen` ENUM('true','false') NOT NULL DEFAULT 'false',
  PRIMARY KEY (`alert_id`,`username`,`clothing_id`),
  KEY `fk_alerts_clothing_id` (`clothing_id`),
  CONSTRAINT `fk_alerts_clothing_id` FOREIGN KEY (`clothing_id`) REFERENCES `clothing` (`clothing_id`),
  CONSTRAINT `fk_alerts_username` FOREIGN KEY (`username`) REFERENCES `users` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `interested_item`
--

DROP TABLE IF EXISTS `interested_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interested_item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(12) NOT NULL,
  `style` varchar(30),
  `brand` varchar(50),
  `clothing_type` varchar(30),
  `color` varchar(20),
  `manufacture_date` date,
  `shoe_size` varchar(4),
  `material` varchar(20),
  `width` varchar(20),
  `pants_size` varchar(4),
  `pants_fit` varchar(20),
  `shirt_size` varchar(4),
  `sleeve_length` varchar(20),
  `neckline` varchar(20),
  PRIMARY KEY (`item_id`, `username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interested_item`
--

LOCK TABLES `interested_item` WRITE;
/*!40000 ALTER TABLE `interested_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `interested_item` ENABLE KEYS */;
UNLOCK TABLES;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-10 13:49:53
