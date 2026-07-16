DROP DATABASE IF EXISTS PLANES;
CREATE DATABASE PLANES;
USE PLANES;

CREATE TABLE USUARIO (
    nombreUsuario VARCHAR(50) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    PRIMARY KEY (nombreUsuario)
);

CREATE TABLE PLAN (
    idPlan INT NOT NULL AUTO_INCREMENT,
    tituloPlan VARCHAR(100) NOT NULL,
    tipoPlan ENUM('actividad','receta','restaurante','sitio') NOT NULL,
    descripcionPlan TEXT,
    estadoPlan ENUM('idea','planificando','decidido','completado') NOT NULL,
    fechaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idPlan)
);

CREATE TABLE ETIQUETA (
    idEtiqueta INT NOT NULL AUTO_INCREMENT,
    nombreEtiqueta VARCHAR(50) NOT NULL,
    colorHEXEtiqueta VARCHAR(7),
    PRIMARY KEY (idEtiqueta)
);

CREATE TABLE MATERIALES (
    idMaterial INT NOT NULL AUTO_INCREMENT,
    nombreMaterial VARCHAR(100) NOT NULL,
    precioMaterialUnidad DECIMAL(10,2),
    PRIMARY KEY (idMaterial)
);

CREATE TABLE INGREDIENTE (
    idIngrediente INT NOT NULL AUTO_INCREMENT,
    nombreIngrediente VARCHAR(100) NOT NULL,
    precioIngredienteUnidad DECIMAL(10,2),
    PRIMARY KEY (idIngrediente)
);

CREATE TABLE FOTO (
    idFoto INT NOT NULL AUTO_INCREMENT,
    fechaFoto DATE NOT NULL,
    comentarioFoto TEXT,
    rutaArchivo VARCHAR(255) NOT NULL,
    idPlan INT NOT NULL,
    PRIMARY KEY (idFoto)
);

CREATE TABLE ACTIVIDAD (
    idActividad INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    tiempoEstimado INT,
    PRIMARY KEY (idActividad)
);

CREATE TABLE RECETA (
    idReceta INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    cantidadReceta INT,
    tiempoPreparacion INT,
    paisTipicoReceta VARCHAR(100),
    PRIMARY KEY (idReceta)
);

CREATE TABLE PASO_RECETA (
    idPasoReceta INT NOT NULL AUTO_INCREMENT,
    idReceta INT NOT NULL,
    descripcionPasoReceta TEXT NOT NULL,
    orden INT NOT NULL,
    PRIMARY KEY (idPasoReceta)
);

CREATE TABLE RESTAURANTE (
    idRestaurante INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    nombreRestaurante VARCHAR(100) NOT NULL,
    paisTipicoRestaurante VARCHAR(100),
    direccionRestaurante VARCHAR(255),
    linkMapsRestaurante VARCHAR(255),
    distanciaRestauranteKM DECIMAL(10,2),
    precioPP DECIMAL(10,2),
    PRIMARY KEY (idRestaurante)
);

CREATE TABLE SITIO (
    idSitio INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    tipoSitio VARCHAR(100),
    direccionSitio VARCHAR(255),
    distanciaSitioKM DECIMAL(10,2),
    descripcionSitio TEXT,
    linkMapsSitio VARCHAR(255),
    PRIMARY KEY (idSitio)
);

CREATE TABLE ALEATORIO (
    idAleatorio INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    probabilidad DECIMAL(5,2) DEFAULT 1.00,
    descripcionAleatorio TEXT,
    vecesAceptado INT DEFAULT 0,
    vecesRechazado INT DEFAULT 0,
    categoria VARCHAR(100),
    PRIMARY KEY (idAleatorio)
);

