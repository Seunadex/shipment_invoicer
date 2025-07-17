
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
DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `bls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bls` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `id_upload` bigint DEFAULT NULL,
  `upload_date` datetime DEFAULT NULL,
  `number` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_id` bigint DEFAULT NULL,
  `consignee_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consignee_name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notified_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notified_name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vessel_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vessel_voyage` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrival_date` datetime DEFAULT NULL,
  `freetime` int DEFAULT NULL,
  `quantity_dry_20ft` int DEFAULT NULL,
  `quantity_dry_40ft` int DEFAULT NULL,
  `quantity_refrigerated_20ft` int DEFAULT NULL,
  `quantity_refrigerated_40ft` int DEFAULT NULL,
  `quantity_special_20ft` int DEFAULT NULL,
  `quantity_special_40ft` int DEFAULT NULL,
  `reef` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `unloading_type` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `validity_date` datetime DEFAULT NULL,
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exempt` tinyint(1) NOT NULL DEFAULT '0',
  `blocked_for_refund` tinyint(1) NOT NULL DEFAULT '0',
  `reference` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `valid_flag` tinyint(1) DEFAULT NULL,
  `released_status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `released_notes` text COLLATE utf8mb4_unicode_ci,
  `operator` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `atp` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consignee_caution` tinyint(1) NOT NULL DEFAULT '0',
  `service_contract` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emails` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receipt_location` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_location` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `loading_port` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discharge_port` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bls_on_number` (`number`),
  KEY `index_bls_on_consignee_code` (`consignee_code`),
  KEY `index_bls_on_consignee_name` (`consignee_name`),
  KEY `index_bls_on_arrival_date` (`arrival_date`),
  KEY `index_bls_on_reef` (`reef`),
  KEY `index_bls_on_customer_id` (`customer_id`),
  KEY `index_bls_on_status` (`status`),
  CONSTRAINT `fk_bls_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `client_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deposit_required` tinyint(1) NOT NULL,
  `freetime_refrigerated` int DEFAULT NULL,
  `freetime_dry` int DEFAULT NULL,
  `priority` tinyint(1) DEFAULT NULL,
  `sales_rep_id` bigint DEFAULT NULL,
  `finance_rep_id` bigint DEFAULT NULL,
  `cservice_rep_id` bigint DEFAULT NULL,
  `validity_date` datetime DEFAULT NULL,
  `operator` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_clients_on_client_code` (`client_code`),
  KEY `index_clients_on_name` (`name`),
  KEY `index_clients_on_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `factures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factures` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reference` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number` varchar(9) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(12,0) NOT NULL,
  `original_amount` decimal(12,2) DEFAULT NULL,
  `currency` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT 'XOF',
  `status` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'init',
  `invoice_date` datetime NOT NULL,
  `user_id` bigint NOT NULL,
  `create_type_utilisateur` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_utilisateur_update` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_factures_on_reference` (`reference`),
  KEY `index_factures_on_number` (`number`),
  KEY `index_factures_on_client_code` (`client_code`),
  KEY `index_factures_on_status` (`status`),
  KEY `index_factures_on_invoice_date` (`invoice_date`),
  CONSTRAINT `fk_factures_number` FOREIGN KEY (`number`) REFERENCES `bls` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `remboursements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remboursements` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `number` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_amount` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_amount` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deduction` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'PENDING',
  `id_transitaire` bigint NOT NULL,
  `id_transitaire_maison` bigint DEFAULT NULL,
  `transitaire_notifie` tinyint(1) DEFAULT NULL,
  `maison_notifie` tinyint(1) DEFAULT NULL,
  `banque_notifie` tinyint(1) DEFAULT NULL,
  `date_demande` datetime DEFAULT NULL,
  `date_refund_traite` datetime DEFAULT NULL,
  `type_paiement` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pret` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `soumis` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consignee_code` varchar(14) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_party_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `beneficiaire` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_amount` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_reason` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `co_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zm_doc_no` text COLLATE utf8mb4_unicode_ci,
  `gl_posting_doc` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clearing_doc` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_address` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_depotage` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `accord_client` tinyint(1) DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `reference` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_agent_notified` datetime DEFAULT NULL,
  `date_agency_notified` datetime DEFAULT NULL,
  `date_client_notified` datetime DEFAULT NULL,
  `date_banque_notified` datetime DEFAULT NULL,
  `email_agency` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_client` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `index_remboursements_on_date_demande` (`date_demande`),
  KEY `index_remboursements_on_id_transitaire` (`id_transitaire`),
  KEY `index_remboursements_on_number` (`number`),
  KEY `index_remboursements_on_status` (`status`),
  KEY `index_remboursements_on_refund_reason` (`refund_reason`),
  CONSTRAINT `fk_remboursements_number` FOREIGN KEY (`number`) REFERENCES `bls` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `schema_migrations` (version) VALUES
('20250717090258'),
('20250717064403'),
('0');

