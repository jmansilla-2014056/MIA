-- INICISO 1
CREATE TABLE PROFESION (
    cod_prof numeric NOT NULL PRIMARY KEY,
    nombre varchar(50) NOT NULL UNIQUE	
);

CREATE TABLE PAIS (
    cod_pais numeric NOT NULL PRIMARY KEY,
    nombre varchar(50) NOT NULL UNIQUE
);

CREATE TABLE PUESTO (
    cod_puesto numeric NOT NULL PRIMARY KEY,
    nombre varchar(50) NOT NULL UNIQUE
);

CREATE TABLE DEPARTAMENTO (
    cod_depto numeric NOT NULL PRIMARY KEY,
    nombre varchar(50) NOT NULL UNIQUE
);

CREATE TABLE MIEMBRO (
    cod_miembro numeric NOT NULL PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    apellido varchar(100) NOT NULL,
    edad numeric NOT NULL,
    telefono numeric NULL,
    residencia varchar(100) NULL,
    PAIS_cod_pais numeric NOT NULL REFERENCES PAIS (cod_pais),  --FK
    PROFESION_cod_prof numeric NOT NULL REFERENCES profesion (cod_prof) --FK
);


CREATE TABLE PUESTO_MIEMBRO (  
    PUESTO_cod_puesto numeric NOT NULL REFERENCES PUESTO (cod_puesto), --FK
    DEPARTAMENTO_cod_depto numeric NOT NULL REFERENCES DEPARTAMENTO (cod_depto), --FK
	MIEMBRO_cod_miembro numeric NOT NULL REFERENCES MIEMBRO (cod_miembro), --FK
	fecha_inicio date NOT NULL,
    fecha_fin date NULL,
	CONSTRAINT puesto_miembro_cod PRIMARY KEY(PUESTO_cod_puesto, DEPARTAMENTO_cod_depto, MIEMBRO_cod_miembro)
);

CREATE TABLE TIPO_MEDALLA(
    cod_tipo numeric NOT NULL PRIMARY KEY,
    medalla varchar(20) NOT NULL UNIQUE
);


CREATE TABLE MEDALLERO(
    PAIS_cod_pais numeric NOT NULL REFERENCES PAIS (cod_pais),
	cantidad_medallas numeric NOT NULL,
    TIPO_MEDALLA_cod_tipo numeric NOT NULL REFERENCES TIPO_MEDALLA(cod_tipo) ON DELETE CASCADE,	
    CONSTRAINT medallero_cod PRIMARY KEY (PAIS_cod_pais, TIPO_MEDALLA_cod_tipo)
);

CREATE TABLE DISCIPLINA (
    cod_disciplina numeric NOT NULL PRIMARY KEY,
    nombre varchar(50) not NULL,
    descripcion varchar(150) NULL
);

CREATE TABLE ATLETA(
    cod_atleta numeric NOT NULL PRIMARY KEY,
    nombre varchar(50) NOT NULL,
    apellido varchar(50) NOT NULL,
    edad numeric NOT NULL,
    participaciones varchar(100),
    DISCIPLINA_cod_disciplina numeric NOT NULL REFERENCES DISCIPLINA (cod_disciplina) ON DELETE CASCADE,
    PAIS_cod_pais numeric NOT NULL REFERENCES PAIS (cod_pais)
);

CREATE TABLE CATEGORIA(
    cod_categoria numeric NOT NULL PRIMARY KEY,
    categoria varchar(50) NOT NULL
);

CREATE TABLE TIPO_PARTICIPACION(
    cod_participacion numeric NOT NULL PRIMARY KEY,
    tipo_participacion varchar(100) NOT NULL
);

CREATE TABLE EVENTO(
    cod_evento numeric NOT NULL PRIMARY KEY,
    fecha date NOT NULL,
    ubicacion varchar(50) NOT NULL,
    hora timestamp NOT NULL,
    DISCIPLINA_cod_disciplina numeric NOT NULL REFERENCES DISCIPLINA (cod_disciplina) ON DELETE CASCADE, --FK
    TIPO_PARTICIPACION_cod_participacion numeric NOT NULL REFERENCES TIPO_PARTICIPACION (cod_participacion), --FK
    CATEGORIA_cod_categoria numeric NOT NULL REFERENCES CATEGORIA (cod_categoria) --FK
);

