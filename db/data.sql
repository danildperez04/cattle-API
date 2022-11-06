INSERT INTO `breed` VALUES (1,'Cebú'),(2,'Brahmán'),(3,'Pardo Suizo'),(4,'Brangus'),(5,'Simental');
INSERT INTO `cow` VALUES 
(1,'Lola','Lechera',1,0,'HEMBRA',0,1,750,1.5,'2 acetominofen','Vaca ingresada por gripe'),
(2,'Lolo','Carne',1,0,'MACHO',0,1,950,1.6,'3 paracetamol','Vaca ingresada por dolor de rodilla'),
(3,'PEPA','Lechera',1,0,'HEMBRA',0,1,730,1.55,'chequeo medico','Vaca en excelente salud');
INSERT INTO `breedcow` VALUES (null, 1,1),(null, 3,2);

INSERT INTO `vaccine` VALUES 
(1,'Bacterina','Doble, triple u octavalente desde los 3 meses hasta 3 años de edad'),(2,'Ántrax','Vacunar todo el ganado a partir de los  6 meses de edad hasta el sacrificio o descarte');
INSERT INTO `inventory` VALUES (null,1,1),(null,2,1);

INSERT INTO `lot` VALUES 
(1,'De donde fué Danilds night club 2km al Oeste',2),
(2,'Night Club Galileos,Contiguo donde la mimi',0);
INSERT INTO `lotcow` VALUES (null, 1,1),(null, 1,2);