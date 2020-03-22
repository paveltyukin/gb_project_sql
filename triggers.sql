
-- Для безопасности. При вставке новой записи или обновлении записи, 
-- ячейка должна быть заполнена, что проверяют данные триггеры. 
-- Иначе выскакивает ошибка.
CREATE TRIGGER bi_users_token BEFORE INSERT ON users
FOR EACH ROW BEGIN
  IF NEW.user_token IS NULL OR NEW.user_token = '' THEN
    SIGNAL SQLSTATE '70007'
    SET MESSAGE_TEXT = 'token is NULL';
  END IF;
END;

CREATE TRIGGER bu_users_token BEFORE UPDATE ON users
FOR EACH ROW BEGIN
  IF NEW.user_token IS NULL OR NEW.user_token = '' THEN
    SIGNAL SQLSTATE '70007'
    SET MESSAGE_TEXT = 'token is NULL';
  END IF;
END;