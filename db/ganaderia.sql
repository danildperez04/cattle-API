-- SQLBook: Code
CREATE DATABASE IF NOT EXISTS ganaderia;
USE ganaderia;
-- Platform
CREATE TABLE user (
    id_user INT NOT NULL AUTO_INCREMENT,
    username VARCHAR(16) NOT NULL,
    email VARCHAR(60) NOT NULL UNIQUE,
    fullname VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    PRIMARY KEY (id_user)
);
-- Cows
CREATE TABLE breed(
    id_breed INT NOT NULL AUTO_INCREMENT,
    breed_name VARCHAR(16) NOT NULL UNIQUE,
    PRIMARY KEY (id_breed)
);
CREATE TABLE cow(
    id_cow INT NOT NULL AUTO_INCREMENT,
    cow_name VARCHAR(30) NOT NULL,
    cow_desc VARCHAR(10) NOT NULL DEFAULT 'LECHERA',
    alive BOOLEAN NOT NULL DEFAULT 1,
    heat DATE,
    gender VARCHAR(10) NOT NULL DEFAULT 'MACHO',
    CHECK (
        gender = 'MACHO'
        OR gender = 'HEMBRA'
    ),
    cow_shoes DATE,
    dehorned DATE,
    birth_date DATE NOT NULL,
    PRIMARY KEY (id_cow)
);
CREATE TABLE breedcow(
    id INT AUTO_INCREMENT,
    id_breed INT,
    id_cow INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_breed) REFERENCES breed(id_breed),
    FOREIGN KEY (id_cow) REFERENCES cow(id_cow)
);
CREATE TABLE deadcow(
    id_death INT NOT NULL AUTO_INCREMENT,
    id_cow INT UNIQUE,
    death_cause TEXT,
    death_date DATE NOT NULL,
    PRIMARY KEY (id_death),
    FOREIGN KEY (id_cow) REFERENCES cow (id_cow)
);
-- Vaccines 
CREATE TABLE vaccine(
    id_vaccine INT NOT NULL AUTO_INCREMENT,
    vaccine_name VARCHAR(16) NOT NULL,
    vaccine_desc TEXT,
    PRIMARY KEY (id_vaccine)
);
CREATE TABLE inventory(
    id INT NOT NULL AUTO_INCREMENT,
    id_vaccine INT NOT NULL UNIQUE,
    ml DOUBLE DEFAULT 0,
    PRIMARY KEY (id),
    FOREIGN KEY(id_vaccine) REFERENCES vaccine(id_vaccine)
);
CREATE TABLE cowvaccine(
    id INT NOT NULL AUTO_INCREMENT,
    id_cow INT NOT NULL,
    id_vaccine INT NOT NULL,
    vaccine_date DATE NOT NULL,
    ml DOUBLE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_cow) REFERENCES cow(id_cow),
    FOREIGN KEY (id_vaccine) REFERENCES vaccine(id_vaccine)
);
CREATE TABLE clinichistory(
    id INT AUTO_INCREMENT,
    id_cow INT NOT NULL,
    id_cowvaccine INT,
    description TEXT,
    periodic_weight DOUBLE NOT NULL,
    periodic_height DOUBLE NOT NULL,
    date DATE NOT NULL,
    img_url TEXT,
    PRIMARY KEY(id),
    FOREIGN KEY(id_cow) REFERENCES cow (id_cow),
    FOREIGN KEY(id_cowvaccine) REFERENCES cowvaccine (id)
);
-- Operations
CREATE TABLE thirdpeople(
    id_third INT NOT NULL AUTO_INCREMENT,
    fullname VARCHAR(16) NOT NULL,
    contact VARCHAR(20),
    PRIMARY KEY (id_third)
);
CREATE TABLE operation(
    id_operation INT NOT NULL AUTO_INCREMENT,
    id_cow INT NOT NULL,
    id_third INT NOT NULL,
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
    id_lot INT NOT NULL AUTO_INCREMENT,
    lot_address VARCHAR(80) NOT NULL,
    cow_amount INT DEFAULT 0,
    PRIMARY KEY (id_lot)
);
CREATE TABLE lotcow(
    id INT NOT NULL AUTO_INCREMENT,
    id_lot INT NOT NULL,
    id_cow INT NOT NULL UNIQUE,
    PRIMARY KEY(id),
    FOREIGN KEY (id_lot) REFERENCES lot(id_lot),
    FOREIGN KEY (id_cow) REFERENCES cow(id_cow)
);