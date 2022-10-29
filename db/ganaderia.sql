CREATE DATABASE IF NOT EXISTS ganaderia;
USE ganaderia;
-- Platform
CREATE TABLE user (
    id_user INT(12) NOT NULL AUTO_INCREMENT,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    fullname VARCHAR(100) NOT NULL,
    password VARCHAR(60) NOT NULL,
    birth_date DATE NOT NULL,
    PRIMARY KEY (id_user)
);
-- Cows
CREATE TABLE breed(
    id_breed INT(12) NOT NULL AUTO_INCREMENT,
    breed_name VARCHAR(16) NOT NULL,
    PRIMARY KEY (id_breed)
);
CREATE TABLE cow(
    id_cow INT(12) NOT NULL AUTO_INCREMENT,
    cow_name VARCHAR(30),
    cow_desc TEXT,
    alive BOOLEAN,
    heat BOOLEAN,
    gender VARCHAR(10) DEFAULT 'MACHO',
    CHECK (
        gender = 'MACHO'
        OR gender = 'HEMBRA'
    ),
    cow_shoes BOOLEAN,
    dehorned BOOLEAN,
    periodic_weight DOUBLE,
    periodic_height DOUBLE,
    clinic_history TEXT,
    medic_history TEXT,
    PRIMARY KEY (id_cow)
);
CREATE TABLE breedcow(
    id_breed INT(12),
    id_cow INT(12),
    FOREIGN KEY (id_breed) REFERENCES breed(id_breed),
    FOREIGN KEY (id_cow) REFERENCES cow(id_cow)
);
CREATE TABLE cowbirth(
    id_cowbirth INT(12) NOT NULL,
    id_cow INT(12),
    id_father INT(12),
    id_mother INT(12),
    -- ESTIMADO DE EMBARAZO DE VACAS ES 9 MESES Y 10 DIAS
    monta_date DATE NOT NULL,
    birth_date DATE,
    -- abarca rambién la fecha de parida
    weight DOUBLE(4, 4) NOT NULL,
    PRIMARY KEY (id_cowbirth),
    FOREIGN KEY (id_cow) REFERENCES cow(id_cow),
    FOREIGN KEY (id_father) REFERENCES cow(id_cow),
    FOREIGN KEY (id_mother) REFERENCES cow(id_cow)
);
-- Vaccines 
CREATE TABLE vaccine(
    id_vaccine INT(12) NOT NULL AUTO_INCREMENT,
    vaccine_name VARCHAR(16) NOT NULL,
    vaccine_desc TEXT,
    PRIMARY KEY (id_vaccine)
);
CREATE TABLE inventory(
    id INT(12) NOT NULL auto_increment,
    id_vaccine INT(12),
    amount INT(8) DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY(id_vaccine) REFERENCES vaccine(id_vaccine)
);
CREATE TABLE cowvaccine(
    id_cow INT(12) NOT NULL,
    id_vaccine INT(12) NOT NULL,
    vaccine_date DATE NOT NULL,
    grams DOUBLE(4, 4) NOT NULL,
    FOREIGN KEY (id_cow) REFERENCES cow(id_cow),
    FOREIGN KEY (id_vaccine) REFERENCES vaccine(id_vaccine)
);
-- Operations
CREATE TABLE thirdpeople(
    id_third INT(12) NOT NULL AUTO_INCREMENT,
    fullname VARCHAR(16),
    contact VARCHAR(20),
    PRIMARY KEY (id_third)
);
CREATE TABLE operation(
    id_operation INT(12) NOT NULL AUTO_INCREMENT,
    id_cow INT(12),
    id_third INT(12),
    operation VARCHAR(12) DEFAULT 'PURCHASE',
    CHECK(
        operation = 'PURCHASE'
        OR operation = 'SALE'
    ),
    PRIMARY KEY(id_operation),
    FOREIGN KEY (id_third) REFERENCES thirdpeople(id_third),
    FOREIGN KEY (id_cow) REFERENCES cow(id_cow)
);
-- Lots
CREATE TABLE lot(
    id_lot INT(12) NOT NULL AUTO_INCREMENT,
    lot_address VARCHAR(80),
    cow_amount INT(8),
    PRIMARY KEY (id_lot)
);
CREATE TABLE lotcow(
    id_lot INT(12),
    id_cow INT(12),
    FOREIGN KEY (id_lot) REFERENCES lot(id_lot),
    FOREIGN KEY (id_cow) REFERENCES cow(id_cow)
);