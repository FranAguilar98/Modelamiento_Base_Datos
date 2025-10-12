CREATE TABLE PERSONAL (
cod_personal NUMBER (5),
rut_personal VARCHAR2 (10) NOT NULL,
nombre_personal VARCHAR2 (20) NOT NULL,
apellido_paterno VARCHAR2 (20) NOT NULL,
apellido_materno VARCHAR2 (20) NOT NULL,
fecha_contratacion DATE NOT NULL,
sueldo_base NUMBER (7) NOT NULL,
estado_activo CHAR (1) NOT NULL,
tipo_personal VARCHAR2 (20) NOT NULL,
SISTEMA_SALUD_id_salud NUMBER (5) NOT NULL,
AFP_id_afp NUMBER (5) NOT NULL,
JEFE_T_cod_jefe NUMBER (5),
CONSTRAINT PK_PERSONAL PRIMARY KEY (cod_personal)
);

CREATE TABLE AFP(
id_afp NUMBER (5),
nom_afp VARCHAR2 (25) NOT NULL,
CONSTRAINT PK_AFP PRIMARY KEY (id_afp) 
);

CREATE TABLE SISTEMA_SALUD(
id_salud NUMBER (5),
nom_salud VARCHAR2 (25) NOT NULL,
CONSTRAINT PK_SISTEMA_SALUD PRIMARY KEY (id_salud)
);

CREATE TABLE REGION (
id_region NUMBER (5),
nom_region VARCHAR2(30),
CONSTRAINT PK_REGION PRIMARY KEY (id_region)
);

CREATE TABLE COMUNA(
id_comuna NUMBER (5) GENERATED ALWAYS AS IDENTITY (
START WITH 1050
INCREMENT BY 5),
nom_comuna VARCHAR2 (20) NOT NULL,
REGION_id_region NUMBER (5) NOT NULL,
CONSTRAINT PK_COMUNA PRIMARY KEY (id_comuna)
);

CREATE TABLE PLANTA(
id_planta NUMBER (5),
nom_planta VARCHAR2 (20) NOT NULL,
direccion VARCHAR2 (50) NOT NULL,
COMUNA_id_comuna NUMBER (5) NOT NULL,
CONSTRAINT PK_PLANTA PRIMARY KEY (id_planta)
);

CREATE TABLE TIPOS_MAQUINA(
cod_maquina VARCHAR2 (50),
num_maquina NUMBER (6) NOT NULL,
nom_maquina VARCHAR2 (25) NOT NULL,
estado_activo CHAR (1)NOT NULL,
tipo VARCHAR2 (25) NOT NULL,
PLANTA_id_planta NUMBER (5) NOT NULL,
CONSTRAINT PK_TIPOS_MAQUINA PRIMARY KEY (cod_maquina)
);

CREATE TABLE MANTENCION (
cod_mantencion VARCHAR2 (25),
tec_responsable VARCHAR2 (25) NOT NULL,
fecha_programada DATE NOT NULL,
fecha_ejecucion DATE NOT NULL,
descripcion_trabajo VARCHAR2 (50)NOT NULL,
TIPOS_MAQUINA_cod_maquina VARCHAR2 (50) NOT NULL,
CONSTRAINT PK_MANTENCION PRIMARY KEY (cod_mantencion)
);

CREATE TABLE TURNO(
id_turno VARCHAR2 (5),
tipo_turno VARCHAR2 (25) NOT NULL,
hora_inicio CHAR (5)NOT NULL,
hora_termino CHAR (5)NOT NULL,
CONSTRAINT PK_TURNOS PRIMARY KEY (id_turno) 
);

CREATE TABLE DOTACION(
TIPOS_MAQUINA_cod_maquina VARCHAR2 (50),
PERSONAL_cod_personal NUMBER (5),
TURNO_id_turno VARCHAR2 (5),
fecha_turno DATE NOT NULL,
CONSTRAINT PK_DOTACION PRIMARY KEY (TIPOS_MAQUINA_cod_maquina, PERSONAL_cod_personal, TURNO_id_turno)
);

CREATE TABLE JEFE_T(
cod_personal NUMBER (5),
area_responsabilidad VARCHAR2 (25)NOT NULL,
max_operarios NUMBER (3) NOT NULL,
CONSTRAINT PK_JEFE_T PRIMARY KEY (cod_personal)
);

CREATE TABLE OPERARIO(
cod_personal NUMBER (5),
categoria_trabajo VARCHAR2 (25) NOT NULL,
certificacion VARCHAR2 (25),
horas_turno NUMBER (2) NOT NULL,
CONSTRAINT PK_OPERARIO PRIMARY KEY (cod_personal)
);

CREATE TABLE TECNICO_MANTENCION( 
cod_personal NUMBER (5),
especialidad_tec VARCHAR2 (25) NOT NULL,
certificacion_tec VARCHAR2 (25),
tiempo_respuesta NUMBER (2)NOT NULL,
CONSTRAINT PK_TECNICO_MANTENCION PRIMARY KEY (cod_personal)
);



ALTER TABLE PERSONAL 
ADD CONSTRAINT PERSONAL_FK_SISTEMA_SALUD
FOREIGN KEY (SISTEMA_SALUD_id_salud)
REFERENCES SISTEMA_SALUD(id_salud);

