CREATE SCHEMA online_game DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE online_game2;

CREATE TABLE online_game.users (
	`user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_name` VARCHAR(100) NOT NULL,
	`user_password` VARCHAR(100) NOT NULL,
	`user_register` DATETIME DEFAULT CURRENT_TIMESTAMP,
	`user_telephone` VARCHAR(30) NOT NULL
);

CREATE TABLE online_game.profiles (
	`profile_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`user_id` INT UNSIGNED NOT NULL,
	`p_first_name` VARCHAR(100) NOT NULL,
	`p_last_name` VARCHAR(100) NOT NULL,
	`p_photo` VARCHAR(100) NOT NULL,
	`p_gender` VARCHAR(100) NOT NULL,
	`p_birthday` DATETIME NOT NULL,
	CONSTRAINT fk_profiles_users FOREIGN KEY (user_id)
		REFERENCES users (user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE online_game.heroes (
	`hero_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	`hero_name` VARCHAR(100) NOT NULL,
	`profile_id` INT UNSIGNED NOT NULL,
	`hero_photo` VARCHAR(100) NOT NULL,
	`hero_type_id` INT NOT NULL,
	`hero_gender` VARCHAR(100) NOT NULL,
	`hero_start` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT fk_heroes_profiles FOREIGN KEY (profile_id)
		REFERENCES profiles (profile_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);