DELIMITER $$
CREATE FUNCTION normalizeText( input VARCHAR(255) )RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	RETURN TRIM(UPPER(input));
END$$
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE CREATE_COW(IN cow_name varchar(30), IN cow_desc TEXT, IN alive BOOLEAN, IN heat BOOLEAN, IN gender VARCHAR(10), IN cow_shoes BOOLEAN, IN dehorned BOOLEAN, IN periodic_weight DOUBLE, IN periodic_height DOUBLE, IN clinic_history TEXT, IN medic_history TEXT, IN birth_date DATE)
BEGIN

INSERT INTO cow VALUES(null, normalizeText( cow_name), normalizeText(cow_desc), alive, heat, gender, cow_shoes, dehorned, periodic_weight, periodic_height, clinic_history, medic_history, birth_date); -- TODO: FINISH this

END;;
DELIMITER ;


DELIMITER ;;
CREATE PROCEDURE CREATE_BREED(IN breed_name VARCHAR(16))
BEGIN
INSERT INTO cow VALUES(null, normalizeText(breed_name));
END;;
DELIMITER ;