-- MySQL dump 10.13  Distrib 5.6.34, for Win32 (AMD64)
--
-- Host: 127.0.0.1    Database: sport
-- ------------------------------------------------------
-- Server version	5.6.34

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

--
-- Current Database: `sport`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `c03` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `c03`;

--
-- Table structure for table `atleti`
--

DROP TABLE IF EXISTS `atleti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `atleti` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) DEFAULT NULL,
  `datanascita` timestamp NULL DEFAULT NULL,
  `sesso` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atleti`
--

LOCK TABLES `atleti` WRITE;
/*!40000 ALTER TABLE `atleti` DISABLE KEYS */;
INSERT INTO `atleti` VALUES (1,'Speedy Gonzales','2015-06-30 22:00:00','m'),(2,'Beep Beep','2017-02-11 23:00:00','f');
/*!40000 ALTER TABLE `atleti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gare`
--

DROP TABLE IF EXISTS `gare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gare` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gara` varchar(100) NOT NULL,
  `km` int(11) DEFAULT NULL,
  `orapartenza` timestamp NULL DEFAULT NULL,
  `luogopartenza` varchar(100) DEFAULT NULL,
  `luogoarrivo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `gara` (`gara`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gare`
--

LOCK TABLES `gare` WRITE;
/*!40000 ALTER TABLE `gare` DISABLE KEYS */;
INSERT INTO `gare` VALUES (1,'Torino - Lione',666,'2017-02-27 23:00:00','Torino','Lione');
/*!40000 ALTER TABLE `gare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iscrizioni`
--

DROP TABLE IF EXISTS `iscrizioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iscrizioni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `atleti_id` int(11) NOT NULL,
  `gare_id` int(11) NOT NULL,
  `pettorale` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pettorale` (`pettorale`),
  KEY `atleti_id` (`atleti_id`),
  KEY `gare_id` (`gare_id`),
  CONSTRAINT `iscrizioni_ibfk_1` FOREIGN KEY (`atleti_id`) REFERENCES `atleti` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `iscrizioni_ibfk_2` FOREIGN KEY (`gare_id`) REFERENCES `gare` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iscrizioni`
--

LOCK TABLES `iscrizioni` WRITE;
/*!40000 ALTER TABLE `iscrizioni` DISABLE KEYS */;
INSERT INTO `iscrizioni` VALUES (1,1,1,100),(2,2,1,101);
/*!40000 ALTER TABLE `iscrizioni` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-02-14  5:00:36
