
-- activity - активность пользователя.
-- Как только заходит в игру, добавляется запись об этом.
--
-- Table structure for table `activity`
--
DROP TABLE IF EXISTS activity;
CREATE TABLE activity (
  `act_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gp_id` INT UNSIGNED NOT NULL,
  `start_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`act_id`),
  KEY `fk_activity_game_profiles` (`gp_id`),
  CONSTRAINT `fk_activity_game_profiles`
  	FOREIGN KEY (`gp_id`) REFERENCES `game_profiles` (`gp_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- clan_users - пользовательские кланы
-- Как только создается клан, или добавляется пользователь в клан, 
-- или удаляется пользователь из клана, то заносится информация в эту таблицу.
--
-- Table structure for table `clan_users`
--
DROP TABLE IF EXISTS clan_users;
CREATE TABLE clan_users (
  `cu_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `clan_id` INT UNSIGNED NOT NULL,
  `gp_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`cu_id`),
  KEY `fk_clan_users_clans` (`clan_id`),
  KEY `fk_clan_users_game_profiles` (`gp_id`),
  CONSTRAINT `fk_clan_users_clans` 
  	FOREIGN KEY (`clan_id`) REFERENCES `clans` (`clan_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE,
  CONSTRAINT `fk_clan_users_game_profiles` 
  	FOREIGN KEY (`gp_id`) REFERENCES `game_profiles` (`gp_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- clans - Кланы. 
-- Таблица содержит информацию о кланах.
--
-- Table structure for table `clans`
--
DROP TABLE IF EXISTS clans;
CREATE TABLE clans (
  `clan_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `level` INT UNSIGNED NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`clan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- competitions - Соревнования. 
-- Таблица содержит информацию о соревнованиях
--
-- Table structure for table `competitions`
--
DROP TABLE IF EXISTS competitions;
CREATE TABLE competitions (
  `comp_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `moves_left` INT UNSIGNED NOT NULL,
  `gl_id` INT UNSIGNED NOT NULL,
  `gp_id` INT UNSIGNED NOT NULL,
  `start_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comp_id`),
  KEY `fk_competitions_game_levels` (`gl_id`),
  KEY `fk_competitions_game_profiles` (`gp_id`),
  CONSTRAINT `fk_competitions_game_levels` 
  	FOREIGN KEY (`gl_id`) REFERENCES `game_levels` (`gl_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE,
  CONSTRAINT `fk_competitions_game_profiles` 
  	FOREIGN KEY (`gp_id`) REFERENCES `game_profiles` (`gp_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- emoji - Эмодзи.
-- Таблица, содержащая эмодзи.
-- Создана, как дополнение чата.
--
-- Table structure for table `emoji`
--
DROP TABLE IF EXISTS emoji;
CREATE TABLE emoji (
  `emoji_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `symbols` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `photo` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`emoji_id`)
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- game_days - Игровой день.
-- Таблица, содержащая информацию о дне, в котором играет пользователь. 
--
-- Table structure for table `game_days`
--
DROP TABLE IF EXISTS game_days;
CREATE TABLE game_days (
  `day_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `gp_id` INT UNSIGNED NOT NULL,
  `day_number` INT UNSIGNED NOT NULL,
  `count_competitions` INT UNSIGNED NOT NULL,
  `count_bonuses` INT UNSIGNED NOT NULL,
  `start_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`day_id`),
  KEY `fk_game_days_game_profiles` (`gp_id`),
  CONSTRAINT `fk_game_days_game_profiles` 
  	FOREIGN KEY (`gp_id`) REFERENCES `game_profiles` (`gp_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- game_levels - Уровень в игре
-- Таблица, в которой содержится информация об уровне игры.
--
-- Table structure for table `game_levels`
--
DROP TABLE IF EXISTS game_levels;
CREATE TABLE game_levels (
  `gl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `number` INT UNSIGNED NOT NULL,
  `tl_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`gl_id`),
  KEY `fk_game_levels_type_levels` (`tl_id`),
  CONSTRAINT `fk_game_levels_type_levels` 
  	FOREIGN KEY (`tl_id`) REFERENCES `type_levels` (`tl_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- game_profiles - Профиль игрока пользователя
-- Таблица, в которой содержится информация об игроке пользователя
--
-- Table structure for table `game_profiles`
--
DROP TABLE IF EXISTS game_profiles;
CREATE TABLE game_profiles (
  `gp_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `money` INT UNSIGNED NOT NULL,
  `days` INT UNSIGNED NOT NULL,
  `level` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`gp_id`),
  KEY `fk_game_profiles_users` (`user_id`),
  CONSTRAINT `fk_game_profiles_users` 
  	FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) 
  		ON DELETE CASCADE
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- heroes - Герои
-- Таблица, в которой содержится информация о героях
--
-- Table structure for table `heroes`
--
DROP TABLE IF EXISTS heroes;
CREATE TABLE heroes (
  `hero_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `task_id` INT UNSIGNED NOT NULL,
  `photo` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `start_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`hero_id`),
  KEY `fk_heroes_tasks` (`task_id`),
  CONSTRAINT `fk_heroes_tasks` 
  	FOREIGN KEY (`task_id`) REFERENCES `tasks` (`task_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- price_list - Прайс-лист.
-- Таблица: в которой содержится информация о товарах и ценах на товары, 
-- которые помогают пройти игру быстрее.
--
-- Table structure for table `price_list`
--
DROP TABLE IF EXISTS price_list;
CREATE TABLE price_list (
  `pl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `current_price` INT UNSIGNED NOT NULL,
  `pl_gds` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
  `gp_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`pl_id`),
  KEY `fk_price_list_game_profiles` (`gp_id`),
  CONSTRAINT `fk_price_list_game_profiles` 
  	FOREIGN KEY (`gp_id`) REFERENCES `game_profiles` (`gp_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- tasks - Задания
-- Таблица: в которой содержится информация о заданиях,
-- которые необходимо пройти, чтобы закончить игровой день.
--
-- Table structure for table `tasks`
--
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (
  `task_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `day_id` INT UNSIGNED NOT NULL,
  `task_name` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `task_full` text COLLATE utf8_unicode_ci NOT NULL,
  `start_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finish_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`task_id`),
  KEY `fk_tasks_game_days` (`day_id`),
  CONSTRAINT `fk_tasks_game_days` 
  	FOREIGN KEY (`day_id`) REFERENCES `game_days` (`day_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- type_levels - Тип уровня игры.
-- Таблица, в которой содержится информация о типах уровня игры: 
-- сложный, средний, простой
--
-- Table structure for table `type_levels`
--
DROP TABLE IF EXISTS type_levels;
CREATE TABLE type_levels (
  `tl_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` INT UNSIGNED NOT NULL,
  `color` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- user_chat - Чат игры.
-- Таблица, в которой содержится информация о чате игроков пользователей 
--
-- Table structure for table `user_chat`
--
DROP TABLE IF EXISTS user_chat;
CREATE TABLE user_chat (
  `chat_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `message` VARCHAR(255) COLLATE utf8_unicode_ci NOT NULL,
  `target_id` INT UNSIGNED DEFAULT NULL,
  `emoji_id` INT UNSIGNED NOT NULL,
  `gp_id` INT UNSIGNED NOT NULL,
  `send_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`chat_id`),
  KEY `fk_user_chat_emoji` (`emoji_id`),
  KEY `fk_user_chat_game_profiles` (`gp_id`),
  CONSTRAINT `fk_user_chat_emoji` 
  	FOREIGN KEY (`emoji_id`) REFERENCES `emoji` (`emoji_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE,
  CONSTRAINT `fk_user_chat_game_profiles` 
  	FOREIGN KEY (`gp_id`) REFERENCES `game_profiles` (`gp_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- user_profiles - Дополнительная информация о пользователях.
-- Таблица, в которой содержится дополнительная информация о пользователях 
--
-- Table structure for table `user_profiles`
--
DROP TABLE IF EXISTS user_profiles;
CREATE TABLE user_profiles (
  `up_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `first_name` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `photo` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `gender` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `birthday` DATETIME NOT NULL,
  PRIMARY KEY (`up_id`),
  KEY `fk_user_profiles_users` (`user_id`),
  KEY `users_profiles_first_last_gender_birthday_photo` (`first_name`,`last_name`,`gender`,`birthday`,`photo`),
  CONSTRAINT `fk_user_profiles_users` 
  	FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- user_social - Дополнительная информация о пользователях.
-- Таблица, в которой содержится дополнительная информация о пользователях 
--
-- Table structure for table `user_social`
--
DROP TABLE IF EXISTS user_social;
CREATE TABLE user_social (
  `user_sid` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT UNSIGNED NOT NULL,
  `user_vk` VARCHAR(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_twitter` VARCHAR(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_fb` VARCHAR(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_ok` VARCHAR(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_sid`),
  KEY `fk_user_social_users` (`user_id`),
  CONSTRAINT `fk_user_social_users` 
  	FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) 
  		ON DELETE CASCADE 
  		ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- users - Информация о пользователях.
-- Таблица, в которой содержится основная информация о пользователях.
--
-- Table structure for table `users`
--
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  `user_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  `register` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `telephone` VARCHAR(30) COLLATE utf8_unicode_ci NOT NULL,
  `user_token` VARCHAR(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `users_name_telephone_uq` (`name`,`telephone`)
) ENGINE=InnoDB AUTO_INCREMENT=501 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;