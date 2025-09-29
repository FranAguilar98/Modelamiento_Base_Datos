CREATE TABLE PERSONAL (
rut_persona NUMBER (8),
dv_persona char (1) NOT NULL,
pri_nombre VARCHAR2 (25) NOT NULL,
seg_nombre VARCHAR2 (25) NOT NULL,
pri_apellido VARCHAR2 (25) NOT NULL,
seg_apellido VARCHAR2 (25) NOT NULL,
fecha_cont DATE NOT NULL,
fecha_nac DATE NOT NULL,
email VARCHAR2 (100),
calle VARCHAR2 (50) NOT NULL,
numeracion NUMBER (5) NOT NULL,
sueldo NUMBER (5) NOT NULL ,
COMPANIA_id_empresa NUMBER (2),
COMUNA_id_comuna NUMBER (5),
ESTADO_CIVIL_id_est_civil VARCHAR(2),
GENERO_id_genero VARCHAR2 (3),
CONSTRAINT PK_PERSONAL PRIMARY KEY (rut_persona),
CONSTRAINT FK_PERSONAL_COMPANIA FOREIGN KEY (COMPANIA_id_empresa) REFERENCES COMPANIA(id_empresa),
CONSTRAINT FK_PERSONAL_COMUNA FOREIGN KEY (COMUNA_id_comuna) REFERENCES COMUNA(id_comuna),
CONSTRAINT FK_PERSONAL_ESTADO_CIVIL FOREIGN KEY (ESTADO_CIVIL_id_est_civil) REFERENCES ESTADO_CIVIL(id_est_civil),
CONSTRAINT FK_PERSONAL_GENERO FOREIGN KEY (GENERO_id_genero) REFERENCES GENERO(id_genero)
 );

CREATE TABLE COMPANIA(
id_empresa NUMBER (2),
nom_empresa VARCHAR2(25) NOT NULL,
calle VARCHAR2(50) NOT NULL,
numeracion NUMBER (5) NOT NULL,
renta_prom NUMBER (10) NOT NULL,
pct_aumento NUMBER  (5,3) NULL,
COMUNA_id_comuna NUMBER (5),
CONSTRAINT PK_COMPANIA PRIMARY KEY (id_empresa),
CONSTRAINT FK_COMPANIA_COMUNA FOREIGN KEY (COMUNA_id_comuna) REFERENCES COMUNA (id_comuna)
);

CREATE TABLE TITULO (
id_titulo VARCHAR2 (3),
descr_titulo VARCHAR (60) NOT NULL,
CONSTRAINT PK_TITULO PRIMARY KEY (id_titulo)
);

CREATE TABLE TITULACION (
cod_titulo VARCHAR (3),
persona_rut NUMBER (8),
fech_titulacion DATE NOT NULL,
PERSONAL_rut_persona NUMBER (8),
TITULO_id_titulo VARCHAR2 (3),
CONSTRAINT PK_TITULACION PRIMARY KEY (cod_titulo, persona_rut),
CONSTRAINT FK_TITULACION_PERSONAL FOREIGN KEY (PERSONAL_rut_persona) REFERENCES PERSONAL (rut_persona),
CONSTRAINT FK_TITULACION_TITULO FOREIGN KEY (TITULO_id_titulo) REFERENCES TITULO (id_titulo)
);

DROP TABLE COMUNA CASCADE CONSTRAINTS;

CREATE TABLE IDIOMA(
id_idioma NUMBER (3) GENERATED ALWAYS AS IDENTITY(
START WITH 25
INCREMENT BY 3),
nom_idioma VARCHAR2 (30) NOT NULL,
CONSTRAINT PK_IDIOMA PRIMARY KEY (id_idioma)
);

CREATE TABLE DOMINIO( 
id_idioma NUMBER (3),
personal_rut NUMBER (8),
nivel VARCHAR2 (25) NOT NULL,
CONSTRAINT PK_DOMINIO PRIMARY KEY (id_idioma, personal_rut)
);

CREATE TABLE REGION (
id_region NUMBER (2) GENERATED ALWAYS AS IDENTITY(
START WITH 7
INCREMENT BY 2),
nom_region VARCHAR2 (25) NOT NULL,
CONSTRAINT PK_REGION PRIMARY KEY (id_region)
);

CREATE TABLE COMUNA (
id_comuna NUMBER (5),
comuna_nom VARCHAR2 (25) NOT NULL,
REGION_id_region NUMBER (2),
CONSTRAINT PK_COMUNA PRIMARY KEY (id_comuna),
CONSTRAINT FK_COMUNA_REGION FOREIGN KEY (REGION_id_region) REFERENCES REGION (id_region)
);

CREATE TABLE GENERO (
id_genero VARCHAR2 (3),
descr_genero VARCHAR2 (25) NOT NULL,
CONSTRAINT PK_GENERO PRIMARY KEY (id_genero)
);

