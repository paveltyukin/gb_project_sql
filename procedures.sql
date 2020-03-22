-- Процедура выводит 7 имен кланов, 
-- игроки которых были активны в течение этого месяца

DROP PROCEDURE IF EXISTS online_game.active7clans
CREATE PROCEDURE online_game.active7clans()
BEGIN
	SELECT clans.name
	  FROM clans
	  JOIN clan_users
	    ON clan_users.clan_id = clans.clan_id 
	    JOIN activity
	      ON activity.gp_id = clan_users.gp_id
	      WHERE date_format(activity.start_at, '%Y%m') = date_format(now(), '%Y%m')
	      	ORDER BY activity.start_at DESC
	        LIMIT 7;
END

-- Процедура выводит имя, фамилию пользователей,
-- которые вступили в клан, который ввел администратор БД
CREATE PROCEDURE getClansUsersInfo
(IN  clanName VARCHAR(255))
BEGIN
	
DECLARE usersCount INT;
DECLARE clanId INT;

SELECT clan_id INTO clanId
FROM clans
WHERE clans.name = clanName;
	SELECT
		up.first_name,
		up.last_name
	FROM user_profiles as up
	JOIN game_profiles as gp
	  ON up.user_id = gp.user_id
		JOIN clan_users as cu
	 		ON cu.clan_id = clanId AND gp.gp_id = cu.gp_id
			ORDER BY up.last_name ASC;
END