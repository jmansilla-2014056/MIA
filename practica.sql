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
    TIPO_MEDALLA_cod_tipo numeric NOT NULL REFERENCES TIPO_MEDALLA(cod_tipo),	
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
    TIPO_PATICIPACION_cod_participacion numeric NOT NULL REFERENCES TIPO_PARTICIPACION (cod_participacion), --FK
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





