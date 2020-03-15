CREATE SCHEMA online_game DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE online_game;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_name` VARCHAR(100)  NOT NULL,
  `user_password` VARCHAR(100) NOT NULL,
  `user_register` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `user_telephone` VARCHAR(30) DEFAULT NULL,
  `user_token` VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS user_social;
CREATE TABLE user_social (
  `user_sid` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT UNSIGNED NOT NULL,
  `user_vk` VARCHAR(100) DEFAULT NULL,
  `user_twitter` VARCHAR(100) DEFAULT NULL,
  `user_fb` VARCHAR(100) DEFAULT NULL,
  `user_ok` VARCHAR(100) DEFAULT NULL,
  CONSTRAINT fk_user_social_users FOREIGN KEY (user_id)
		REFERENCES users (user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS user_profiles;
CREATE TABLE user_profiles (
  `up_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT UNSIGNED NOT NULL,
  `up_first_name` VARCHAR(100)  NOT NULL,
  `up_last_name` VARCHAR(100)  NOT NULL,
  `up_photo` VARCHAR(100)  NOT NULL,
  `up_gender` VARCHAR(100)  NOT NULL,
  `up_birthday` DATETIME NOT NULL,
  CONSTRAINT fk_user_profiles_users FOREIGN KEY (user_id)
		REFERENCES users (user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);


DROP TABLE IF EXISTS game_profiles;
CREATE TABLE game_profiles (
  `gp_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `gp_price` INT UNSIGNED NOT NULL,
  `gp_money` INT UNSIGNED NOT NULL,
  `gp_days` INT UNSIGNED NOT NULL,
  `gp_level` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  CONSTRAINT fk_game_profiles_users FOREIGN KEY (user_id)
		REFERENCES users (user_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS game_days;
CREATE TABLE game_days (
  `day_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `gp_id` INT UNSIGNED NOT NULL,
  `day_number` INT UNSIGNED NOT NULL,
  `count_competitions` INT UNSIGNED NOT NULL,
  `count_bonuses` INT UNSIGNED NOT NULL,
  CONSTRAINT fk_game_days_game_profiles FOREIGN KEY (gp_id)
		REFERENCES game_profiles (gp_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (
  `task_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `day_id` INT UNSIGNED NOT NULL,
  `task_name` VARCHAR(100) NOT NULL,
  `task_full` text NOT NULL,
   CONSTRAINT fk_tasks_game_days FOREIGN KEY (day_id)
		REFERENCES game_days (day_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS heroes;
CREATE TABLE heroes (
  `hero_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `hero_name` VARCHAR(100)  NOT NULL,
  `task_id` INT UNSIGNED NOT NULL,
  `hero_photo` VARCHAR(100)  NOT NULL,
  `hero_type_id` INT UNSIGNED NOT NULL,
  CONSTRAINT fk_heroes_tasks FOREIGN KEY (task_id)
		REFERENCES tasks (task_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS type_levels;
CREATE TABLE type_levels (
  `tl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `tl_name` INT UNSIGNED NOT NULL,
  `tl_color` VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS game_levels;
CREATE TABLE game_levels (
  `gl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `gl_number` INT UNSIGNED NOT NULL,
  `tl_id` INT UNSIGNED NOT NULL,
  CONSTRAINT fk_game_levels_type_levels FOREIGN KEY (tl_id)
		REFERENCES type_levels (tl_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS competitions;
CREATE TABLE competitions (
  `comp_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `moves_left` INT UNSIGNED NOT NULL,
  `gl_id` INT UNSIGNED NOT NULL,
  `gp_id` INT UNSIGNED NOT NULL,
  CONSTRAINT fk_competitions_game_levels FOREIGN KEY (gl_id)
		REFERENCES game_levels (gl_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_competitions_game_profiles FOREIGN KEY (gp_id)
		REFERENCES game_profiles (gp_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS price_list;
CREATE TABLE price_list (
  `pl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `current_price` INT UNSIGNED NOT NULL,
  `pl_gds` VARCHAR(255) NOT NULL,
  `gp_id` INT UNSIGNED NOT NULL,
	CONSTRAINT fk_price_list_game_profiles FOREIGN KEY (gp_id)
		REFERENCES game_profiles (gp_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS emoji;
CREATE TABLE emoji (
  `emoji_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `emoji_name` VARCHAR(100) NOT NULL,
  `emoji_symbols` VARCHAR(100) NOT NULL,
  `emoji_photo` VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS user_chat;
CREATE TABLE user_chat (
  `chat_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `user_message` VARCHAR(255) NOT NULL,
  `target_id` INT UNSIGNED DEFAULT NULL,
  `emoji_id` INT UNSIGNED NOT NULL,
  `gp_id` INT UNSIGNED NOT NULL,
  CONSTRAINT fk_user_chat_emoji FOREIGN KEY (emoji_id)
		REFERENCES emoji (emoji_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_user_chat_game_profiles FOREIGN KEY (gp_id)
		REFERENCES game_profiles (gp_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

DROP TABLE IF EXISTS clans;
CREATE TABLE clans (
  `clan_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `clan_name` VARCHAR(100) NOT NULL,
  `clan_level` INT UNSIGNED NOT NULL
);

DROP TABLE IF EXISTS clan_users;
CREATE TABLE clan_users (
  `cu_id` INT UNSIGNED NOT NULL,
  `clan_id` INT UNSIGNED NOT NULL,
  `gp_id` INT UNSIGNED NOT NULL,
	CONSTRAINT fk_clan_users_clans FOREIGN KEY (clan_id)
		REFERENCES clans (clan_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_clan_users_game_profiles FOREIGN KEY (gp_id)
		REFERENCES game_profiles (gp_id)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