CREATE TABLE EVENTO_ATLETA(
    ATLETA_cod_atleta numeric NOT NULL REFERENCES ATLETA (cod_atleta),
    EVENTO_cod_evento numeric NOT NULL REFERENCES EVENTO (cod_evento),
    CONSTRAINT evento_atleta_cod PRIMARY KEY (ATLETA_cod_atleta, EVENTO_cod_evento)
);

CREATE TABLE TELEVISORA(
    cod_televisora numeric NOT NULL PRIMARY KEY,
    nombre varchar(50) NOT NULL
);

CREATE TABLE COSTO_EVENTO(
    EVENTO_cod_evento numeric NOT NULL REFERENCES EVENTO (cod_evento),
    TELEVISORA_cod_televisora numeric NOT NULL REFERENCES TELEVISORA (cod_televisora),
    tarifa numeric NOT NULL,
    CONSTRAINT cod_costo_evento PRIMARY KEY (evento_cod_evento, televisora_cod_televisora)
);

--INICISO 2
SELECT *FROM EVENTO;

ALTER TABLE EVENTO DROP fecha;
ALTER TABLE EVENTO DROP hora;
ALTER TABLE EVENTO ADD fecha_hora timestamp NOT NULL;

SELECT *FROM EVENTO;

--INCISO 3
ALTER TABLE EVENTO
ADD CONSTRAINT ck_fecha_hora CHECK (fecha_hora BETWEEN '2020-07-24 09:00:00'::timestamp AND '2020-08-09 20:00:00'::timestamp);
--en el inciso 6 verificaremos si efectivamente es posible ingresar fechas fuera del rango

--INCISO 4
--a
CREATE TABLE SEDE(
    codigo NUMERIC NOT NULL PRIMARY KEY,
    sede VARCHAR(50) NOT NULL
);
--b
SELECT *FROM EVENTO ;

ALTER TABLE EVENTO
ALTER COLUMN UBICACION TYPE numeric USING UBICACION::numeric,
ALTER COLUMN ubicacion SET NOT NULL;
--c
ALTER TABLE EVENTO
ADD CONSTRAINT fk_evento_sede FOREIGN KEY (ubicacion) REFERENCES SEDE (codigo);
SELECT *FROM EVENTO; 

SELECT *FROM EVENTO;

--INCISO 5
ALTER TABLE MIEMBRO
ALTER COLUMN telefono TYPE numeric,
ALTER COLUMN telefono SET DEFAULT 0;
--en el inciso 6 verificaremos si efectivamente el valor por defecto para un numero es 0

--INCISO 6
INSERT INTO PAIS (cod_pais, nombre) VALUES (1, 'Guatemala');
INSERT INTO PAIS (cod_pais, nombre) VALUES (2, 'Francia');
INSERT INTO PAIS (cod_pais, nombre) VALUES (3, 'Argentina');
INSERT INTO PAIS (cod_pais, nombre) VALUES (4, 'Alemania');
INSERT INTO PAIS (cod_pais, nombre) VALUES (5, 'Italia');
INSERT INTO PAIS (cod_pais, nombre) VALUES (6, 'Brasil');
INSERT INTO PAIS (cod_pais, nombre) VALUES (7, 'Estados Unidos');
SELECT *FROM PAIS;

INSERT INTO PROFESION (cod_prof, nombre) VALUES (1, 'Médico');
INSERT INTO PROFESION (cod_prof, nombre) VALUES (2, 'Arquitecto');
INSERT INTO PROFESION (cod_prof, nombre) VALUES (3, 'Ingeniero');
INSERT INTO PROFESION (cod_prof, nombre) VALUES (4, 'Secretaria');
INSERT INTO PROFESION (cod_prof, nombre) VALUES (5, 'Auditor');
SELECT *FROM PROFESION;

INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,pais_cod_pais,profesion_cod_prof)
VALUES (1,'Scott','Mitchell',32,'1092 Highland Drive Manitowoc, Wl 54220',7,3);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,pais_cod_pais,profesion_cod_prof)
VALUES (2,'Fanette','Poulin',25,25075853,'49, boulevard Aristide Briand 76120 LE GRAND-QUEVILLY',2,4);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,pais_cod_pais,profesion_cod_prof)
VALUES (3,'Laura','Cunha Silva',55,'Rua Onze, 86 Uberaba-MG',6,5);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,pais_cod_pais,profesion_cod_prof)
VALUES (4,'Juan José','López',38,36985247,'26 calle 4-10 zona 11',1,2);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,telefono,residencia,pais_cod_pais,profesion_cod_prof)
VALUES (5,'Arcangela','Panicucci',39,391664921,'Via Santa Teresa, 114 90010-Geraci Siculo PA',5,1);
INSERT INTO MIEMBRO (cod_miembro,nombre,apellido,edad,residencia,pais_cod_pais,profesion_cod_prof)
VALUES (6,'Jeuel','Villalpando',31,'Acuña de Figeroa 6106 80101 Playa Pascual',3,5);
SELECT *FROM MIEMBRO;

INSERT INTO DISCIPLINA (cod_disciplina,nombre,descripcion) VALUES (1,'Atletismo','Saltos de longitud y triples, de altura y con pértiga o garrocha; las pruebas de lanzamiento de martillo, jabalina y disco');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (2,'Bádminton');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (3,'Ciclismo');
INSERT INTO DISCIPLINA (cod_disciplina,nombre,descripcion) VALUES (4,'Judo','Es un arte marcial que se originó en Japón alrededor de 1880');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (5,'Lucha');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (6,'Tenis de Mesa');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (7,'Boxeo');
INSERT INTO DISCIPLINA (cod_disciplina,nombre,descripcion) VALUES (8,'Natación','Está presente como deporte en los Juegos desde la primera edición de la era moderna, en Atenas, Grecia, en 1896, donde se disputo en aguas abiertas.');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (9,'Esgrima');
INSERT INTO DISCIPLINA (cod_disciplina,nombre) VALUES (10,'Vela');
SELECT *FROM DISCIPLINA;

INSERT INTO TIPO_MEDALLA (cod_tipo, medalla) VALUES (1, 'Oro');
INSERT INTO TIPO_MEDALLA (cod_tipo, medalla) VALUES (2, 'Plata');
INSERT INTO TIPO_MEDALLA (cod_tipo, medalla) VALUES (3, 'Bronce');
INSERT INTO TIPO_MEDALLA (cod_tipo, medalla) VALUES (4, 'Platino');
SELECT *FROM TIPO_MEDALLA;

INSERT INTO CATEGORIA (cod_categoria, categoria) VALUES (1, 'Clasificatorio');
INSERT INTO CATEGORIA (cod_categoria, categoria) VALUES (2, 'Eliminatorio');
INSERT INTO CATEGORIA (cod_categoria, categoria) VALUES (3, 'Final');
SELECT *FROM CATEGORIA;

INSERT INTO TIPO_PARTICIPACION (cod_participacion, tipo_participacion) VALUES (1, 'Individual');
INSERT INTO TIPO_PARTICIPACION (cod_participacion, tipo_participacion) VALUES (2, 'Parejas');
INSERT INTO TIPO_PARTICIPACION (cod_participacion, tipo_participacion) VALUES (3, 'Equipos');
SELECT *FROM TIPO_PARTICIPACION;

INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (5,1,3);
INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (2,1,5);
INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (6,3,4);
INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (4,4,3);
INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (7,3,10);
INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (3,2,8);
INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (1,1,2);
INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (1,4,5);
INSERT INTO MEDALLERO (pais_cod_pais,tipo_medalla_cod_tipo,cantidad_medallas) VALUES (5,2,7);
SELECT *FROM MEDALLERO;

