DROP TABLE IF EXISTS `assemblies`;
CREATE TABLE `assemblies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `assembly_code` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `planted_at` date NOT NULL,
  `location` varchar(200) NOT NULL,
  `entity_id` int NOT NULL COMMENT 'Assemblies belong to lowest entity which belong to level 1 hierarchy',
  `assembly_leader` int DEFAULT NULL,
  `is_active` enum('yes','no') DEFAULT 'yes',
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `entity_id` (`entity_id`),
  CONSTRAINT `assemblies_ibfk_1` FOREIGN KEY (`entity_id`) REFERENCES `entities` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `attendances`;
CREATE TABLE `attendances` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int NOT NULL,
  `meeting_id` int NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `meeting_id` (`meeting_id`),
  CONSTRAINT `attendances_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`),
  CONSTRAINT `attendances_ibfk_2` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


SET NAMES utf8mb4;

DROP TABLE IF EXISTS `auth_groups_users`;
CREATE TABLE `auth_groups_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_groups_users_user_id_foreign` (`user_id`),
  CONSTRAINT `auth_groups_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `auth_identities`;
CREATE TABLE `auth_identities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `secret` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `secret2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `extra` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `force_reset` tinyint(1) NOT NULL DEFAULT '0',
  `last_used_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_secret` (`type`,`secret`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `auth_identities_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `auth_logins`;
CREATE TABLE `auth_logins` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_type_identifier` (`id_type`,`identifier`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `auth_permissions_users`;
CREATE TABLE `auth_permissions_users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL,
  `permission` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_permissions_users_user_id_foreign` (`user_id`),
  CONSTRAINT `auth_permissions_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `auth_remember_tokens`;
CREATE TABLE `auth_remember_tokens` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `selector` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hashedValidator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int unsigned NOT NULL,
  `expires` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `selector` (`selector`),
  KEY `auth_remember_tokens_user_id_foreign` (`user_id`),
  CONSTRAINT `auth_remember_tokens_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `auth_token_logins`;
CREATE TABLE `auth_token_logins` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `id_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `identifier` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `date` datetime NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_type_identifier` (`id_type`,`identifier`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `collections`;
CREATE TABLE `collections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `return_date` datetime NOT NULL,
  `period_start_date` datetime NOT NULL,
  `period_end_date` datetime NOT NULL,
  `revenue_id` int DEFAULT NULL,
  `assembly_id` int NOT NULL,
  `amount` decimal(50,2) NOT NULL,
  `status` enum('submitted','approved') NOT NULL DEFAULT 'submitted',
  `collection_reference` longtext NOT NULL,
  `description` longtext NOT NULL,
  `collection_method` enum('banking','mobile','in-person') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'in-person',
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  `sunday_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revenue_id` (`revenue_id`),
  KEY `assembly_id` (`assembly_id`),
  CONSTRAINT `collections_ibfk_1` FOREIGN KEY (`revenue_id`) REFERENCES `revenues` (`id`),
  CONSTRAINT `collections_ibfk_2` FOREIGN KEY (`assembly_id`) REFERENCES `assemblies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `collectiontypes`;
CREATE TABLE `collectiontypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` int NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime NOT NULL,
  `deleted_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `collectiontypes_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `customfields`;
CREATE TABLE `customfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` int DEFAULT NULL,
  `field_name` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `field_code` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `helptip` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `table_name` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `type` enum('string','text','float','date','datetime','timestamp','password','numeric','email','dropdown','boolean') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'string',
  `options` longtext NOT NULL,
  `feature_id` int NOT NULL,
  `field_order` int DEFAULT '0',
  `visible` enum('yes','no') NOT NULL DEFAULT 'yes',
  `query_builder` json DEFAULT NULL,
  `code_builder` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`field_name`),
  UNIQUE KEY `field_code` (`field_code`),
  KEY `feature_id` (`feature_id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `customfields_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`),
  CONSTRAINT `customfields_ibfk_2` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `customvalues`;
CREATE TABLE `customvalues` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feature_id` int NOT NULL,
  `record_id` int NOT NULL,
  `customfield_id` int DEFAULT NULL,
  `value` varchar(200) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customfield_id` (`customfield_id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `customvalues_ibfk_1` FOREIGN KEY (`customfield_id`) REFERENCES `customfields` (`id`),
  CONSTRAINT `customvalues_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `dashboards`;
CREATE TABLE `dashboards` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `values` longtext NOT NULL,
  `roles` longtext,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `denominations`;
CREATE TABLE `denominations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `code` varchar(20) DEFAULT NULL,
  `registration_date` date NOT NULL,
  `head_office` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `department_code` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `designations`;
CREATE TABLE `designations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `denomination_id` int NOT NULL,
  `is_hierarchy_leader_designation` enum('no','yes') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `is_department_leader_designation` enum('no','yes') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `is_minister_title_designation` enum('no','yes') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `designations_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `entities`;
CREATE TABLE `entities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `hierarchy_id` int NOT NULL,
  `entity_number` varchar(50) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `parent_id` int DEFAULT NULL,
  `entity_leader` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hierarchy_id` (`hierarchy_id`),
  KEY `entity_number` (`entity_number`),
  CONSTRAINT `entities_ibfk_1` FOREIGN KEY (`hierarchy_id`) REFERENCES `hierarchies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `meeting_id` int DEFAULT '1',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `code` varchar(10) NOT NULL,
  `location` varchar(100) NOT NULL,
  `description` longtext,
  `denomination_id` int NOT NULL,
  `registration_fees` decimal(10,2) NOT NULL DEFAULT '0.00',
  `assemblies` longtext,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  KEY `meeting_id` (`meeting_id`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `features`;
CREATE TABLE `features` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `allowable_permission_labels` json NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  `feature_type` varchar(20) NOT NULL DEFAULT 'all',
  `is_menu_item` enum('yes','no') NOT NULL DEFAULT 'no',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gatherings`;
CREATE TABLE `gatherings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assembly_id` int NOT NULL,
  `meeting_id` int NOT NULL,
  `meeting_date` date NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime NOT NULL,
  `deleted_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `assembly_id` (`assembly_id`),
  KEY `meeting_id` (`meeting_id`),
  CONSTRAINT `gatherings_ibfk_1` FOREIGN KEY (`assembly_id`) REFERENCES `assemblies` (`id`),
  CONSTRAINT `gatherings_ibfk_2` FOREIGN KEY (`meeting_id`) REFERENCES `meetings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gatheringtypes`;
CREATE TABLE `gatheringtypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` int NOT NULL,
  `description` longtext,
  `name` varchar(200) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `gatheringtypes_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `hierarchies`;
CREATE TABLE `hierarchies` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `denomination_id` int NOT NULL,
  `hierarchy_code` varchar(10) NOT NULL,
  `level` int NOT NULL DEFAULT '1' COMMENT 'starts from 1,2,3,....n: 1 being the lowest',
  `description` longtext,
  `created_at` timestamp NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `hierarchies_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `logmails`;
CREATE TABLE `logmails` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email_to` varchar(150) NOT NULL,
  `subject` longtext NOT NULL,
  `email_body` longtext NOT NULL,
  `send_status` enum('new','sent','failed') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'new',
  `count_failure` int DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `meetings`;
CREATE TABLE `meetings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` int NOT NULL,
  `name` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `description` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `meetings_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `members`;
CREATE TABLE `members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `gender` enum('male','female') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `membership_date` date DEFAULT NULL,
  `member_number` varchar(100) DEFAULT NULL,
  `designation_id` int DEFAULT NULL,
  `parent_id` int DEFAULT NULL,
  `date_of_birth` date NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(100) NOT NULL,
  `saved_date` date DEFAULT NULL,
  `inactivation_reason` enum('deceased','excluded','other') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'other',
  `inactivation_date` date DEFAULT NULL,
  `is_active` enum('yes','no') NOT NULL DEFAULT 'yes',
  `assembly_id` int NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `assembly_id` (`assembly_id`),
  KEY `designation_id` (`designation_id`),
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`assembly_id`) REFERENCES `assemblies` (`id`),
  CONSTRAINT `members_ibfk_2` FOREIGN KEY (`designation_id`) REFERENCES `designations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP VIEW IF EXISTS `members_custom`;
CREATE TABLE `members_custom` (`id` int, `first_name` varchar(100), `last_name` varchar(100), `gender` enum('male','female'), `membership_date` date, `member_number` varchar(100), `designation_id` int, `parent_id` int, `date_of_birth` date, `email` varchar(100), `phone` varchar(100), `saved_date` date, `inactivation_reason` enum('deceased','excluded','other'), `inactivation_date` date, `is_active` enum('yes','no'), `assembly_id` int, `created_at` datetime, `created_by` int, `updated_at` datetime, `updated_by` int, `deleted_at` datetime, `deleted_by` int, `designation_name` varchar(100), `assembly_name` varchar(100), `custom_field_name` varchar(200), `custom_value` varchar(200));


DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `icon` varchar(100) NOT NULL DEFAULT 'entypo-home',
  `feature_id` int NOT NULL,
  `parent_id` int NOT NULL DEFAULT '0',
  `visible` enum('yes','no') NOT NULL DEFAULT 'yes',
  `order` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `menus_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int NOT NULL,
  `batch` int unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `ministers`;
CREATE TABLE `ministers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `minister_number` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `member_id` int DEFAULT NULL,
  `is_active` enum('yes','no') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'yes',
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `minister_number` (`minister_number`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `ministers_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `participants`;
CREATE TABLE `participants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `member_id` int DEFAULT NULL,
  `event_id` int NOT NULL,
  `payment_id` int DEFAULT NULL,
  `payment_code` varchar(50) DEFAULT NULL,
  `registration_amount` decimal(10,2) DEFAULT '0.00',
  `status` enum('registered','attended','cancelled') NOT NULL DEFAULT 'registered',
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime NOT NULL,
  `deleted_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `member_id` (`member_id`),
  KEY `event_id` (`event_id`),
  KEY `payment_id` (`payment_id`),
  CONSTRAINT `participants_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`),
  CONSTRAINT `participants_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `participants_ibfk_3` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `phone` varchar(50) NOT NULL,
  `payment_code` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `redeemed_amount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `payment_status` enum('waiting','success','failed','confirmed') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'waiting',
  `denomination_id` int DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feature_id` int NOT NULL,
  `role_id` int NOT NULL,
  `permission_label` varchar(10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` int DEFAULT NULL,
  `updated_by` datetime DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  `deleted_by` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `feature_id_role_id` (`feature_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `permissions_ibfk_1` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`),
  CONSTRAINT `permissions_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `permits`;
CREATE TABLE `permits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(63) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `user_id` int DEFAULT NULL,
  `group_id` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `user_id_name` (`user_id`,`name`),
  KEY `group_id_name` (`group_id`,`name`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `queue_jobs`;
CREATE TABLE `queue_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(64) NOT NULL,
  `payload` text NOT NULL,
  `priority` varchar(64) NOT NULL DEFAULT 'default',
  `status` tinyint unsigned NOT NULL DEFAULT '0',
  `attempts` tinyint unsigned NOT NULL DEFAULT '0',
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_priority_status_available_at` (`queue`,`priority`,`status`,`available_at`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `queue_jobs_failed`;
CREATE TABLE `queue_jobs_failed` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` varchar(64) NOT NULL,
  `queue` varchar(64) NOT NULL,
  `payload` text NOT NULL,
  `priority` varchar(64) NOT NULL DEFAULT 'default',
  `exception` text NOT NULL,
  `failed_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `queue` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reportfields`;
CREATE TABLE `reportfields` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `report_id` int NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `placeholder` varchar(100) DEFAULT NULL,
  `type` enum('text','select','checkbox','radio','textarea') NOT NULL DEFAULT 'text',
  `options` longtext,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  CONSTRAINT `reportfields_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `assembly_id` int DEFAULT NULL,
  `reports_type_id` int NOT NULL,
  `report_period` date NOT NULL,
  `report_date` date DEFAULT NULL,
  `status` enum('draft','submitted','approved') NOT NULL DEFAULT 'draft',
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_type_id` (`reports_type_id`),
  KEY `assembly_id` (`assembly_id`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`reports_type_id`) REFERENCES `reporttypes` (`id`),
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`assembly_id`) REFERENCES `assemblies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reporttypes`;
CREATE TABLE `reporttypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `type_code` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `denomination_id` int NOT NULL,
  `scheduler` enum('daily','weekly','monthly','quarterly','annually') NOT NULL DEFAULT 'monthly',
  `report_layout` json DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `reporttypes_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `reportvalues`;
CREATE TABLE `reportvalues` (
  `report_id` int NOT NULL,
  `values` json NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`report_id`),
  CONSTRAINT `reportvalues_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `revenues`;
CREATE TABLE `revenues` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` int NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime NOT NULL,
  `deleted_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `revenues_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `permissions` json DEFAULT NULL,
  `default_role` enum('yes','no') DEFAULT 'no',
  `denomination_id` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  `role_type` enum('admin','church') DEFAULT 'church',
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `sections`;
CREATE TABLE `sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `order` int NOT NULL DEFAULT '1',
  `customfield_id` int NOT NULL,
  `reporttype_id` int NOT NULL,
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customfield_id` (`customfield_id`),
  KEY `reporttype_id` (`reporttype_id`),
  CONSTRAINT `sections_ibfk_1` FOREIGN KEY (`customfield_id`) REFERENCES `customfields` (`id`),
  CONSTRAINT `sections_ibfk_2` FOREIGN KEY (`reporttype_id`) REFERENCES `reporttypes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text,
  `type` varchar(31) NOT NULL DEFAULT 'string',
  `context` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` int NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `subscription_type_id` int NOT NULL,
  `status` enum('active','terminated') NOT NULL DEFAULT 'active',
  `is_auto_renewal` enum('yes','no') NOT NULL DEFAULT 'no',
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime NOT NULL,
  `deleted_by` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  KEY `subscription_type_id` (`subscription_type_id`),
  CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`),
  CONSTRAINT `subscriptions_ibfk_2` FOREIGN KEY (`subscription_type_id`) REFERENCES `subscriptiontypes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `subscriptiontypes`;
CREATE TABLE `subscriptiontypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `features` longtext NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` datetime NOT NULL,
  `deleted_by` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tasks`;
CREATE TABLE `tasks` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `status` enum('Not Started','In Progress','Completed','Rejected') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Not Started',
  `allowable_status_labels` json NOT NULL,
  `user_id` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `deleted_at` int DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `templates`;
CREATE TABLE `templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `denomination_id` int DEFAULT NULL,
  `short_name` varchar(255) NOT NULL,
  `template_vars` longtext NOT NULL,
  `template_subject` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `template_body` longtext NOT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `denomination_id` (`denomination_id`),
  CONSTRAINT `templates_ibfk_1` FOREIGN KEY (`denomination_id`) REFERENCES `denominations` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tithes`;
CREATE TABLE `tithes` (
  `id` int NOT NULL,
  `member_id` int DEFAULT NULL,
  `amount` float NOT NULL,
  `created_at` date DEFAULT NULL,
  `created_by` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `deleted_at` int DEFAULT NULL,
  `deleted_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS `trashes`;
CREATE TABLE `trashes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `feature_id` int DEFAULT NULL,
  `feature_name` int DEFAULT NULL,
  `item_id` int NOT NULL,
  `item_name` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `item_deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feature_name` (`feature_name`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `trashes_ibfk_1` FOREIGN KEY (`feature_name`) REFERENCES `features` (`id`),
  CONSTRAINT `trashes_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `last_active` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `denomination_id` int unsigned DEFAULT NULL,
  `first_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `biography` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `date_of_birth` date DEFAULT NULL,
  `gender` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `roles` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_system_admin` enum('yes','no') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'no',
  `access_count` int DEFAULT NULL,
  `associated_member_id` int DEFAULT NULL,
  `permitted_entities` json DEFAULT NULL,
  `permitted_assemblies` json DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  `user_type` enum('admin','church') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'church',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `associated_member_id` (`associated_member_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`associated_member_id`) REFERENCES `members` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `visitors`;
CREATE TABLE `visitors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(200) NOT NULL,
  `last_name` varchar(200) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `gender` enum('male','female') NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `event_id` int NOT NULL,
  `payment_id` int DEFAULT NULL,
  `payment_code` varchar(50) DEFAULT NULL,
  `registration_amount` decimal(10,2) DEFAULT NULL,
  `status` enum('registered','attended','cancelled') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'registered',
  `created_by` int NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_by` int NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_by` int DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `payment_id` (`payment_id`),
  CONSTRAINT `visitors_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`),
  CONSTRAINT `visitors_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

