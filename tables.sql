
CREATE SCHEMA `online_game` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE online_game;

CREATE TABLE `online_game`.`users` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_register` datetime DEFAULT current_timestamp(),
  `user_telephone` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `online_game`.`profiles` (
  `profile_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `p_first_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `p_last_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `p_photo` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `p_gender` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `p_birthday` datetime NOT NULL,
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


