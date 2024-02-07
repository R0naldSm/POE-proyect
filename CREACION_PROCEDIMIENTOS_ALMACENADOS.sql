--
-- CREACIÓN DE LOS PROCEDIMIENTOS ALMACENADOS
--
--
use BaseProyectoElecciones
--
-- Usuario
CREATE PROCEDURE SP_IniciarSesion
    @usuario VARCHAR(50),
    @contraseña VARCHAR(50)
AS
BEGIN
    SELECT TOP 1 id_usuario, nombre, apellido, correo, usuario, contraseña, id_rol
    FROM Usuario
    WHERE usuario = @usuario AND contraseña = @contraseña;
END

-- Candidatas
CREATE PROCEDURE SP_registrar_candidata
	@nombre varchar(20),
	@apellido varchar(20),
	@edad char(2),
	@ciudad varchar(20),
	@carrera varchar(50),
	@paralelo varchar(12),
	@pasatiempos varchar(100),
	@aspiraciones varchar(100),
	@intereses varchar(100),
	@foto image,
	@idUsuario int,
	@idCandidatura int,
	@idCandidata int out
AS
BEGIN
	INSERT INTO Candidatas(nombre, apellido, edad, ciudad, carrera, paralelo, pasatiempos, aspiraciones, intereses, foto_perfil, id_usuario, id_candidatura)
	VALUES (@nombre, @apellido, @edad, @ciudad, @carrera, @paralelo, @pasatiempos, @aspiraciones, @intereses, @foto, @idUsuario, @idCandidatura);

	SET @idCandidata = SCOPE_IDENTITY();

	SELECT @idCandidata;
END;
--
--
CREATE PROCEDURE SP_ver_reina
AS
BEGIN
	SELECT * FROM Candidatas
	WHERE id_candidatura = 1;
END;
--
--
CREATE PROCEDURE SP_recuperar_especifico
	@idCandidata int
AS
BEGIN
	SELECT * FROM Candidatas
	WHERE id_candidatas = @idCandidata
END;
--
--
CREATE PROCEDURE SP_ver_miss
AS
BEGIN
	SELECT * FROM Candidatas
	WHERE id_candidatura = 2;
END;

--Album
CREATE PROCEDURE SP_registrar_album
	@titulo varchar(25),
	@descripcion varchar(100),
	@idAlbum int out
AS
BEGIN
	INSERT INTO Album(titulo, descripcion)
	VALUES (@titulo, @descripcion);

	SET @idAlbum = SCOPE_IDENTITY();

	SELECT @idAlbum;
END;
--
--
CREATE PROCEDURE SP_recuperar_album_especifico
	@idCandidata int
AS
BEGIN
	SELECT * FROM Album
	WHERE id_candidatas = @idCandidata
END;
--
--
CREATE PROCEDURE SP_ultimos_registros_album
	@cantidad int
AS
BEGIN
	--Me trae los id´s de los ultimos albumes insertados en la tabla
	SELECT TOP (@cantidad) id_album
	FROM Album
	ORDER BY id_album DESC
END;
--
--
CREATE PROCEDURE SP_actualizar_idCand_en_Album
	@idCandidata int,
	@idAlbum int
AS
BEGIN
	UPDATE Album
    SET id_candidatas = @idCandidata
    WHERE id_album = @idAlbum;
END;

--Fotografia
CREATE PROCEDURE SP_RegistrarFoto
	@foto image,
	@idAlbum int,
	@idFoto int out
AS
BEGIN
	INSERT INTO Fotografia(foto, id_album)
	VALUES (@foto, @idAlbum);

	SET @idFoto = SCOPE_IDENTITY();

	SELECT @idFoto;
END;
--
--
CREATE PROCEDURE SP_recuperar_fotos
	@idAlbum int
AS
BEGIN
	SELECT * FROM Fotografia
	WHERE id_album = @idAlbum
END;

-- Comentarios
CREATE PROCEDURE SP_registrar_comentario_foto
	@comentario varchar(100),
	@idFoto int,
	@idUsuario int,

	@idComentario int out
AS
BEGIN
	INSERT INTO Comentarios(comentario, id_foto, id_usuario)
	VALUES (@comentario, @idFoto, @idUsuario)

	SET @idComentario = SCOPE_IDENTITY();

	SELECT @idComentario;
END;
--
--
CREATE PROCEDURE SP_recuperar_comentarios_foto
	@idFoto int
AS
BEGIN
	SELECT 
        U.nombre + ' ' + U.apellido AS Estudiante,
        C.comentario
    FROM 
        Comentarios C
    JOIN 
        Usuario U ON C.id_usuario = U.id_usuario
    WHERE 
        C.id_foto = @idFoto;
END;

-- Voto Reina
CREATE PROCEDURE SP_verificar_voto_reina
    @idEstudiante int
AS
BEGIN
    SELECT TOP 1 *
    FROM VotoReina
    WHERE id_usuario = @idEstudiante;
END;
--
--
CREATE PROCEDURE SP_registrar_voto_reina
	@fecha datetime,
	@idCandidata int,
	@idUsuario int
AS
BEGIN
	INSERT INTO VotoReina(fecha_voto, id_candidatas, id_usuario)
	VALUES (@fecha, @idCandidata, @idUsuario);
END;
--
--
CREATE PROCEDURE SP_resultados_votacion
AS
BEGIN
	SELECT
    c.Nombre AS Nombre_Candidata,
    COUNT(*) AS Total_Votos
	FROM
		VotoReina v
	JOIN
		Candidatas c ON v.id_candidatas = c.id_candidatas
	GROUP BY
		c.Nombre;
END;

-- Voto Miss
CREATE PROCEDURE SP_verificar_voto_miss
    @idEstudiante int
AS
BEGIN
    SELECT TOP 1 *
    FROM VotoMiss
    WHERE id_usuario = @idEstudiante;
END;
--
--
CREATE PROCEDURE SP_registrar_voto_miss
	@fecha datetime,
	@idCandidata int,
	@idUsuario int
AS
BEGIN
	INSERT INTO VotoMiss(fecha_voto, id_candidatas, id_usuario)
	VALUES (@fecha, @idCandidata, @idUsuario);
END;
--
--
CREATE PROCEDURE SP_resultados_votacion_miss
AS
BEGIN
	SELECT
    c.Nombre AS Nombre_Candidata,
    COUNT(*) AS Total_Votos
	FROM
		VotoMiss v
	JOIN
		Candidatas c ON v.id_candidatas = c.id_candidatas
	GROUP BY
		c.Nombre;
END;