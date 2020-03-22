-- Показать последние 7 сообщений ползователей, 
-- которые были активены в течение последних 7 дней
CREATE VIEW LAST7MESSAGES AS
SELECT
    user_chat.message AS `Message`,
    DATE_FORMAT(user_chat.send_at, '%d-%m-%Y %H:%i') AS `Send`
FROM
    online_game2.user_chat
JOIN online_game2.activity on
    activity.gp_id = user_chat.gp_id AND 
    activity.start_at BETWEEN (CURDATE() - INTERVAL 7 DAY) AND CURDATE()
ORDER BY
    activity.start_at DESC
LIMIT 7;

-- Показать имя, фамилию пользователя, 
-- который участвовал в соревнованиях последние 7 дней
CREATE VIEW ACTIVEUSERS7DAYS AS
SELECT 
	user_profiles.first_name, 
	user_profiles.last_name 
FROM user_profiles
JOIN game_profiles 
  ON game_profiles.user_id = user_profiles.user_id
JOIN competitions
  ON competitions.gp_id = game_profiles.gp_id AND 
     competitions.start_at BETWEEN (CURDATE() - INTERVAL 7 DAY) AND CURDATE() 
ORDER BY user_profiles.last_name ASC
LIMIT 10;