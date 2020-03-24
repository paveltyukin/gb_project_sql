-- Функция возвращает средний возраст участников клана,
-- который вводит администратор БД при вызове функции.

CREATE FUNCTION avgClansUsres(clanName VARCHAR(255)) RETURNS DECIMAL(5,1)
    READS SQL DATA
BEGIN
	
	DECLARE avgUsers DECIMAL(5,1);

	SELECT
		ROUND(AVG(DATE_FORMAT(CURDATE() , '%Y') - DATE_FORMAT(up.birthday, '%Y')), 1) INTO avgUsers
	FROM user_profiles as up
	JOIN game_profiles as gp
	ON up.user_id = gp.user_id
		JOIN clan_users as cu
		ON cu.gp_id = gp.gp_id 
			JOIN clans as c
			ON c.clan_id = cu.clan_id 
			AND c.name = clanName;
	RETURN avgUsers;
END

-- Функция возвращает максимальную цену, которая показывается в прайс-листе пользователю, 
-- который участвовал в соревнованиях на текущей неделе, из клана, 
-- который вводит администратор БД.
CREATE FUNCTION maxPriceClansUsers(clanName VARCHAR(255)) RETURNS DECIMAL(5,1)
    READS SQL DATA
BEGIN
	
	DECLARE maxPrice DECIMAL(5,1);

	SELECT
		MAX(pl.current_price) INTO maxPrice
	FROM price_list as pl
	JOIN game_profiles as gp
	ON pl.gp_id = gp.gp_id
		JOIN clan_users as cu
		ON cu.gp_id = gp.gp_id 
			JOIN clans as c
			ON c.clan_id = cu.clan_id 
			AND c.name = clanName
				JOIN competitions as cm
				ON cu.gp_id = cm.gp_id 
				AND (YEAR(cm.start_at) = YEAR(CURDATE()) AND WEEK(cm.start_at, 1) = WEEK(CURDATE(), 1));

	RETURN maxPrice;

END