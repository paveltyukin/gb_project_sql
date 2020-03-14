
CREATE SCHEMA `online_game` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE online_game;

CREATE TABLE `online_game`.`users` (
  `user_id` INT NOT NULL,
  `user_name` VARCHAR(100) NULL DEFAULT NULL,
  `user_password` VARCHAR(100) NULL DEFAULT NULL,
  `user_register` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `user_telephone` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `online_game`.`profiles` (
	`profile_id` INT NOT NULL,
	`user_id` INT NOT NULL,
	`p_first_name` VARCHAR(100) NOT NULL,
	`p_last_name` VARCHAR(100) NOT NULL,
	`p_photo` VARCHAR(100) NOT NULL,
	PRIMARY KEY (`profile_id`),
	CONSTRAINT fk_profiles_users FOREIGN KEY (user_id)
		REFERENCES users (user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE `online_game`.`heroes` (
	`hero_id` INT NOT NULL,
	`hero_name` VARCHAR(100) NOT NULL,
	`profile_id` INT NOT NULL,
	`hero_photo` VARCHAR(100) NOT NULL,
	`hero_type_id` INT NOT NULL,
    `hero_gender` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
	`hero_start` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`hero_id`),
	CONSTRAINT fk_heroes_profiles FOREIGN KEY (profile_id)
		REFERENCES profiles (profile_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


