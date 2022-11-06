DELIMITER ;;
CREATE PROCEDURE CREATE_COW(IN cow_name varchar(30), IN cow_desc TEXT)
BEGIN
INSERT INTO cow VALUES(null, cow_name, cow_desc);-- TODO: FINISH this
END;;
DELIMITER ;
