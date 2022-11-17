DELIMITER $$
CREATE FUNCTION normalizeText( input VARCHAR(255) )RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	RETURN TRIM(UPPER(input));
END$$
DELIMITER ;

DELIMITER ;; -- COWS
CREATE PROCEDURE GET_COWS()
BEGIN
	SELECT * FROM cow_view;
END;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE GET_COW(IN id INT)
BEGIN
	SELECT * FROM cow_view WHERE id_cow = id;
END;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE CREATE_COW(IN cow_name VARCHAR(30), IN cow_desc VARCHAR(10), IN alive BOOLEAN, IN heat DATE, IN gender VARCHAR(10), IN cow_shoes DATE, IN dehorned DATE, IN birth_date DATE)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		SELECT "HA OCURRIDO UN ERROR" AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
		INSERT INTO cow VALUES(null, normalizeText(cow_name), normalizeText(cow_desc), alive, heat, normalizeText(gender), cow_shoes, dehorned, birth_date); -- TODO: FINISH this
		COMMIT;
    END;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS UPDATE_COW;
DELIMITER ;;
CREATE PROCEDURE UPDATE_COW(IN id_cow INT, cow_name VARCHAR(30), IN cow_desc VARCHAR(10), IN alive BOOLEAN, IN heat DATE, IN gender VARCHAR(10), IN cow_shoes DATE, IN dehorned DATE, IN birth_date DATE)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
	START TRANSACTION;
    BEGIN
		IF (SELECT NOT c.alive FROM cow c WHERE c.id_cow = id_cow) THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se puede hacer ninguna operacion con una vaca muerta';
		END IF;
		UPDATE cow c SET c.cow_name = cow_name, c.cow_desc = cow_desc, c.alive = alive, c.heat = heat, c.gender = gender, c.cow_shoes = cow_shoes, c.dehorned = dehorned, c.birth_date = birth_date WHERE c.id_cow = id_cow;
		COMMIT;
    END;
END;;
DELIMITER ;

DELIMITER ;;
CREATE PROCEDURE CREATE_BREED(IN breed_name VARCHAR(16))
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
		INSERT INTO breed VALUES(null, normalizeText(breed_name));
    END;
END;;
DELIMITER ;