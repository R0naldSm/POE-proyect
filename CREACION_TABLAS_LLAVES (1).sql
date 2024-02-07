--
--CREACION DE LA BASE DE DATOS
--
CREATE DATABASE BaseProyectoElecciones
go
--
use BaseProyectoElecciones
--
--CREACIÓN DE TABLAS
--
CREATE TABLE Usuario(
	id_usuario int identity(1,1),
	nombre varchar(25) not null,
	apellido varchar(25) not null,
	correo varchar(100) not null,
	usuario varchar(10) not null,
	contraseña varchar(25) not null,

	id_rol int not null
);

CREATE TABLE Candidatas(
	id_candidatas int identity(1,1),
	nombre varchar(20) not null,
	apellido varchar(20) not null,
	edad char(2),
	ciudad varchar(20),
	carrera varchar(50) not null,
	paralelo varchar(12) not null,
	pasatiempos varchar(100),
	aspiraciones varchar(100),
	intereses varchar(100),
	foto_perfil image not null,

	id_usuario int,
	id_candidatura int
);

CREATE TABLE Album(
	id_album int identity(1,1),
	titulo varchar(25) not null,
	descripcion varchar(100),

	id_candidatas int
);

CREATE TABLE Fotografia(
	id_foto int identity(1,1),
	foto image not null,

	id_album int
);

CREATE TABLE Comentarios(
	id_comentario int identity(1,1),
	comentario varchar(100) not null,

	id_foto int,
	id_usuario int
);

CREATE TABLE VotoReina(
	id_voto_reina int identity(1,1),
	fecha_voto datetime not null,

	id_candidatas int,
	id_usuario int
);

CREATE TABLE VotoMiss(
	id_voto_miss int identity(1,1),
	fecha_voto datetime not null,

	id_candidatas int,
	id_usuario int
);

CREATE TABLE Candidatura(
	id_candidatura int identity(1,1),
	tipo varchar(20) not null

);

CREATE TABLE Rol(
	id_rol int identity(1,1),
	descripcion varchar(13) not null

);
--
--ASIGNACIÓN CLAVES PRIMARIAS
--
alter table Usuario
add constraint PK_Usuario primary key (id_usuario);

alter table Candidatas
add constraint PK_Candidatas primary key (id_candidatas);

alter table Album
add constraint PK_Album primary key (id_album);

alter table Fotografia
add constraint PK_Fotografia primary key (id_foto);

alter table Comentarios
add constraint PK_Comentarios primary key (id_comentario);

alter table VotoReina
add constraint PK_VotoReina primary key (id_voto_reina);

alter table VotoMiss
add constraint PK_Voto_Miss primary key (id_voto_miss);

alter table Candidatura
add constraint PK_Candidatura primary key (id_candidatura);

alter table Rol
add constraint PK_Rol primary key (id_rol);
--
--ASIGNACIÓN CLAVES FORANEAS
--
alter table Candidatas
add constraint FK_Usuario_Candidatas foreign key (id_usuario) references Usuario(id_usuario);

alter table Album
add constraint FK_Candidatas_Album foreign key (id_candidatas) references Candidatas(id_candidatas);

alter table Fotografia
add constraint FK_Album_Fotografia foreign key (id_album) references Album(id_album);

alter table Comentarios
add constraint FK_Fotografia_Comentarios foreign key (id_foto) references Fotografia(id_foto);

alter table Comentarios
add constraint FK_Usuario_Comentarios foreign key (id_usuario) references Usuario(id_usuario);

alter table VotoReina
add constraint FK_Voto_Reina_Usuario foreign key (id_usuario) references Usuario(id_usuario);

alter table VotoMiss
add constraint FK_VotoMiss_Usuario foreign key (id_usuario) references Usuario(id_usuario);

alter table VotoReina
add constraint FK_Voto_Reina_Candidatas foreign key (id_candidatas) references Candidatas(id_candidatas);

alter table VotoMiss
add constraint FK_VotoMiss_Candidatas foreign key (id_candidatas) references Candidatas(id_candidatas);

alter table Candidatas
add constraint FK_Candidatura_Candidatas foreign key (id_candidatura) references Candidatura(id_candidatura);