CREATE TABLE EVENTO_CALENDARIO (
    idEventoCalendario INT NOT NULL AUTO_INCREMENT,
    fechaCalendario DATE NOT NULL,
    tipoEventoCalendario ENUM('ocupado','planeado','potencial','importante') NOT NULL,
    descripcionCalendario TEXT,
    colorHEX VARCHAR(7),
    significadoColor VARCHAR(100),
    contribuidoresEvento VARCHAR(255),
    nombreUsuario VARCHAR(50),
    idPlan INT,
    PRIMARY KEY (idEventoCalendario)
);

CREATE TABLE LISTA_DESEOS (
    idDeseo INT NOT NULL AUTO_INCREMENT,
    nombreDeseo VARCHAR(100) NOT NULL,
    precioDeseo DECIMAL(10,2),
    descripcionDeseo TEXT,
    enlaceDeseo VARCHAR(255),
    estadoDeseo ENUM('pendiente','comprado') DEFAULT 'pendiente',
    nombreUsuario VARCHAR(50) NOT NULL,
    PRIMARY KEY (idDeseo)
);

CREATE TABLE ETIQUETA_PLAN (
    idPlan INT NOT NULL,
    idEtiqueta INT NOT NULL,
    PRIMARY KEY (idPlan, idEtiqueta)
);

CREATE TABLE ACTIVIDAD_MATERIAL (
    idActividad INT NOT NULL,
    idMaterial INT NOT NULL,
    cantidadMaterial DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idActividad, idMaterial)
);

CREATE TABLE RECETA_INGREDIENTE (
    idReceta INT NOT NULL,
    idIngrediente INT NOT NULL,
    cantidadIngrediente DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idReceta, idIngrediente)
);

-- FK
ALTER TABLE FOTO
    ADD CONSTRAINT FK_FOTO_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE ACTIVIDAD
    ADD CONSTRAINT FK_ACTIVIDAD_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE RECETA
    ADD CONSTRAINT FK_RECETA_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE PASO_RECETA
    ADD CONSTRAINT FK_PASO_RECETA_RECETA FOREIGN KEY (idReceta) REFERENCES RECETA(idReceta);

ALTER TABLE RESTAURANTE
    ADD CONSTRAINT FK_RESTAURANTE_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE SITIO
    ADD CONSTRAINT FK_SITIO_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE ALEATORIO
    ADD CONSTRAINT FK_ALEATORIO_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE EVENTO_CALENDARIO
    ADD CONSTRAINT FK_EVENTO_CALENDARIO_USUARIO FOREIGN KEY (nombreUsuario) REFERENCES USUARIO(nombreUsuario),
    ADD CONSTRAINT FK_EVENTO_CALENDARIO_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE LISTA_DESEOS
    ADD CONSTRAINT FK_LISTA_DESEOS_USUARIO FOREIGN KEY (nombreUsuario) REFERENCES USUARIO(nombreUsuario);

ALTER TABLE ETIQUETA_PLAN
    ADD CONSTRAINT FK_ETIQUETA_PLAN_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan),
    ADD CONSTRAINT FK_ETIQUETA_PLAN_ETIQUETA FOREIGN KEY (idEtiqueta) REFERENCES ETIQUETA(idEtiqueta);

ALTER TABLE ACTIVIDAD_MATERIAL
    ADD CONSTRAINT FK_ACTIVIDAD_MATERIAL_ACTIVIDAD FOREIGN KEY (idActividad) REFERENCES ACTIVIDAD(idActividad),
    ADD CONSTRAINT FK_ACTIVIDAD_MATERIAL_MATERIAL FOREIGN KEY (idMaterial) REFERENCES MATERIALES(idMaterial);

ALTER TABLE RECETA_INGREDIENTE
    ADD CONSTRAINT FK_RECETA_INGREDIENTE_RECETA FOREIGN KEY (idReceta) REFERENCES RECETA(idReceta),
    ADD CONSTRAINT FK_RECETA_INGREDIENTE_INGREDIENTE FOREIGN KEY (idIngrediente) REFERENCES INGREDIENTE(idIngrediente);-- TABLAS
