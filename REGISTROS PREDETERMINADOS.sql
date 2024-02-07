--
go BaseProyectoElecciones;
--
INSERT INTO Rol(descripcion)
VALUES
	('Administrador'),
	('Estudiante');
--
--
INSERT INTO Candidatura(tipo)
VALUES
	('Reina'),
	('Miss');
--
--
INSERT INTO Usuario(nombre, apellido, correo, usuario, contraseña, id_rol)
VALUES
	('Joel', 'Frias', 'joel.friaspal@ug.edu.ec', '0958636748', 'JoelFrias', 1),
	('Didier', 'Arteaga', 'didier.Arteagacal@ug.edu.ec', '0987654321', 'DidierArteaga', 2),
	('David', 'Verdesoto', 'david.verdesotosan@ug.edu.ec', '0999999999', 'DavidVerdesoto', 2),
	('Melany', 'Salas', 'melany.salasalv@ug.edu.ec', '0988888888', 'MelanySalas', 2),
	('Ronald', 'Mota', 'ronald.motamag@ug.edu.ec', '0909090909', 'RonaldMota', 2),
	('Jefferson', 'Nuñez', 'jefferson.nuñezgai@ug.edu.ec', '0000000000', 'JeffersonNuñez', 1);