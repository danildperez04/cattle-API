-- COW
DROP VIEW IF EXISTS cow_view;
CREATE VIEW cow_view AS
SELECT * 
FROM cow;

DROP VIEW IF EXISTS alive_cow;
CREATE VIEW alive_cow AS
SELECT *
FROM cow
WHERE alive = 1;

DROP VIEW IF EXISTS male_cow;
CREATE VIEW male_cow AS
SELECT *
FROM cow
WHERE gender = 'MALE';

-- BREED
DROP VIEW IF EXISTS breed_view;
CREATE VIEW breed_view AS
SELECT * 
FROM breed ORDER BY id_breed;

DROP VIEW IF EXISTS breedcow_view;
CREATE VIEW breedcow_view AS
SELECT bc.id, c.cow_name, b.breed_name
FROM cow c, breedcow bc, breed b
WHERE bc.id_cow = c.id_cow  AND bc.id_breed = b.id_breed ORDER BY c.cow_name;

DROP VIEW IF EXISTS cow_left_view;
CREATE VIEW cow_left_view AS
SELECT c.id_cow, c.cow_name, b.id_breed
FROM cow c
LEFT JOIN breedcow b ON c.id_cow = b.id_cow;

DROP VIEW IF EXISTS breed_left_view;
CREATE VIEW breed_left_view AS
SELECT b.id_breed, b.breed_name, bc.id_cow
FROM breed b
LEFT JOIN breedcow bc ON b.id_breed = bc.id_breed;

-- OPERATION 
DROP VIEW IF EXISTS operation_view;
CREATE VIEW operation_view AS
SELECT b.id_operation, c.fullname, b.operation, a.cow_name  
FROM cow a, operation b, thirdpeople c
WHERE b.id_cow = a.id_cow AND b.id_third = c.id_third;

-- VACCINE
DROP VIEW IF EXISTS inventory_view;
CREATE VIEW inventory_view AS
SELECT i.id, v.id_vaccine, v.vaccine_name, v.vaccine_desc, i.ml
FROM inventory i 
INNER JOIN vaccine v ON i.id_vaccine = v.id_vaccine;

-- LOT
DROP VIEW IF EXISTS lotcow_view;
CREATE VIEW lotcow_view AS 
SELECT lc.id, l.id_lot, c.cow_name, l.lot_address 
FROM cow c, lotcow lc, lot l
WHERE lc.id_lot = l.id_lot AND lc.id_cow = c.id_cow;

-- DEADCOW
DROP VIEW IF EXISTS deadcow_view;
CREATE VIEW deadcow_view AS
SELECT *
FROM deadcow;

DROP VIEW IF EXISTS descriptive_deadcow_view;
CREATE VIEW descriptive_deadcow_view AS
SELECT d.id_death, d.id_cow, c.cow_name, c.cow_desc, d.death_cause, d.death_date
FROM deadcow d
INNER JOIN cow c ON d.id_cow = c.id_cow;