ALTER TABLE PERSONAL 
ADD CONSTRAINT PERSONAL_FK_AFP
FOREIGN KEY (AFP_id_afp)
REFERENCES AFP (id_afp);

ALTER TABLE PERSONAL
ADD CONSTRAINT PERSONAL_FK_JEFE
FOREIGN KEY (JEFE_T_cod_jefe)
REFERENCES JEFE_T (cod_personal);

ALTER TABLE COMUNA
ADD CONSTRAINT COMUNA_FK_REGION
FOREIGN KEY (REGION_id_region)
REFERENCES REGION (id_region);

ALTER TABLE PLANTA
ADD CONSTRAINT PLANTA_FK_COMUNA
FOREIGN KEY (COMUNA_id_comuna)
REFERENCES COMUNA(id_comuna);

ALTER TABLE TIPOS_MAQUINA
ADD CONSTRAINT TIPOS_MAQUINA_FK_PLANTA
FOREIGN KEY (PLANTA_id_planta)
REFERENCES PLANTA (id_planta);

ALTER TABLE MANTENCION
ADD CONSTRAINT MANTENCION_FK_TIPOS_MAQUINA
FOREIGN KEY (TIPOS_MAQUINA_cod_maquina)
REFERENCES TIPOS_MAQUINA(cod_maquina);

ALTER TABLE DOTACION
ADD CONSTRAINT DOTACION_FK_TIPOS_MAQUINA
FOREIGN KEY (TIPOS_MAQUINA_cod_maquina)
REFERENCES TIPOS_MAQUINA(cod_maquina);

ALTER TABLE DOTACION 
ADD CONSTRAINT DOTACION_FK_PERSONAL
FOREIGN KEY (PERSONAL_cod_personal)
REFERENCES PERSONAL (cod_personal);

ALTER TABLE DOTACION 
ADD CONSTRAINT DOTACION_FK_TURNO
FOREIGN KEY (TURNO_id_turno)
REFERENCES TURNO(id_turno);

ALTER TABLE JEFE_T
ADD CONSTRAINT JEFE_T_FK_PERSONAL
FOREIGN KEY (cod_personal)
REFERENCES PERSONAL (cod_personal);

ALTER TABLE OPERARIO
ADD CONSTRAINT OPERARIO_FK_PERSONAL
FOREIGN KEY (cod_personal)
REFERENCES PERSONAL(cod_personal);

ALTER TABLE TECNICO_MANTENCION
ADD CONSTRAINT TECNICO_PERSONAL_FK_PERSONAL
FOREIGN KEY (cod_personal)
REFERENCES PERSONAL(cod_personal);


ALTER TABLE REGION
ADD CONSTRAINT region_nom_region_un
UNIQUE (nom_region);

ALTER TABLE SISTEMA_SALUD
ADD CONSTRAINT sistema_salud_nom_salud_un
UNIQUE (nom_salud);

ALTER TABLE AFP
ADD CONSTRAINT afp_nom_afp_un
UNIQUE (nom_afp);

ALTER TABLE TIPOS_MAQUINA
ADD CONSTRAINT tipos_maquina_nom_maquina_un
UNIQUE (nom_maquina);

ALTER TABLE TURNO
ADD CONSTRAINT turno_tipo_turno_un
UNIQUE (tipo_turno);

ALTER TABLE MANTENCION 
ADD CONSTRAINT mantencion_fechas_ck
CHECK (fecha_ejecucion >= fecha_programada);

CREATE SEQUENCE seq_region
START WITH 21
INCREMENT BY 1;
DROP SEQUENCE seq_region;

INSERT INTO REGION (id_region, nom_region)
VALUES (seq_region.NEXTVAL, 'Valparaíso');

INSERT INTO REGION (id_region, nom_region)
VALUES (seq_region.NEXTVAL, 'Región Metropolitana');


INSERT INTO COMUNA (nom_comuna, REGION_id_region)
VALUES ('Quilpué', 21);

INSERT INTO COMUNA (nom_comuna, REGION_id_region)
VALUES ('Maipú', 22);


INSERT INTO PLANTA (id_planta, nom_planta, direccion, COMUNA_id_comuna)
VALUES (45, 'Planta Oriente', 'Camino Industrial 1234', 1050);

INSERT INTO PLANTA (id_planta, nom_planta, direccion, COMUNA_id_comuna)
VALUES (46, 'Planta Costa', 'AV. Vidrieras 890', 1055);


INSERT INTO TURNO (id_turno,tipo_turno,hora_inicio,hora_termino)
VALUES ('M0715','Mañana','07:00','15:00');

INSERT INTO TURNO (id_turno,tipo_turno,hora_inicio,hora_termino)
VALUES ('N2307','Noche','23:00','7:00');

INSERT INTO TURNO (id_turno,tipo_turno,hora_inicio,hora_termino)
VALUES ('T1523', 'Tarde','15:00','23:00');


SELECT id_turno ||' '|| tipo_turno AS "TURNO",
       hora_inicio AS "ENTRADA",
       hora_termino AS "SALIDA"
FROM TURNO
WHERE (hora_inicio > '20:00')
ORDER BY hora_inicio DESC;

SELECT tipo_turno||' '|| id_turno AS "TURNO",
       hora_inicio AS "ENTRADA",
       hora_termino AS "SALIDA"
FROM TURNO
WHERE hora_inicio BETWEEN '06:00' AND '14:59'
ORDER BY hora_inicio ASC;

