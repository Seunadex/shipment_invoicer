/* Updated schema with Rails compatibility fixes */

/* -------------------------------------------------
   Core cargo & finance tables – Rails compatible
   ------------------------------------------------- */

/* Add schema_migrations table for Rails */
CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) NOT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Add ar_internal_metadata table for Rails */
CREATE TABLE IF NOT EXISTS `ar_internal_metadata` (
  `key` varchar(255) NOT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ------------------------  BL  ------------------- */
DROP TABLE IF EXISTS `bls`;
CREATE TABLE `bls` (
  `id`                   BIGINT(20)   NOT NULL AUTO_INCREMENT,
  `id_upload`            BIGINT(20)   DEFAULT NULL,
  `date_upload`          DATETIME     DEFAULT NULL,
  `numero_bl`            VARCHAR(9)   NOT NULL,
  `id_client`            BIGINT(20)   DEFAULT NULL,
  `consignee_code`       VARCHAR(20)  DEFAULT NULL,
  `consignee_name`       VARCHAR(60)  DEFAULT NULL,
  `notified_code`        VARCHAR(20)  DEFAULT NULL,
  `notified_name`        VARCHAR(60)  DEFAULT NULL,
  `vessel_name`          VARCHAR(30)  DEFAULT NULL,
  `vessel_voyage`        VARCHAR(10)  DEFAULT NULL,
  `arrival_date`         DATETIME     DEFAULT NULL,
  `freetime`             INT(6)       DEFAULT NULL,
  `nbre_20pieds_sec`     INT(3)       DEFAULT NULL,
  `nbre_40pieds_sec`     INT(3)       DEFAULT NULL,
  `nbre_20pieds_frigo`   INT(3)       DEFAULT NULL,
  `nbre_40pieds_frigo`   INT(3)       DEFAULT NULL,
  `nbre_20pieds_special` INT(3)       DEFAULT NULL,
  `nbre_40pieds_special` INT(3)       DEFAULT NULL,
  `reef`                 CHAR(1)      DEFAULT '',
  `type_depotage`        VARCHAR(30)  DEFAULT NULL,
  `date_validite`        DATETIME     DEFAULT NULL,
  `statut`               VARCHAR(30)  DEFAULT NULL,
  `exempte`              TINYINT(1)   NOT NULL DEFAULT 0,
  `blocked_for_refund`   TINYINT(1)   NOT NULL DEFAULT 0,
  `reference`            VARCHAR(60)  DEFAULT NULL,
  `comment`              TEXT         DEFAULT NULL,
  `valide`               TINYINT(1)   DEFAULT NULL,
  `released_statut`      VARCHAR(20)  DEFAULT NULL,
  `released_comment`     TEXT         DEFAULT NULL,
  `operator`             VARCHAR(20)  DEFAULT NULL,
  `atp`                  VARCHAR(30)  DEFAULT NULL,
  `consignee_caution`    TINYINT(1)   NOT NULL DEFAULT 0,
  `service_contract`     VARCHAR(200) DEFAULT NULL,
  `bank_account`         VARCHAR(30)  DEFAULT NULL,
  `bank_name`            VARCHAR(30)  DEFAULT NULL,
  `emails`               VARCHAR(60)  DEFAULT NULL,
  `telephone`            VARCHAR(20)  DEFAULT NULL,
  `place_receipt`        VARCHAR(60)  DEFAULT NULL,
  `place_delivery`       VARCHAR(60)  DEFAULT NULL,
  `port_loading`         VARCHAR(60)  DEFAULT NULL,
  `port_discharge`       VARCHAR(60)  DEFAULT NULL,
  `created_at`           DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at`           DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_bls_on_numero_bl` (`numero_bl`),
  KEY `index_bls_on_id_client` (`id_client`),
  KEY `index_bls_on_consignee_code` (`consignee_code`),
  KEY `index_bls_on_consignee_name` (`consignee_name`),
  KEY `index_bls_on_arrival_date` (`arrival_date`),
  KEY `index_bls_on_reef` (`reef`),
  KEY `index_bls_on_statut` (`statut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* ----------------------  CLIENT  ----------------- */
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id`                BIGINT(20)   NOT NULL AUTO_INCREMENT,
  `nom`               VARCHAR(60)  NOT NULL,
  `statut`            VARCHAR(20)  DEFAULT NULL,
  `code_client`       VARCHAR(20)  DEFAULT NULL,
  `nom_groupe`        VARCHAR(150) NOT NULL,
  `paie_caution`      TINYINT(1)   NOT NULL,
  `freetime_frigo`    INT(6)       DEFAULT NULL,
  `freetime_sec`      INT(6)       DEFAULT NULL,
  `prioritaire`       TINYINT(1)   DEFAULT NULL,
  `salesrepid`        BIGINT(20)   DEFAULT NULL,
  `financerepid`      BIGINT(20)   DEFAULT NULL,
  `cservrepid`        BIGINT(20)   DEFAULT NULL,
  `date_validite`     DATETIME     DEFAULT NULL,
  `operator`          VARCHAR(20)  DEFAULT NULL,
  `created_at`        DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at`        DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `index_clients_on_code_client` (`code_client`),
  KEY `index_clients_on_nom` (`nom`),
  KEY `index_clients_on_statut` (`statut`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* --------------------  FACTURE  ------------------ */
DROP TABLE IF EXISTS `factures`;
CREATE TABLE `factures` (
  `id`                         BIGINT(20)    NOT NULL AUTO_INCREMENT,
  `reference`                  VARCHAR(10)   NOT NULL,
  `numero_bl`                  VARCHAR(9)    NOT NULL,
  `code_client`                VARCHAR(20)   NOT NULL,
  `nom_client`                 VARCHAR(60)   NOT NULL,
  `montant_facture`            DECIMAL(12,0) NOT NULL,
  `montant_orig`               DECIMAL(12,2) DEFAULT NULL,
  `devise`                     VARCHAR(6)    DEFAULT 'XOF',
  `statut`                     VARCHAR(10)   NOT NULL DEFAULT 'init',
  `date_facture`               DATETIME      NOT NULL,
  `id_utilisateur`             BIGINT(20)    NOT NULL,
  `create_type_utilisateur`    VARCHAR(20)   DEFAULT NULL,
  `id_utilisateur_update`      BIGINT(20)    DEFAULT NULL,
  `created_at`                 DATETIME(6)   NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at`                 DATETIME(6)   NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_factures_on_reference` (`reference`),
  KEY `index_factures_on_numero_bl` (`numero_bl`),
  KEY `index_factures_on_code_client` (`code_client`),
  KEY `index_factures_on_statut` (`statut`),
  KEY `index_factures_on_date_facture` (`date_facture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* -----------------  REMBOURSEMENT  --------------- */
DROP TABLE IF EXISTS `remboursements`;
CREATE TABLE `remboursements` (
  `id`                    BIGINT(20)   NOT NULL AUTO_INCREMENT,
  `numero_bl`             VARCHAR(9)   NOT NULL,
  `montant_demande`       VARCHAR(15)  DEFAULT NULL,
  `refund_amount`         VARCHAR(15)  DEFAULT NULL,
  `deduction`             VARCHAR(15)  DEFAULT NULL,
  `statut`                VARCHAR(10)  DEFAULT 'PENDING',
  `id_transitaire`        BIGINT(20)   NOT NULL,
  `id_transitaire_maison` BIGINT(20)   DEFAULT NULL,
  `transitaire_notifie`   TINYINT(1)   DEFAULT NULL,
  `maison_notifie`        TINYINT(1)   DEFAULT NULL,
  `banque_notifie`        TINYINT(1)   DEFAULT NULL,
  `date_demande`          DATETIME     DEFAULT NULL,
  `date_refund_traite`    DATETIME     DEFAULT NULL,
  `type_paiement`         VARCHAR(10)  DEFAULT NULL,
  `pret`                  VARCHAR(10)  DEFAULT NULL,
  `soumis`                VARCHAR(10)  DEFAULT NULL,
  `consignee_code`        VARCHAR(14)  DEFAULT NULL,
  `refund_party_name`     VARCHAR(200) DEFAULT NULL,
  `beneficiaire`          VARCHAR(20)  DEFAULT NULL,
  `deposit_amount`        VARCHAR(15)  DEFAULT NULL,
  `reason_for_refund`     VARCHAR(200) DEFAULT NULL,
  `remarks`               VARCHAR(250) DEFAULT NULL,
  `co_code`               VARCHAR(20)  DEFAULT NULL,
  `zm_doc_no`             TEXT         DEFAULT NULL,
  `gl_posting_doc`        VARCHAR(15)  DEFAULT NULL,
  `clearing_doc`          VARCHAR(15)  DEFAULT NULL,
  `email_address`         VARCHAR(60)  DEFAULT NULL,
  `type_depotage`         VARCHAR(40)  DEFAULT NULL,
  `accord_client`         TINYINT(1)   DEFAULT NULL,
  `comment`               TEXT         DEFAULT NULL,
  `reference`             VARCHAR(30)  DEFAULT NULL,
  `date_agent_notified`   DATETIME     DEFAULT NULL,
  `date_agency_notified`  DATETIME     DEFAULT NULL,
  `date_client_notified`  DATETIME     DEFAULT NULL,
  `date_banque_notified`  DATETIME     DEFAULT NULL,
  `email_agency`          VARCHAR(60)  DEFAULT NULL,
  `email_client`          VARCHAR(60)  DEFAULT NULL,
  `created_at`            DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `updated_at`            DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`),
  KEY `index_remboursements_on_numero_bl` (`numero_bl`),
  KEY `index_remboursements_on_statut` (`statut`),
  KEY `index_remboursements_on_reason_for_refund` (`reason_for_refund`),
  KEY `index_remboursements_on_date_demande` (`date_demande`),
  KEY `index_remboursements_on_id_transitaire` (`id_transitaire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Add foreign key constraints */
ALTER TABLE `bls` ADD CONSTRAINT `fk_bls_id_client` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id`);
ALTER TABLE `remboursements` ADD CONSTRAINT `fk_remboursements_numero_bl` FOREIGN KEY (`numero_bl`) REFERENCES `bls` (`numero_bl`);

/* Insert initial schema migration record */
INSERT INTO `schema_migrations` (`version`) VALUES ('0');

/* Insert AR metadata */
INSERT INTO `ar_internal_metadata` (`key`, `value`, `created_at`, `updated_at`) VALUES
('schema_sha1', '', NOW(6), NOW(6)),
('environment', 'development', NOW(6), NOW(6));