CREATE TABLE USUARIO (
    nombreUsuario VARCHAR(50) NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    PRIMARY KEY (nombreUsuario)
);

CREATE TABLE PLAN (
    idPlan INT NOT NULL AUTO_INCREMENT,
    tituloPlan VARCHAR(100) NOT NULL,
    tipoPlan ENUM('actividad','receta','restaurante','sitio') NOT NULL,
    descripcionPlan TEXT,
    estadoPlan ENUM('idea','planificando','decidido','completado') NOT NULL,
    fechaCreacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (idPlan)
);

CREATE TABLE ETIQUETA (
    idEtiqueta INT NOT NULL AUTO_INCREMENT,
    nombreEtiqueta VARCHAR(50) NOT NULL,
    colorHEXEtiqueta VARCHAR(7),
    PRIMARY KEY (idEtiqueta)
);

CREATE TABLE MATERIALES (
    idMaterial INT NOT NULL AUTO_INCREMENT,
    nombreMaterial VARCHAR(100) NOT NULL,
    precioMaterialUnidad DECIMAL(10,2),
    PRIMARY KEY (idMaterial)
);

CREATE TABLE INGREDIENTE (
    idIngrediente INT NOT NULL AUTO_INCREMENT,
    nombreIngrediente VARCHAR(100) NOT NULL,
    precioIngredienteUnidad DECIMAL(10,2),
    PRIMARY KEY (idIngrediente)
);

CREATE TABLE FOTO (
    idFoto INT NOT NULL AUTO_INCREMENT,
    fechaFoto DATE NOT NULL,
    comentarioFoto TEXT,
    rutaArchivo VARCHAR(255) NOT NULL,
    idPlan INT NOT NULL,
    PRIMARY KEY (idFoto)
);

CREATE TABLE ACTIVIDAD (
    idActividad INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    tiempoEstimado INT,
    PRIMARY KEY (idActividad)
);

CREATE TABLE RECETA (
    idReceta INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    cantidadReceta INT,
    tiempoPreparacion INT,
    paisTipicoReceta VARCHAR(100),
    PRIMARY KEY (idReceta)
);

CREATE TABLE PASO_RECETA (
    idPasoReceta INT NOT NULL AUTO_INCREMENT,
    idReceta INT NOT NULL,
    descripcionPasoReceta TEXT NOT NULL,
    orden INT NOT NULL,
    PRIMARY KEY (idPasoReceta)
);

CREATE TABLE RESTAURANTE (
    idRestaurante INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    nombreRestaurante VARCHAR(100) NOT NULL,
    paisTipicoRestaurante VARCHAR(100),
    direccionRestaurante VARCHAR(255),
    linkMapsRestaurante VARCHAR(255),
    distanciaRestauranteKM DECIMAL(10,2),
    precioPP DECIMAL(10,2),
    PRIMARY KEY (idRestaurante)
);

CREATE TABLE SITIO (
    idSitio INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    tipoSitio VARCHAR(100),
    direccionSitio VARCHAR(255),
    distanciaSitioKM DECIMAL(10,2),
    descripcionSitio TEXT,
    linkMapsSitio VARCHAR(255),
    PRIMARY KEY (idSitio)
);

CREATE TABLE ALEATORIO (
    idAleatorio INT NOT NULL AUTO_INCREMENT,
    idPlan INT NOT NULL,
    probabilidad DECIMAL(5,2) DEFAULT 1.00,
    descripcionAleatorio TEXT,
    vecesAceptado INT DEFAULT 0,
    vecesRechazado INT DEFAULT 0,
    categoria VARCHAR(100),
    PRIMARY KEY (idAleatorio)
);

