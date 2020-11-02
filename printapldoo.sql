-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: printapldoo
-- ------------------------------------------------------
-- Server version	5.7.31-0ubuntu0.18.04.1

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
-- Table structure for table `printer_printer_queue_pivot`
--

DROP TABLE IF EXISTS `printer_printer_queue_pivot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printer_printer_queue_pivot` (
  `printer_id` int(10) unsigned NOT NULL,
  `printing_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `printer_queue_id` int(10) unsigned NOT NULL,
  KEY `printer_id_fk_2243872` (`printer_id`),
  KEY `printer_queue_id_fk_2243872` (`printer_queue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printer_printer_queue_pivot`
--

LOCK TABLES `printer_printer_queue_pivot` WRITE;
/*!40000 ALTER TABLE `printer_printer_queue_pivot` DISABLE KEYS */;
INSERT INTO `printer_printer_queue_pivot` VALUES (1,2,5),(2,2,5),(1,2,6),(1,2,7),(2,2,7),(1,2,8),(2,2,8),(1,2,9),(1,2,10),(2,2,11),(1,2,12),(2,2,12),(1,2,13),(1,2,14),(1,2,15),(2,2,15),(1,2,16),(1,2,17),(2,2,18),(1,2,19),(2,2,19),(1,2,20),(1,2,21),(1,2,22),(1,2,23),(1,2,24),(1,2,25),(1,2,26),(1,2,27),(1,2,28),(1,2,29),(1,2,30),(1,2,31),(1,2,32),(1,2,33),(1,2,34),(1,2,35),(1,2,36),(1,2,37),(2,2,37),(1,2,38),(1,2,39),(2,2,39),(1,2,40),(2,0,40),(1,2,41),(1,2,42),(1,2,43),(2,0,43),(1,2,44),(1,2,45),(2,0,45);
/*!40000 ALTER TABLE `printer_printer_queue_pivot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printer_queues`
--

DROP TABLE IF EXISTS `printer_queues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printer_queues` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `header` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `footer` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `printing_status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printer_queues`
--

LOCK TABLES `printer_queues` WRITE;
/*!40000 ALTER TABLE `printer_queues` DISABLE KEYS */;
INSERT INTO `printer_queues` VALUES (1,'Test Queue',1,'Printer Header Information','Footer | Copyright','None','907867','Content for the Printers','2020-09-26 09:29:41','2020-09-26 17:07:05','2020-09-26 17:07:05',0),(2,'Print 1',1,'Test Header Information by Harpreet','****Footer for Print****','none','none','Content: Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2020-09-26 15:58:53','2020-09-26 15:58:53',NULL,2),(3,'Test Printing Job A',3,'Header Information','Footer Information:','Logo','None','Lorem Ipsum is simply dummy text of the printing and typesetting industry.','2020-09-26 17:05:26','2020-09-26 17:05:26',NULL,2),(4,'Another Print Queue',3,'Some Header Test Info','Copyright***','Logo','OPOPOPO','Just some dummy content','2020-09-27 13:00:43','2020-09-27 13:00:43',NULL,2),(5,'Print This',1,'Print Test by Harpreet after the CRUD chanages','Footer Content','Logo','FREE50','Content is now bigger.\r\n\r\nQueen are a British rock band formed in London in 1970. Their classic line-up was Freddie Mercury (lead vocals, piano), Brian May (guitar, vocals), Roger Taylor (drums, vocals) and John Deacon (bass). Their earliest works were influenced by progressive rock, hard rock and heavy metal, but the band gradually ventured into more conventional and radio-friendly works by incorporating further styles, such as arena rock and pop rock.\r\n\r\nThe band\'s 1977 album News of the World contained \"We Will Rock You\" and \"We Are the Champions\", which have become anthems at sporting events. By the early 1980s, Queen were one of the biggest stadium rock bands in the world. \"Another One Bites the Dust\" from The Game (1980) became their best-selling single, while their 1981 compilation album Greatest Hits is the best-selling album in the UK and is certified eight times platinum in the US. Their performance at the 1985 Live Aid concert is ranked among the greatest in rock history by various publications. In August 1986, Mercury gave his last performance with Queen at Knebworth, England.','2020-09-27 17:46:26','2020-09-27 17:46:26',NULL,0),(6,'test print',0,'Some Header','Content for Footer','non','onon','The band\'s 1977 album News of the World contained \"We Will Rock You\" and \"We Are the Champions\", which have become anthems at sporting events. By the early 1980s, Queen were one of the biggest stadium rock bands in the world. \"Another One Bites the Dust\" from The Game (1980) became their best-selling single, while their 1981 compilation album Greatest Hits is the best-selling album in the UK and is certified eight times platinum in the US. Their performance at the 1985 Live Aid concert is ranked among the greatest in rock history by various publications. In August 1986, Mercury gave his last performance with Queen at Knebworth, England.','2020-09-27 17:50:12','2020-09-27 17:50:12',NULL,0),(7,'Test print 89',1,'Some Text Information','Some Footer COntent','Non','nononone','Content Content Content\r\n\r\n\r\nContent Content Content\r\n\r\n\r\nContent Content Content\r\n\r\nContent Content Content\r\n\r\nContent Content Content\r\n\r\n\r\nContent Content Content\r\n\r\n\r\nContent Content Content\r\n\r\n\r\nContent Content Content','2020-09-27 20:16:47','2020-09-27 20:16:47',NULL,0),(8,'Print Test 550',1,'Header Test Infromation','Footer Copyright *****','Nonoenoen','ononon','Content Content Content\r\n\r\n\r\nContent Content Content\r\n\r\n\r\nContent Content Content\r\n\r\n\r\nContent Content Content','2020-09-27 20:20:12','2020-09-27 20:20:12',NULL,0),(9,'Mr C Pennington',1,'test','tststst',NULL,NULL,'tetststtsstst','2020-09-29 08:46:18','2020-09-29 08:46:18',NULL,0),(10,'Mr C Pennington',11,'test','ferfrf','reffferfef','ffefreferfe','erfrffrerf','2020-09-29 08:47:43','2020-09-29 08:47:43',NULL,0),(11,'Mr C Pennington',21,'test','tststst','reffferfef',NULL,NULL,'2020-09-29 08:48:41','2020-09-29 08:49:06',NULL,0),(12,'Mr C Pennington',1,'2','222',NULL,NULL,'2222','2020-09-29 08:49:28','2020-09-29 08:49:28',NULL,0),(13,'Why you not print',1,'test','11','111','11','2323231312313213121','2020-09-29 08:55:10','2020-09-29 09:01:04',NULL,0),(14,'testest',1,'test','00:11:62:0D:A9:F300:11:62:0D:A9:F3','00:11:62:0D:A9:F300:11:62:0D:A9:F300:11:62:0D:A9:F3','00:11:62:0D:A9:F300:11:62:0D:A9:F3','00:11:62:0D:A9:F300:11:62:0D:A9:F300:11:62:0D:A9:F300:11:62:0D:A9:F300:11:62:0D:A9:F300:11:62:0D:A9:F300:11:62:0D:A9:F3','2020-09-29 09:01:27','2020-09-29 09:01:27',NULL,0),(15,'Hello Print by Harpreet',1,'Header Info','Footer infor','Non','Non','THe app says printed however nothing comes THe app says printed however nothing comes THe app says printed however nothing comes THe app says printed however nothing comes THe app says printed however nothing comes through','2020-09-29 09:02:09','2020-09-29 09:02:09',NULL,0),(16,'Test Print',2,'Some Header Infro','Footer ***','mo','no','Lorem Ipsum\r\n\r\nLorem Ipsum\r\n\r\nLorem Ipsum\r\n\r\nLorem Ipsum\r\n\r\nLorem Ipsum\r\n\r\n\r\n\r\nLorem Ipsum\r\n\r\n\r\nLorem Ipsum','2020-09-29 09:26:14','2020-09-29 09:26:14',NULL,0),(17,'testing',1,'Headre Ingor','jlkj','none','none','lklkjkl\r\n\r\nlklkjkl\r\n\r\nlklkjkllklkjkl\r\nlklkjkllklkjkllklkjkl\r\n\r\nlklkjkllklkjkl\r\nlklkjkl\r\nlklkjkl`','2020-09-29 10:33:05','2020-09-29 10:33:05',NULL,0),(18,'Haanjie',5,'EHi is something','kljlkjlk','jlkjkljlkjl','lkjjkjlk',';kjkljlkj','2020-09-29 10:33:54','2020-09-29 10:33:54',NULL,0),(19,'teT rpint',1,'Header Ifnro by Harpreet','Fotter INgort','non','non','lhlkjlkj\r\n\r\n\r\nlhlkjlkjlhlkjlkj\r\nlhlkjlkj\r\n\r\n\r\nlhlkjlkj\r\n\r\nlhlkjlkj\r\n\r\nlhlkjlkj\r\nlhlkjlkj','2020-09-29 11:31:22','2020-09-29 11:31:22',NULL,0),(20,'Fuck the police',1,'Fuck the police','Fuck tFuck the policehe police','Fuck the policeFuck the police',NULL,'Fuck the policeFuck the policeFuck the policeFuck the policeFuck the police','2020-09-29 11:38:31','2020-09-29 11:38:31',NULL,0),(21,'Hi Stav',1,'Hi Stav','Hello',NULL,NULL,'Fuck the police','2020-09-29 11:39:24','2020-09-29 11:39:24',NULL,0),(22,'Mr C Pennington',11,'111','111','111','111','1111','2020-09-29 12:52:39','2020-09-29 12:52:39',NULL,0),(23,'Mr C Pennington',11,'test','1212','21212','12121','121212','2020-09-29 13:01:05','2020-09-29 13:01:05',NULL,0),(24,'Test Print by Harpreet',1,'Some Header Information','Footer Information','Logo','Coupon','Content goes here\r\n\r\nContent goes here\r\n\r\n\r\nContent goes here\r\n\r\nContent goes here\r\n\r\nContent goes here\r\n\r\nContent goes here\r\n\r\nContent goes here','2020-09-29 13:47:22','2020-09-29 13:47:22',NULL,0),(25,'Mr C Pennington',1,'Mr C Pennington','Mr C Pennington','Mr C Pennington','Mr C Pennington','Mr C Pennington','2020-09-29 14:14:54','2020-09-29 14:14:54',NULL,0),(26,'Mr C Pennington',11,'Head','Footer',NULL,'Coupon','Content','2020-09-29 14:27:08','2020-09-29 14:27:08',NULL,0),(27,'1',1,'head','111','<img src=\"https://app.tapldoo.com/storage/11/5f64cbd14e19b_nandos.jpg\" alt=\"Nandos\" class=\"logo\">','111','111','2020-09-29 14:28:23','2020-09-29 14:28:23',NULL,0),(28,'Mr C Pennington',NULL,'<img src=\"https://app.tapldoo.com/storage/11/5f64cbd14e19b_nandos.jpg\" alt=\"Nandos\" class=\"logo\">','www','www',NULL,'www','2020-09-29 14:28:54','2020-09-29 14:28:54',NULL,0),(29,'1',1,'1','1','reffferfef','1','1','2020-09-29 18:23:56','2020-09-29 18:23:56',NULL,0),(30,'hello@ig9itedigital.co.uk',1,'hello@ig9itedigital.co.uk','hello@ig9itedigital.co.uk','hello@ig9itedigital.co.uk',NULL,'hello@ig9itedigital.co.uk','2020-09-29 20:59:59','2020-09-29 20:59:59',NULL,0),(31,'2222',NULL,NULL,NULL,NULL,NULL,NULL,'2020-10-12 12:59:52','2020-10-12 12:59:52',NULL,0),(32,NULL,NULL,'[magnify: width 3; height 2]Columns[magnify]','[magnify: width 3; height 2]Columns[magnify]',NULL,NULL,'[magnify: width 3; height 2]Columns[magnify]','2020-10-12 19:14:09','2020-10-12 19:14:09',NULL,0),(33,NULL,NULL,NULL,NULL,NULL,NULL,'[align: centre][font: a]\\\r\n[image: url https://star-emea.com/wp-content/uploads/2015/01/logo.jpg;\r\n        width 60%;\r\n        min-width 48mm]\\\r\n[magnify: width 2; height 1]\r\nThis is a Star Markup Document!\r\n\r\n[magnify: width 3; height 2]Columns[magnify]\r\n[align: left]\\\r\n[column: left: Item 1;      right: $10.00]\r\n[column: left: Item 2;      right: $9.95]\r\n[column: left: Item 3;      right: $103.50]\r\n\r\n[align: centre]\\\r\n[barcode: type code39;\r\n          data 123456789012;\r\n          height 15mm;\r\n          module 0;\r\n          hri]\r\n[align]\\\r\nThank you for trying the new Star Document Markup Language\\\r\nwe hope you will find it useful. Please let us know!\r\n[cut: feed; partial]','2020-10-12 19:15:07','2020-10-12 19:15:07',NULL,0),(34,NULL,NULL,NULL,NULL,NULL,NULL,'hi nas\r\n\r\nhow are you?','2020-10-12 19:17:54','2020-10-12 19:17:54',NULL,0),(35,NULL,NULL,'saasasas',NULL,NULL,NULL,'asasasasasasassas','2020-10-12 19:28:13','2020-10-12 19:28:13',NULL,0),(36,NULL,NULL,'12121221212',NULL,NULL,NULL,NULL,'2020-10-12 19:31:07','2020-10-12 19:31:07',NULL,0),(37,'Test Print',1,'Some Header','Footer Content','Logo','Cpupon','[align: centre][font: a]\r\n[image: url https://star-emea.com/wp-content/uploads/2015/01/logo.jpg;\r\nwidth 60%;\r\nmin-width 48mm]\r\n[magnify: width 2; height 1]\r\nThis is a Star Markup Document!\r\n\r\n[magnify: width 3; height 2]Columns[magnify]\r\n[align: left]\r\n[column: left: Item 1; right: $10.00]\r\n[column: left: Item 2; right: $9.95]\r\n[column: left: Item 3; right: $103.50]\r\n\r\n[align: centre]\r\n[barcode: type code39;\r\ndata 123456789012;\r\nheight 15mm;\r\nmodule 0;\r\nhri]\r\n[align]\r\nThank you for trying the new Star Document Markup Language\r\nwe hope you will find it useful. Please let us know!\r\n[cut: feed; partial]','2020-10-13 07:08:06','2020-10-13 07:08:06',NULL,0),(38,'Test print with Markup',2,'Header Information','Footer Infor','Logo','Coupon','[align: centre][font: a]\\\r\n[image: url https://star-emea.com/wp-content/uploads/2015/01/logo.jpg;\r\n        width 60%;\r\n        min-width 48mm]\\\r\n[magnify: width 2; height 1]\r\nThis is a Star Markup Document!\r\n\r\n[magnify: width 3; height 2]Columns[magnify]\r\n[align: left]\\\r\n[column: left: Item 1;      right: $10.00]\r\n[column: left: Item 2;      right: $9.95]\r\n[column: left: Item 3;      right: $103.50]\r\n\r\n[align: centre]\\\r\n[barcode: type code39;\r\n          data 123456789012;\r\n          height 15mm;\r\n          module 0;\r\n          hri]\r\n[align]\\\r\nThank you for trying the new Star Document Markup Language\\\r\nwe hope you will find it useful. Please let us know!\r\n[cut: feed; partial]','2020-10-15 10:26:36','2020-10-15 10:26:36',NULL,0),(39,'test print 1',1,'Header Information','Footer Information','Logo','Coupon','[align: centre][font: a]\r\n[image: url https://star-emea.com/wp-content/uploads/2015/01/logo.jpg;\r\nwidth 60%;\r\nmin-width 48mm]\r\n[magnify: width 2; height 1]\r\nThis is a Star Markup Document!\r\n\r\n[magnify: width 3; height 2]Columns[magnify]\r\n[align: left]\r\n[column: left: Item 1; right: $10.00]\r\n[column: left: Item 2; right: $9.95]\r\n[column: left: Item 3; right: $103.50]\r\n\r\n[align: centre]\r\n[barcode: type code39;\r\ndata 123456789012;\r\nheight 15mm;\r\nmodule 0;\r\nhri]\r\n[align]\r\nThank you for trying the new Star Document Markup Language\r\nwe hope you will find it useful. Please let us know!\r\n[cut: feed; partial]','2020-10-15 11:16:15','2020-10-15 11:16:15',NULL,0),(40,'Test print',1,'Header Information','Footer Information','Logo','Coupon','[align: centre][font: a]\r\n[image: url https://star-emea.com/wp-content/uploads/2015/01/logo.jpg;\r\nwidth 60%;\r\nmin-width 48mm]\r\n[magnify: width 2; height 1]\r\nThis is a Star Markup Document!\r\n\r\n[magnify: width 3; height 2]Columns[magnify]\r\n[align: left]\r\n[column: left: Item 1; right: $10.00]\r\n[column: left: Item 2; right: $9.95]\r\n[column: left: Item 3; right: $103.50]\r\n\r\n[align: centre]\r\n[barcode: type code39;\r\ndata 123456789012;\r\nheight 15mm;\r\nmodule 0;\r\nhri]\r\n[align]\r\nThank you for trying the new Star Document Markup Language\r\nwe hope you will find it useful. Please let us know!\r\n[cut: feed; partial]','2020-10-15 11:25:00','2020-10-15 11:25:00',NULL,0),(41,'test',1,NULL,NULL,NULL,NULL,NULL,'2020-10-19 11:45:52','2020-10-19 11:45:52',NULL,0),(42,'test',1,NULL,NULL,NULL,NULL,NULL,'2020-10-19 11:45:53','2020-10-19 11:45:53',NULL,0),(43,'sdsdd',111,NULL,NULL,NULL,NULL,'12121221221221','2020-10-19 11:47:33','2020-10-19 11:47:33',NULL,0),(44,'Mr C Pennington',1,'Fuck the police',NULL,NULL,NULL,NULL,'2020-10-19 12:12:03','2020-10-19 12:12:03',NULL,0),(45,'Mr C Pennington',1,'1',NULL,NULL,NULL,'111111','2020-10-19 12:17:41','2020-10-19 12:17:41',NULL,0);
/*!40000 ALTER TABLE `printer_queues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `printers`
--

DROP TABLE IF EXISTS `printers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `printers` (
  `id` int(10) unsigned NOT NULL,
  `printer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mac_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dot_width` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_version` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `printing` int(11) DEFAULT NULL,
  `last_poll` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `team_id` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `printers`
--

LOCK TABLES `printers` WRITE;
/*!40000 ALTER TABLE `printers` DISABLE KEYS */;
INSERT INTO `printers` VALUES (1,'Printer A','00:11:62:0d:a9:f3',1,'1','1','1',1,'1','2020-09-26 09:27:43','2020-09-26 09:27:43',NULL,1),(2,'Printer B','fa:34:56:78:90',NULL,'None','none','non',NULL,'non','2020-09-27 17:44:55','2020-09-27 17:44:55',NULL,1),(3,'Kitchen 1','00:11:62:0d:a9:f3',11,'11','11','1',-3,NULL,'2020-09-29 13:00:30','2020-09-29 13:00:45','2020-09-29 13:00:45',1);
/*!40000 ALTER TABLE `printers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-21 11:24:14
