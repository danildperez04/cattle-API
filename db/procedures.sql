DELIMITER $$
CREATE FUNCTION normalizeText( input VARCHAR(255) )RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	RETURN TRIM(UPPER(input));
END$$
DELIMITER ;

CREATE PROCEDURE CREATE_COW(IN cow_name varchar(30), IN cow_desc VARCHAR(10), IN alive BOOLEAN, IN heat DATE, IN gender VARCHAR(10), IN cow_shoes DATE, IN dehorned DATE, IN birth_date DATE)
BEGIN
INSERT INTO cow VALUES(null, normalizeText(cow_name), normalizeText(cow_desc), alive, heat, normalizeText(gender), cow_shoes, dehorned, birth_date); -- TODO: FINISH this
END;;
DELIMITER ;


DELIMITER ;;
CREATE PROCEDURE CREATE_BREED(IN breed_name VARCHAR(16))
BEGIN
INSERT INTO cow VALUES(null, normalizeText(breed_name));
END;;
DELIMITER ;