CREATE TABLE EVENTO_CALENDARIO (
    idEventoCalendario INT NOT NULL AUTO_INCREMENT,
    fechaCalendario DATE NOT NULL,
    tipoEventoCalendario ENUM('ocupado','planeado','potencial','importante') NOT NULL,
    descripcionCalendario TEXT,
    colorHEX VARCHAR(7),
    significadoColor VARCHAR(100),
    contribuidoresEvento VARCHAR(255),
    nombreUsuario VARCHAR(50),
    idPlan INT,
    PRIMARY KEY (idEventoCalendario)
);

CREATE TABLE LISTA_DESEOS (
    idDeseo INT NOT NULL AUTO_INCREMENT,
    nombreDeseo VARCHAR(100) NOT NULL,
    precioDeseo DECIMAL(10,2),
    descripcionDeseo TEXT,
    enlaceDeseo VARCHAR(255),
    estadoDeseo ENUM('pendiente','comprado') DEFAULT 'pendiente',
    nombreUsuario VARCHAR(50) NOT NULL,
    PRIMARY KEY (idDeseo)
);

CREATE TABLE ETIQUETA_PLAN (
    idPlan INT NOT NULL,
    idEtiqueta INT NOT NULL,
    PRIMARY KEY (idPlan, idEtiqueta)
);

CREATE TABLE ACTIVIDAD_MATERIAL (
    idActividad INT NOT NULL,
    idMaterial INT NOT NULL,
    cantidadMaterial DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idActividad, idMaterial)
);

CREATE TABLE RECETA_INGREDIENTE (
    idReceta INT NOT NULL,
    idIngrediente INT NOT NULL,
    cantidadIngrediente DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (idReceta, idIngrediente)
);

-- FK
ALTER TABLE FOTO
    ADD CONSTRAINT FK_FOTO_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE ACTIVIDAD
    ADD CONSTRAINT FK_ACTIVIDAD_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE RECETA
    ADD CONSTRAINT FK_RECETA_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE PASO_RECETA
    ADD CONSTRAINT FK_PASO_RECETA_RECETA FOREIGN KEY (idReceta) REFERENCES RECETA(idReceta);

ALTER TABLE RESTAURANTE
    ADD CONSTRAINT FK_RESTAURANTE_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE SITIO
    ADD CONSTRAINT FK_SITIO_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE ALEATORIO
    ADD CONSTRAINT FK_ALEATORIO_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE EVENTO_CALENDARIO
    ADD CONSTRAINT FK_EVENTO_CALENDARIO_USUARIO FOREIGN KEY (nombreUsuario) REFERENCES USUARIO(nombreUsuario),
    ADD CONSTRAINT FK_EVENTO_CALENDARIO_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan);

ALTER TABLE LISTA_DESEOS
    ADD CONSTRAINT FK_LISTA_DESEOS_USUARIO FOREIGN KEY (nombreUsuario) REFERENCES USUARIO(nombreUsuario);

ALTER TABLE ETIQUETA_PLAN
    ADD CONSTRAINT FK_ETIQUETA_PLAN_PLAN FOREIGN KEY (idPlan) REFERENCES PLAN(idPlan),
    ADD CONSTRAINT FK_ETIQUETA_PLAN_ETIQUETA FOREIGN KEY (idEtiqueta) REFERENCES ETIQUETA(idEtiqueta);

ALTER TABLE ACTIVIDAD_MATERIAL
    ADD CONSTRAINT FK_ACTIVIDAD_MATERIAL_ACTIVIDAD FOREIGN KEY (idActividad) REFERENCES ACTIVIDAD(idActividad),
    ADD CONSTRAINT FK_ACTIVIDAD_MATERIAL_MATERIAL FOREIGN KEY (idMaterial) REFERENCES MATERIALES(idMaterial);

ALTER TABLE RECETA_INGREDIENTE
    ADD CONSTRAINT FK_RECETA_INGREDIENTE_RECETA FOREIGN KEY (idReceta) REFERENCES RECETA(idReceta),
    ADD CONSTRAINT FK_RECETA_INGREDIENTE_INGREDIENTE FOREIGN KEY (idIngrediente) REFERENCES INGREDIENTE(idIngrediente);