CREATE TABLE ESTADO_CIVIL (
id_est_civil VARCHAR2 (2),
descr_est_civil VARCHAR2 (25) NOT NULL,
CONSTRAINT PK_ESTADO_CIVIL PRIMARY KEY (id_est_civil)
);

DROP SEQUENCE seq_comuna;
 
 ALTER TABLE PERSONAL
 ADD CONSTRAINT personal_email_un 
 UNIQUE (email);
 
 ALTER TABLE PERSONAL
 ADD CONSTRAINT personal_dv_persona_ck 
 CHECK (dv_persona IN('0','1','2','3','4','5','6','7','8','9','K'));
 
 ALTER TABLE PERSONAL
 ADD CONSTRAINT personal_sueldo_ck 
 CHECK (sueldo>= 450000);

 
 CREATE SEQUENCE seq_compania 
 START WITH 10 INCREMENT BY 5;
 
 CREATE SEQUENCE seq_comuna
 START WITH 1101 INCREMENT BY 6;
 
 INSERT INTO REGION (nom_region) VALUES ('Metropolitana');
 INSERT INTO REGION (nom_region) VALUES ('Valparaíso');
 INSERT INTO REGION (nom_region) VALUES ('Biobío');
 
 INSERT INTO COMUNA (id_comuna, comuna_nom, REGION_id_region) VALUES (seq_comuna.NEXTVAL, 'Arica', 7);
 INSERT INTO COMUNA (id_comuna, comuna_nom, REGION_id_region) VALUES (seq_comuna.NEXTVAL, 'Santiago', 7);
 INSERT INTO COMUNA (id_comuna, comuna_nom, REGION_id_region) VALUES (seq_comuna.NEXTVAL, 'Temuco', 11);
 
 INSERT INTO COMPANIA (id_empresa, nom_empresa, calle, numeracion, renta_prom, pct_aumento, COMUNA_id_comuna)
 VALUES (seq_compania.NEXTVAL, 'CCyRojas', 'Amapolas', 506, 1857000, 0.500, 1101);

 INSERT INTO COMPANIA (id_empresa, nom_empresa, calle, numeracion, renta_prom, pct_aumento, COMUNA_id_comuna)
 VALUES (seq_compania.NEXTVAL, 'SenTTy', 'Los Alamos', 3490, 897000, 0.025, 1101);

 INSERT INTO COMPANIA (id_empresa, nom_empresa, calle, numeracion, renta_prom, pct_aumento, COMUNA_id_comuna)
 VALUES (seq_compania.NEXTVAL, 'Praxia LTDA', 'Las Camelias', 11098, 2157000, 0.035, 1107);

 INSERT INTO COMPANIA (id_empresa, nom_empresa, calle, numeracion, renta_prom, pct_aumento, COMUNA_id_comuna)
 VALUES (seq_compania.NEXTVAL, 'TIC spa', 'FLORES S.A', 4357, 857000, 0.000, 1107);

 INSERT INTO COMPANIA (id_empresa, nom_empresa, calle, numeracion, renta_prom, pct_aumento, COMUNA_id_comuna)
 VALUES (seq_compania.NEXTVAL, 'SANTANA LTDA', 'AVDA VIC. MAKENA', 106, 757000, 0.015, 1113);

 INSERT INTO COMPANIA (id_empresa, nom_empresa, calle, numeracion, renta_prom, pct_aumento, COMUNA_id_comuna)
 VALUES (seq_compania.NEXTVAL, 'FLORES Y ASOCIADOS', 'PEDRO LATORRE', 557, 589000, 0.015, 1113);

 INSERT INTO COMPANIA (id_empresa, nom_empresa, calle, numeracion, renta_prom, pct_aumento, COMUNA_id_comuna)
 VALUES (seq_compania.NEXTVAL, 'J.A. HOFFMAN', 'LATINA D.32', 509, 1857000, 0.025, 1113);

 
 INSERT INTO IDIOMA (nom_idioma) VALUES ('Español');
 INSERT INTO IDIOMA (nom_idioma) VALUES ('Inglés');
 INSERT INTO IDIOMA (nom_idioma) VALUES ('Chino');
 
 SELECT 
 nom_empresa AS "Nombre Empresa",
 calle ||' ' || numeracion AS "Dirección completa",
 renta_prom AS "Renta Promedio",
 renta_prom * (1 + NVL(pct_aumento, 0)) AS "Renta Simulada"
 FROM
 COMPANIA
 ORDER BY 
 renta_prom DESC,
 nom_empresa ASC;
 
 SELECT
 id_empresa AS "ID Empresa",
 nom_empresa AS "Nombre Empresa",
 renta_prom AS "Renta Promedio Actual",
 (NVL(pct_aumento, 0) + 0.15) AS "Porcentaje Aumentado +15%",
 renta_prom * (1 + NVL(pct_aumento, 0) + 0.15) AS "Renta Promedio Incrementada"
 FROM 
 COMPANIA
 ORDER BY
 renta_prom ASC,
 nom_empresa DESC; 
   


