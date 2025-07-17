
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
  `date_upload` datetime DEFAULT NULL,
  `numero_bl` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_client` bigint DEFAULT NULL,
  `consignee_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consignee_name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notified_code` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notified_name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vessel_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vessel_voyage` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `arrival_date` datetime DEFAULT NULL,
  `freetime` int DEFAULT NULL,
  `nbre_20pieds_sec` int DEFAULT NULL,
  `nbre_40pieds_sec` int DEFAULT NULL,
  `nbre_20pieds_frigo` int DEFAULT NULL,
  `nbre_40pieds_frigo` int DEFAULT NULL,
  `nbre_20pieds_special` int DEFAULT NULL,
  `nbre_40pieds_special` int DEFAULT NULL,
  `reef` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `type_depotage` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_validite` datetime DEFAULT NULL,
  `statut` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exempte` tinyint(1) NOT NULL DEFAULT '0',
  `blocked_for_refund` tinyint(1) NOT NULL DEFAULT '0',
  `reference` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci,
  `valide` tinyint(1) DEFAULT NULL,
  `released_statut` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `released_comment` text COLLATE utf8mb4_unicode_ci,
  `operator` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `atp` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `consignee_caution` tinyint(1) NOT NULL DEFAULT '0',
  `service_contract` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_account` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `bank_name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `emails` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telephone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `place_receipt` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `place_delivery` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port_loading` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port_discharge` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bls_on_numero_bl` (`numero_bl`),
  KEY `index_bls_on_id_client` (`id_client`),
  KEY `index_bls_on_consignee_code` (`consignee_code`),
  KEY `index_bls_on_consignee_name` (`consignee_name`),
  KEY `index_bls_on_arrival_date` (`arrival_date`),
  KEY `index_bls_on_reef` (`reef`),
  KEY `index_bls_on_statut` (`statut`),
  CONSTRAINT `fk_bls_id_client` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nom` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `statut` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_client` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nom_groupe` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paie_caution` tinyint(1) NOT NULL,
  `freetime_frigo` int DEFAULT NULL,
  `freetime_sec` int DEFAULT NULL,
  `prioritaire` tinyint(1) DEFAULT NULL,
  `salesrepid` bigint DEFAULT NULL,
  `financerepid` bigint DEFAULT NULL,
  `cservrepid` bigint DEFAULT NULL,
  `date_validite` datetime DEFAULT NULL,
  `operator` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `index_clients_on_code_client` (`code_client`),
  KEY `index_clients_on_nom` (`nom`),
  KEY `index_clients_on_statut` (`statut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `factures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factures` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `reference` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero_bl` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_client` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom_client` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montant_facture` decimal(12,0) NOT NULL,
  `montant_orig` decimal(12,2) DEFAULT NULL,
  `devise` varchar(6) COLLATE utf8mb4_unicode_ci DEFAULT 'XOF',
  `statut` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'init',
  `date_facture` datetime NOT NULL,
  `id_utilisateur` bigint NOT NULL,
  `create_type_utilisateur` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_utilisateur_update` bigint DEFAULT NULL,
  `created_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_factures_on_reference` (`reference`),
  KEY `index_factures_on_numero_bl` (`numero_bl`),
  KEY `index_factures_on_code_client` (`code_client`),
  KEY `index_factures_on_statut` (`statut`),
  KEY `index_factures_on_date_facture` (`date_facture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `remboursements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `remboursements` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `numero_bl` varchar(9) COLLATE utf8mb4_unicode_ci NOT NULL,
  `montant_demande` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `refund_amount` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deduction` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `statut` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT 'PENDING',
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
  `reason_for_refund` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  KEY `index_remboursements_on_numero_bl` (`numero_bl`),
  KEY `index_remboursements_on_statut` (`statut`),
  KEY `index_remboursements_on_reason_for_refund` (`reason_for_refund`),
  KEY `index_remboursements_on_date_demande` (`date_demande`),
  KEY `index_remboursements_on_id_transitaire` (`id_transitaire`),
  CONSTRAINT `fk_remboursements_numero_bl` FOREIGN KEY (`numero_bl`) REFERENCES `bls` (`numero_bl`)
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
('0');

