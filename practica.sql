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
    nombre varchar(50) NOT NULL UNIQUE,
);


CREATE TABLE MIEMBRO (
    cod_miembro numeric NOT NULL,
    nombre varchar(100) NOT NULL,
    apellido varchar(100) NOT NULL,
    edad numeric NOT NULL,
    telefono numeric NULL,
    residencia varchar(100) NULL,
    PAIS_cod_pais numeric NOT NULL REFERENCES PAIS (cod_pais),
    PROFESION_cod_prof numeric NOT NULL,
    CONSTRAINT pk_miembro PRIMARY KEY (cod_miembro),
    CONSTRAINT fk_miembro_pais FOREIGN KEY (pais_cod_pais) REFERENCES pais (cod_pais),
    CONSTRAINT fk_miembro_prof FOREIGN KEY (profesion_cod_prof) REFERENCES profesion (cod_prof)
);