INSERT INTO SEDE (codigo, sede) VALUES (1,'Gimnasio Metropolitano de Tokio');
INSERT INTO SEDE (codigo, sede) VALUES (2,'Jardín del Palacio Imperial de Tokio');
INSERT INTO SEDE (codigo, sede) VALUES (3,'Gimnasio Nacional Yoyogi');
INSERT INTO SEDE (codigo, sede) VALUES (4,'Nippon Budokan');
INSERT INTO SEDE (codigo, sede) VALUES (5,'Estadio Olímpico');
SELECT *FROM SEDE;

INSERT INTO EVENTO (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (1,'2020-07-24 11:00:00', 3, 2, 2, 1);
INSERT INTO EVENTO (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (2,'2020-07-26 10:30:00', 1, 6, 1, 3);
INSERT INTO EVENTO (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (3,'2020-07-30 18:45:00', 5, 7, 1, 2);
INSERT INTO EVENTO (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (4,'2020-08-01 12:15:00', 2, 1, 1, 1);
INSERT INTO EVENTO (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (5,'2020-08-08 19:35:00', 4, 10, 3, 1);
SELECT *FROM EVENTO;
--Ingresar fechas fuera del rango 
INSERT INTO EVENTO (cod_evento,fecha_hora,ubicacion,disciplina_cod_disciplina,tipo_participacion_cod_participacion,categoria_cod_categoria)
VALUES (1,'2019-08-08 19:35:00', 1, 1, 1, 1);

--INCISO 7
SELECT *from pais;
ALTER TABLE PAIS DROP CONSTRAINT pais_nombre_key;
ALTER TABLE TIPO_MEDALLA DROP CONSTRAINT tipo_medalla_medalla_key;
ALTER TABLE DEPARTAMENTO DROP CONSTRAINT departamento_nombre_key;

/*INCISO 8*/
--a
ALTER TABLE ATLETA DROP CONSTRAINT ATLETA_DISCIPLINA_cod_disciplina_fkey;
ALTER TABLE ATLETA DROP COLUMN DISCIPLINA_cod_disciplina;
--b
CREATE TABLE disciplina_atleta(
    cod_atleta numeric NOT NULL,
    cod_disciplina numeric NOT NULL,
    CONSTRAINT pk_disciplina_atleta PRIMARY KEY (cod_atleta, cod_disciplina),
    CONSTRAINT fk_disciplina_atleta_atleta FOREIGN KEY (cod_atleta) REFERENCES atleta (cod_atleta),
    CONSTRAINT fk_disciplina_atleta_disciplina FOREIGN KEY (cod_disciplina) REFERENCES disciplina (cod_disciplina)
);

--INCISO 9
ALTER TABLE COSTO_EVENTO
ALTER COLUMN tarifa TYPE numeric(20, 2);

--INCISO 10
SELECT *FROM tipo_medalla;
DELETE FROM tipo_medalla WHERE cod_tipo = 4;
SELECT *FROM tipo_medalla;

--INCISO 11
DROP TABLE COSTO_EVENTO;
DROP TABLE TELEVISORA;

--INCISO 12
DELETE FROM DISCIPLINA;
SELECT *FROM DISCIPLINA;

--INCISO 13
UPDATE MIEMBRO SET telefono = 55464601 WHERE nombre = 'Laura' AND apellido = 'Cunha Silva';
UPDATE MIEMBRO SET telefono = 91514243 WHERE nombre = 'Jeuel' AND apellido = 'Villalpando';
UPDATE MIEMBRO SET telefono = 92068667 WHERE nombre = 'Scott' AND apellido = 'Mitchell';
SELECT *FROM MIEMBRO;

--INCISO 14
ALTER TABLE ATLETA ADD fotografia bytea NULL;


--INCISO 15
ALTER TABLE ATLETA ADD CONSTRAINT ck_atleta_edad_maxima CHECK (edad < 25);
INSERT INTO ATLETA(cod_atleta, nombre, apellido, edad, participaciones, disciplina_cod_disciplina,pais_cod_pais)
VALUES(1,'Ana Sofia','Gomez', 40, NULL, 1, 1);
SELECT *FROM ATLETA;

