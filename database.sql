CREATE TABLE `developer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `genre` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `platform` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `publisher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `game` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `publisher_id` bigint(20) NOT NULL,
  `developer_id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  `price` decimal(10,2) NULL,
  PRIMARY KEY (`id`),
  KEY `game_developer_FK` (`developer_id`),
  KEY `game_publisher_FK` (`publisher_id`),
  CONSTRAINT `game_developer_FK` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`id`),
  CONSTRAINT `game_publisher_FK` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`id`)
);

CREATE TABLE `game_edition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `game_id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  `price` varchar(100) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `game_edition_game_FK` (`game_id`),
  CONSTRAINT `game_edition_game_FK` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`)
);

CREATE TABLE `store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `platform_id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `store_platform_FK` (`platform_id`),
  CONSTRAINT `store_platform_FK` FOREIGN KEY (`platform_id`) REFERENCES `platform` (`id`)
);

CREATE TABLE `game_genres` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `game_id` bigint(20) NOT NULL,
  `genre_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `game_genres_game_FK` (`game_id`),
  KEY `game_genres_genre_FK` (`genre_id`),
  CONSTRAINT `game_genres_game_FK` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`),
  CONSTRAINT `game_genres_genre_FK` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`id`)
);

CREATE TABLE `dlc` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `game_id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`id`),
  KEY `dlc_game_FK` (`game_id`),
  CONSTRAINT `dlc_game_FK` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`)
);

CREATE TABLE `dlc_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dlc_id` bigint(20) NOT NULL,
  `store_id` bigint(20) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `date` date NOT NULL,
  `gift` bit(1) NOT NULL DEFAULT b'0',
  `bundle` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`),
  KEY `dlc_store_store_FK` (`store_id`),
  KEY `dlc_store_dlc_FK` (`dlc_id`),
  CONSTRAINT `dlc_store_dlc_FK` FOREIGN KEY (`dlc_id`) REFERENCES `dlc` (`id`),
  CONSTRAINT `dlc_store_store_FK` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
);

CREATE TABLE `game_store` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `game_id` bigint(20) NOT NULL,
  `game_edition_id` bigint(20) DEFAULT NULL,
  `store_id` bigint(20) NOT NULL,
  `price` decimal(10,2),
  `date` date NOT NULL,
  `gift` bit(1) NOT NULL DEFAULT b'0',
  `box` bit(1) NOT NULL DEFAULT b'0',
  `disc` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `game_store_store_FK` (`store_id`),
  KEY `game_store_game_FK` (`game_id`),
  KEY `game_store_game_edition_FK` (`game_edition_id`),
  CONSTRAINT `game_store_game_FK` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`),
  CONSTRAINT `game_store_game_edition_FK` FOREIGN KEY (`game_edition_id`) REFERENCES `game_edition` (`id`),
  CONSTRAINT `game_store_store_FK` FOREIGN KEY (`store_id`) REFERENCES `store` (`id`)
);
