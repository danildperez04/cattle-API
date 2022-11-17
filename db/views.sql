-- COW
CREATE VIEW cow_view AS
SELECT * 
FROM cow;

CREATE VIEW alive_cow AS
SELECT *
FROM cow
WHERE alive = 1;

-- BREED
CREATE VIEW breedcow_view AS
SELECT bc.id, c.cow_name, b.breed_name
FROM cow c, breedcow bc, breed b
WHERE bc.id_cow = c.id_cow  AND bc.id_breed = b.id_breed;

CREATE VIEW cow_left_view AS
SELECT c.id_cow, c.cow_name, b.id_breed
FROM cow c
LEFT JOIN breedcow b ON c.id_cow = b.id_cow;

CREATE VIEW breed_left_view AS
SELECT b.id_breed, b.breed_name, bc.id_cow
FROM breed b
LEFT JOIN breedcow bc ON b.id_breed = bc.id_breed;

-- OPERATION 
CREATE VIEW operation_view AS
SELECT b.id_operation, c.fullname, b.operation, a.cow_name  
FROM cow a, operation b, thirdpeople c
WHERE b.id_cow = a.id_cow AND b.id_third = c.id_third;

-- VACCINE
CREATE VIEW inventory_view AS
SELECT i.id, v.id_vaccine, v.vaccine_name, v.vaccine_desc, i.amount
FROM inventory i 
INNER JOIN vaccine v on i.id_vaccine = v.id_vaccine;

-- LOT
CREATE VIEW lotcow_view AS 
SELECT lc.id, l.id_lot, c.cow_name, l.lot_address 
FROM cow c, lotcow lc, lot l
WHERE lc.id_lot = l.id_lot AND lc.id_cow = c.id_cow;