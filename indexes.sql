-- Name, telephone - данные столбцы, скорее всего будут запрашиваться часто. 
-- Они уникальны
CREATE UNIQUE INDEX users_name_telephone_uq ON users(name, telephone);

-- first_name,last_name,gender,birthday,photo - 
-- данные столбцы, скорее всего будут запрашиваться часто.
CREATE INDEX users_profiles_first_last_gender_birthday_photo 
ON user_profiles(first_name,last_name,gender,birthday,photo);