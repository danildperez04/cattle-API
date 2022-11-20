-- SQLBook: Code
--FUNCTIONS FOR VACCINE

DROP FUNCTION IF EXISTS VACCINE_EXISTS_NAME; -- VALIDA EL NOMBRE DE LA VACUNA EN VACCINE
DELIMITER $$
CREATE FUNCTION VACCINE_EXISTS_NAME(vaccine_name VARCHAR(16)) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE v_name VARCHAR(16);
    SELECT v.vaccine_name FROM vaccine v WHERE v.vaccine_name = vaccine_name INTO v_name;
    IF v_name IS NULL THEN
		RETURN FALSE;
    END IF;
	RETURN TRUE;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS VACCINE_EXISTS_ID; -- VALIDA EL ID DE LA VACUNA EN VACCINE
DELIMITER $$
CREATE FUNCTION VACCINE_EXISTS_ID(id_vaccine INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE id INT;
    SELECT v.id_vaccine FROM vaccine v WHERE v.id_vaccine = id_vaccine INTO id;
    IF id IS NULL THEN
		RETURN FALSE;
    END IF;
	RETURN TRUE;
END $$
DELIMITER ;
-- FUNCTONS FOR INVENTORY
DROP FUNCTION IF EXISTS INVENTORY_EXISTS_VACCINE; --VALIDA EL ID DE LA VACUNA EN EL INVANTRIO
DELIMITER $$
CREATE FUNCTION INVENTORY_EXISTS_VACCINE(id_vaccine INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE id INT;
    SELECT i.id_vaccine FROM inventory i WHERE i.id_vaccine = id_vaccine INTO id;
    IF id IS NULL THEN
		RETURN FALSE;
    END IF;
	RETURN TRUE;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS INVENTORY_EXISTS_ID; -- VALIDA EL ID DEL INVENTARIO
DELIMITER $$
CREATE FUNCTION INVENTORY_EXISTS_ID(id_inventory INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE id INT;
    SELECT i.id FROM inventory i WHERE i.id = id_inventory INTO id;
    IF id IS NULL THEN
		RETURN FALSE;
    END IF;
	RETURN TRUE;
END $$
DELIMITER ;
--FUNCTIONS FOR COWVACCINE
DROP FUNCTION IF EXISTS VALIDATE_ML; -- VALIDA SI LA CANTIDAD DE ML EN INVENTARIO ES SUFICIENTE
DELIMITER $$
CREATE FUNCTION VALIDATE_ML(id_vaccine INT, ml_cowvaccine DOUBLE) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE ml_inventory DOUBLE;
    SELECT i.ml FROM inventory i WHERE i.id_vaccine = id_vaccine INTO ml_inventory;
    IF ml_cowvaccine > ml_inventory THEN
		RETURN FALSE;
    END IF;
	RETURN TRUE;
END $$
DELIMITER ;

DROP FUNCTION IF EXISTS COWVACCINE_EXISTS_ID; -- VALIDA SI EXISTE REGISTRO DEL ID DE COWVACCINE
DELIMITER $$
CREATE FUNCTION COWVACCINE_EXISTS_ID(id_cowvaccine INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE id INT;
    SELECT c.id FROM cowvaccine c WHERE c.id = id_cowvaccine INTO id;
    IF id IS NULL THEN
		RETURN FALSE;
    END IF;
	RETURN TRUE;
END $$
DELIMITER ;
-- FUNCTIONS FOR CLINICHISTORY
DROP FUNCTION IF EXISTS CLINICHISTORY_EXISTS_ID; -- VALIDA SI EXISTE REGISTRO DEL ID DE CLINICHISTORY
DELIMITER $$
CREATE FUNCTION CLINICHISTORY_EXISTS_ID(id_clinichistory INT) RETURNS BOOLEAN DETERMINISTIC
BEGIN
    DECLARE id INT;
    SELECT c.id FROM clinichistory c WHERE c.id = id_clinichistory INTO id;
    IF id IS NULL THEN
		RETURN FALSE;
    END IF;
	RETURN TRUE;
END $$
DELIMITER ;
--VACCINES
DROP PROCEDURE IF EXISTS GET_VACCINES; -- OBTIENE TODAS LAS VACUNAS DE LA TABLA
DELIMITER ;;
CREATE PROCEDURE GET_VACCINES()
BEGIN
    SELECT * FROM vaccine;
END ;;
DELIMITER ;

DROP PROCEDURE IF EXISTS GET_VACCINE; -- OBTIENE UNA VACUNA ESPECIFICADA
DELIMITER ;;
CREATE PROCEDURE GET_VACCINE( IN id_vaccine INT)
BEGIN
    SELECT * FROM vaccine v WHERE v.id_vaccine = id_vaccine;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS CREATE_VACCINE; -- CREA UNA VACUNA
DELIMITER ;;
CREATE PROCEDURE CREATE_VACCINE(IN vaccine_name VARCHAR(16), IN vaccine_desc TEXT)
BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
        IF VACCINE_EXISTS_NAME(NORMALIZE_TEXT(vaccine_name)) THEN -- VALIDACIÓN DE QUE EXISTA LA VACUNA
            SET @message = CONCAT('YA EXISTE REGISTRO DE LA VACUNA ', vaccine_name); 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message;
        END IF;    
        INSERT INTO vaccine VALUES(null, NORMALIZE_TEXT(vaccine_name), NORMALIZE_TEXT(vaccine_desc));
        COMMIT;
    END;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS UPDATE_VACCINE; -- ACTUALIZA UNA VACUNA ESPECIFICADA
DELIMITER ;;
CREATE PROCEDURE UPDATE_VACCINE(IN id_vaccine INT, IN vaccine_name VARCHAR(16), IN vaccine_desc TEXT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1 @P1 = RETURNED_SQLSTATE, @P2 = MESSAGE_TEXT;
        SELECT @P2 AS MESSAGE;
        ROLLBACK;
    END;
    START TRANSACTION;  
    BEGIN
        IF NOT VACCINE_EXISTS_ID(id_vaccine) THEN -- VALIDACIÓN DE QUE EXISTA LA VACUNA
            SET @message = CONCAT('NO HAY REGISTRO DE LA VACUNA ', id_vaccine); 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message;
        END IF;
            UPDATE vaccine v SET v.vaccine_name = NORMALIZE_TEXT(vaccine_name), v.vaccine_desc = NORMALIZE_TEXT(vaccine_desc) WHERE v.id_vaccine = id_vaccine;
        COMMIT;
    END;
END ;;
DELIMITER ;

DROP PROCEDURE IF EXISTS DELETE_VACCINE; -- ELIMINA UNA VACUNA DE LA TABLA
DELIMITER ;;
CREATE PROCEDURE DELETE_VACCINE(IN id_vaccine INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
	START TRANSACTION;
    BEGIN
		IF NOT VACCINE_EXISTS_ID(id_vaccine) THEN -- COMPROBACION DE QUE EL REGISTRO EXISTA
			SET @message = CONCAT('NO EXISTE REGISTRO PARA ', id_vaccine); 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message;
        END IF;
		DELETE FROM vaccine v WHERE v.id_vaccine = id_vaccine;
		COMMIT;
    END;
END;;
DELIMITER ;

-- INVENTORY
DROP PROCEDURE IF EXISTS GET_INVENTORYS; --OBTIENE TIDOS LOS REGISTROS DEL INVENTARIO
DELIMITER ;;
CREATE PROCEDURE GET_INVENTORYS()
BEGIN
    SELECT * FROM inventory;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS GET_INVENTORY; -- OBTIENE UN REGISTRO ESPECIFICO DEL INVENTARIO
DELIMITER ;;
CREATE PROCEDURE GET_INVENTORY( IN id INT)
BEGIN
    SELECT * FROM inventory i WHERE i.id = id;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS CREATE_INVENTORY; -- CREA UN REGISTRO EN INVENTARIO
DELIMITER ;;
CREATE PROCEDURE CREATE_INVENTORY(IN id_vaccine INT, IN ml DOUBLE)
BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
        IF NOT VACCINE_EXISTS_ID(id_vaccine) THEN -- VALIDACIÓN DE QUE EXISTA LA VACUNA PARA PODER METERLA EN INVENTARIO
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VACUNA NO EXISTE ';
        END IF;    
        IF INVENTORY_EXISTS_ID(id_vaccine) AND VACCINE_EXISTS_ID(id_vaccine) THEN -- VALIDACIÓN DE QUE YA EXISTA REGISTRO DE LA VACUNA EN INVENTARIO
            SET @message = CONCAT('YA EXISTE REGISTRO DE LA VACUNA CON ID ', id_vaccine); 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message;
        END IF;    
        INSERT INTO inventory VALUES(null, id_vaccine, ml);
        COMMIT;
    END;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS UPDATE_INVENTORY; -- ACTUALIZA UN REGISTRO EN INVENTERIO
DELIMITER ;;
CREATE PROCEDURE UPDATE_INVENTORY(IN id INT, IN ml DOUBLE)
BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
        IF NOT INVENTORY_EXISTS_ID(id) THEN -- VALIDACIÓN DE QUE EXISTA REGISTRO EN INVENTARIO
            SET @message = CONCAT('NO HAY REGISTRO EN INVENTARIO DEL ID ', id); 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message;
        END IF;    
        UPDATE inventory i SET i.ml = ml WHERE i.id = id;
        COMMIT;
    END;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS DELETE_INVENTORY; -- ELIMINA UN REGISTRO DE INVENTARIO
DELIMITER ;;
CREATE PROCEDURE DELETE_INVENTORY(IN id INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
	START TRANSACTION;
    BEGIN
		IF NOT INVENTORY_EXISTS_ID(id) THEN -- VALIDACIÓN DE QUE EXISTA REGISTRO EN INVENTARIO
            SET @message = CONCAT('NO HAY REGISTRO EN INVENTARIO DEL ID ', id); 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message;
        END IF; 
		DELETE FROM inventory i WHERE i.id = id;
		COMMIT;
    END;
END;;
DELIMITER ;
--COWVACCINE
DROP PROCEDURE IF EXISTS GET_COWVACCINES; --OBTIENE TODOS LOS REGISTROS DEL COWVACCINE
DELIMITER ;;
CREATE PROCEDURE GET_COWVACCINES()
BEGIN
    SELECT * FROM cowvaccine;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS GET_COWVACCINE; -- OBTIENE UN REGISTRO ESPECIFICO DE COWVACCINE
DELIMITER ;;
CREATE PROCEDURE GET_COWVACCINE( IN id INT)
BEGIN
    SELECT * FROM cowvaccine c WHERE c.id = id;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS CREATE_COWVACCINE; -- CREA UN REGISTRO EN COWVACCINE
DELIMITER ;;
CREATE PROCEDURE CREATE_COWVACCINE(IN id_cow INT, IN id_vaccine INT, IN vaccine_date DATE, IN ml DOUBLE)
BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
        IF NOT INVENTORY_EXISTS_VACCINE(id_vaccine) THEN -- VALIDACIÓN DE QUE EXISTA LA VACUNA EN INVENTARIO
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VACUNA NO EXISTE ';
        END IF;
        IF NOT COW_EXISTS(id_cow) THEN -- VALIDACIÓN DE QUE EXISTA LA VACA
		    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VACA NO EXISTE ';
        END IF;     
        IF (NOT COW_ISALIVE(id_cow)) THEN -- VALIDACIÓN DE QUE LA VACA ESTE VIVA
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VA ESTA MUERTA ';
        END IF;
        IF (NOT VALIDATE_ML(id_vaccine, ml)) THEN -- VALIDACIÓN DE LA CONTIDAD A APLICAR
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO HAY CANTIDAD SUFICIENTE DE VACUNA EN EL INVENTARIO ';
        END IF;    
        INSERT INTO cowvaccine VALUES(null, id_cow, id_vaccine, vaccine_date, ml);
        COMMIT;
    END;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS UPDATE_COWVACCINE; -- CREA UN REGISTRO EN COWVACCINE
DELIMITER ;;
CREATE PROCEDURE UPDATE_COWVACCINE(IN id INT, IN id_cow INT, IN id_vaccine INT, IN vaccine_date DATE, IN ml DOUBLE)
BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
        IF NOT COWVACCINE_EXISTS_ID(id) THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'EL ID INGRESADO PARA LA ACTUALIZACIÓN NO EXISTE';
        END IF;
        IF NOT INVENTORY_EXISTS_VACCINE(id_vaccine) THEN -- VALIDACIÓN DE QUE EXISTA LA VACUNA EN INVENTARIO
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VACUNA NO EXISTE ';
        END IF;
        IF NOT COW_EXISTS(id_cow) THEN -- VALIDACIÓN DE QUE EXISTA LA VACA
		    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VACA NO EXISTE ';
        END IF;     
        IF (NOT COW_ISALIVE(id_cow)) THEN -- VALIDACIÓN DE QUE LA VACA ESTE VIVA
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VACA ESTA MUERTA ';
        END IF;
        IF (NOT VALIDATE_ML(id_vaccine, ml)) THEN -- VALIDACIÓN DE LA CONTIDAD A APLICAR
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO HAY CANTIDAD SUFICIENTE DE VACUNA EN EL INVENTARIO ';
        END IF;    
        UPDATE cowvaccine c SET c.id_cow = id_cow, c.id_vaccine = id_vaccine, c.vaccine_date = vaccine_date, c.ml = ml WHERE c.id = id;
        COMMIT;
    END;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS DELETE_COWVACCINE; -- ELIMINA UN REGISTRO DE INVENTARIO
DELIMITER ;;
CREATE PROCEDURE DELETE_COWVACCINE(IN id INT)
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
	START TRANSACTION;
    BEGIN
		IF NOT COWVACCINE_EXISTS_ID(id) THEN -- VALIDACIÓN DE QUE EXISTA REGISTRO EN COWVACCINE
            SET @message = CONCAT('NO HAY REGISTRO EN COWVACCINE DEL ID ', id); 
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @message;
        END IF; 
		DELETE FROM cowvaccine c WHERE c.id = id;
		COMMIT;
    END;
END;;
DELIMITER ;
--CLINICHISTORY
DROP PROCEDURE IF EXISTS GET_CLINICHISTORYS; --OBTIENE TODOS LOS REGISTROS DE CLINICHISTORY
DELIMITER ;;
CREATE PROCEDURE GET_CLINICHISTORYS()
BEGIN
    SELECT * FROM clinichistory;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS GET_CLINICHISTORY; -- OBTIENE UN REGISTRO ESPECIFICO DE CLINICHISTORY
DELIMITER ;;
CREATE PROCEDURE GET_CLINICHISTORYS( IN id INT)
BEGIN
    SELECT * FROM clinichistory c WHERE c.id = id;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS CREATE_CLINICHISTORY; -- CREA UN REGISTRO EN CLINICHISTORY
DELIMITER ;;
CREATE PROCEDURE CREATE_CLINICHISTORY(IN id_cow INT, IN id_cowvaccine INT, IN description TEXT, IN periodic_weight DOUBLE, IN periodic_height DOUBLE, IN date DATE, IN img_url TEXT)
BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
        IF (NOT COW_EXISTS(id_cow)) THEN -- VALIDACIÓN DE QUE EXISTA LA VACA
		    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VACA NO EXISTE ';
        END IF;     
        IF ((id_cowvaccine IS NOT NULL) && (NOT COWVACCINE_EXISTS_ID(id_cowvaccine)) ) THEN -- VALIDACIÓN DEL ID DE COWVACCINE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO HAY REGISTRO DE EL ID DE COWVACCINE ';
        END IF;    
        INSERT INTO clinichistory VALUES(null, id_cow, id_cowvaccine, description, periodic_weight, periodic_height, date, img_url);
        COMMIT;
    END;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS UPDATE_CLINICHISTORY; -- ACTUALIZA UN REGISTRO EN CLINICHISTORY
DELIMITER ;;
CREATE PROCEDURE CREATE_CLINICHISTORY(IN id INT, IN id_cow INT, IN id_cowvaccine INT, IN description TEXT, IN periodic_weight DOUBLE, IN periodic_height DOUBLE, IN date DATE, IN img_url TEXT)
BEGIN
 	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
		SELECT @p2 AS MESSAGE;
		ROLLBACK;
	END;
    START TRANSACTION;
    BEGIN
        IF (NOT COW_EXISTS(id_cow)) THEN -- VALIDACIÓN DE QUE EXISTA LA VACA
		    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'LA VACA NO EXISTE ';
        END IF;     
        IF ((id_cowvaccine IS NOT NULL) && (NOT COWVACCINE_EXISTS_ID(id_cowvaccine)) ) THEN -- VALIDACIÓN DEL ID DE COWVACCINE
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO HAY REGISTRO DE EL ID DE COWVACCINE ';
        END IF;    
        INSERT INTO clinichistory VALUES(null, id_cow, id_cowvaccine, description, periodic_weight, periodic_height, date, img_url);
        COMMIT;
    END;
END;;
DELIMITER ;

--vacine inventory cow-vaccine medic-history