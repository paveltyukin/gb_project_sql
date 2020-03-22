-- Полная информация о пользователях, которые зарегистрировались в этом месяце
SELECT
	users.name,
	users.telephone,
	user_profiles.first_name,
	user_profiles.last_name,
	user_profiles.gender,
	user_profiles.photo,
	user_profiles.birthday,
	user_social.user_fb,
	user_social.user_vk,
	user_social.user_ok,
	user_social.user_twitter,
	user_social.user_fb,
	game_profiles.days,
	game_profiles.`level`,
	game_profiles.money
FROM users
	JOIN user_profiles
	ON user_profiles.user_id = users.user_id
		JOIN user_social
		ON user_social.user_id = users.user_id
			JOIN game_profiles
			ON game_profiles.user_id = users.user_id AND
			DATE_FORMAT(users.register, '%Y%m') = DATE_FORMAT(CURDATE(), '%Y%m')
			ORDER BY users.name ASC;


-- Оконная функция. Возвращает краткую информацию о пользователях,
-- состоящих во всех кланах.
SELECT 
	DISTINCT clans.name,
	CONCAT_WS(' ', user_profiles.first_name, user_profiles.last_name) as 'info',
	DATE_FORMAT(CURDATE(), '%Y') - DATE_FORMAT(user_profiles.birthday , '%Y') as 'age',
	ROW_NUMBER() OVER(PARTITION BY clan_users.clan_id) AS 'row_count'
	FROM clan_users
	JOIN clans
		ON clans.clan_id = clan_users.clan_id
			JOIN game_profiles 
			ON game_profiles.gp_id = clan_users.gp_id
				JOIN user_profiles
				ON user_profiles.user_id = game_profiles.user_id;


-- Группировка. Сколько пользователей одинаково зовут и имеют одиинаковую фамилию.
SELECT first_name, COUNT(first_name) FROM user_profiles GROUP BY first_name;
SELECT last_name,  COUNT(last_name)  FROM user_profiles GROUP BY last_name;


-- Вложенные запросы. Узнать сколько дней играют каждый пользователь
SELECT 
	name, 
	telephone, 
	(SELECT days FROM game_profiles WHERE game_profiles.user_id = users.user_id) as user_days
FROM users
ORDER BY user_id;


-- Найти самого популярного пользователя (которому больше все пишут)
SELECT 
	target_id AS user_id, 
	COUNT(target_id) AS count_mess 
FROM user_chat 
GROUP BY target_id 
ORDER BY count_mess DESC 
LIMIT 1;
