CREATE TABLE EMPLEADO (
id_empleado NUMBER (4) ,
rut_empleado VARCHAR2 (10) NOT NULL,
nombre_empleado VARCHAR2 (25) NOT NULL,
apellido_paterno VARCHAR2 (25) NOT NULL,
apellido_materno VARCHAR2 (25) NOT NULL,
fecha_contratacion DATE NOT NULL,
sueldo_base NUMBER (10) NOT NULL,
bono_jefatura NUMBER (10),
activo CHAR (1) NOT NULL,
tipo_empleado VARCHAR2 (25) NOT NULL,
SALUD_id_salud NUMBER (4) NOT NULL,
AFP_id_afp NUMBER (5) NOT NULL,
EMPLEADO_id_jefe NUMBER (4),
CONSTRAINT PK_EMPLEADO PRIMARY KEY (id_empleado)
);

CREATE TABLE PRODUCTO(
id_producto NUMBER (4),
nombre_producto VARCHAR2(100) NOT NULL,
precio_unitario NUMBER,
origen_nacional CHAR (1) NOT NULL,
stock_minimo NUMBER (3) NOT NULL,
activo_produc CHAR (1) NOT NULL,
MARCA_id_marca NUMBER (3) NOT NULL,
CATEGORIA_id_categoria NUMBER (3) NOT NULL,
PROVEEDOR_id_proveedor NUMBER (5) NOT NULL,
CONSTRAINT PK_PRODUCTO PRIMARY KEY (id_producto)
);

CREATE TABLE VENTA(
id_venta NUMBER (4) GENERATED ALWAYS AS IDENTITY(
START WITH 5050
INCREMENT BY 3),
fecha_venta DATE NOT NULL,
total_venta NUMBER (10) NOT NULL,
MEDIO_PAGO_id_mpago NUMBER (3) NOT NULL,
EMPLEADO_id_empleado NUMBER (4) NOT NULL,
CONSTRAINT PK_VENTA PRIMARY KEY (id_venta)
);

CREATE TABLE PROVEEDOR(
id_proveedor NUMBER (5) NOT NULL,
nombre_provedor VARCHAR2 (150) NOT NULL,
rut_proveedor VARCHAR (10) NOT NULL,
telefono VARCHAR2 (10) NOT NULL,
email VARCHAR2 (200) NOT NULL,
direccion VARCHAR2 (200) NOT NULL,
COMUNA_id_comuna NUMBER (4) NOT NULL,
CONSTRAINT PK_PROVEEDOR PRIMARY KEY (id_proveedor)
);

CREATE TABLE REGION(
id_region number (4),
nom_region VARCHAR2 (255) NOT NULL,
CONSTRAINT PK_REGION PRIMARY KEY (id_region)
);

CREATE TABLE MARCA(
id_marca NUMBER(3),
nombre_marca VARCHAR2 (25) NOT NULL,
CONSTRAINT PK_MARCA PRIMARY KEY (id_marca)
);

CREATE TABLE CATEGORIA (
id_categoria NUMBER (3),
nombre_categoria VARCHAR2 (255) NOT NULL,
CONSTRAINT PK_CATEGORIA PRIMARY KEY (id_categoria)
);

CREATE TABLE AFP (
id_afp NUMBER (5) GENERATED ALWAYS AS IDENTITY (
START WITH 210
INCREMENT BY 6),
nom_afp VARCHAR2 (255) NOT NULL,
CONSTRAINT PK_AFP PRIMARY KEY (id_afp)
);

CREATE TABLE SALUD (
id_salud NUMBER (4),
nom_salud VARCHAR2 (40) NOT NULL,
CONSTRAINT PK_SALUD PRIMARY KEY (id_salud)
);

CREATE TABLE MEDIO_PAGO (
id_mpago NUMBER (3),
nombre_mpago VARCHAR2 (50) NOT NULL,
CONSTRAINT PK_MEDIO_PAGO PRIMARY KEY (id_mpago)
);

CREATE TABLE COMUNA (
id_comuna NUMBER (4),
nom_comuna VARCHAR (255) NOT NULL,
REGION_id_region NUMBER (4) NOT NULL,
CONSTRAINT PK_COMUNA PRIMARY KEY (id_comuna)
);

CREATE TABLE DETALLE_VENTA (
VENTA_id_venta NUMBER (4),
PRODUCTO_id_producto NUMBER (4),
cantidad NUMBER (6) NOT NULL,
CONSTRAINT PK_DETALLE_VENTA PRIMARY KEY (VENTA_id_venta,PRODUCTO_id_producto)
);

CREATE TABLE ADMINISTRATIVO (
id_empleado NUMBER (4),
CONSTRAINT PK_ADMINISTRATIVO PRIMARY KEY (id_empleado)
);

CREATE TABLE VENDEDOR(
id_empleado NUMBER (4),
comision_venta NUMBER(5,2), 
CONSTRAINT PK_VENDEDOR PRIMARY KEY (id_empleado)
);


ALTER TABLE EMPLEADO
ADD CONSTRAINT EMPLEADO_FK_SALUD
FOREIGN KEY (SALUD_id_salud)
REFERENCES SALUD (id_salud);

ALTER TABLE EMPLEADO
ADD CONSTRAINT EMPLEADO_FK_AFP
FOREIGN KEY (AFP_id_afp)
REFERENCES AFP (id_afp);

ALTER TABLE EMPLEADO
ADD CONSTRAINT EMPLEADO_FK_EMPLEADO
FOREIGN KEY (EMPLEADO_id_jefe)
REFERENCES EMPLEADO (id_empleado);

ALTER TABLE PRODUCTO 
ADD CONSTRAINT PRODUCTO_FK_MARCA
FOREIGN KEY (MARCA_id_marca)
REFERENCES MARCA (id_marca);

ALTER TABLE PRODUCTO
ADD CONSTRAINT PRODUCTO_FK_CATEGORIA
FOREIGN KEY (CATEGORIA_id_categoria)
REFERENCES CATEGORIA (id_categoria);

ALTER TABLE PRODUCTO 
ADD CONSTRAINT PRODUCTO_FK_PROVEEDOR
FOREIGN KEY (PROVEEDOR_id_proveedor)
REFERENCES PROVEEDOR (id_proveedor);

ALTER TABLE VENTA 
ADD CONSTRAINT VENTA_FK_EMPLEADO
FOREIGN KEY (EMPLEADO_id_empleado)
REFERENCES EMPLEADO (id_empleado);

ALTER TABLE VENTA
ADD CONSTRAINT VENTA_FK_MEDIO_PAGO
FOREIGN KEY (MEDIO_PAGO_id_mpago)
REFERENCES MEDIO_PAGO (id_mpago);

ALTER TABLE PROVEEDOR 
ADD CONSTRAINT PROVEEDOR_FK_COMUNA
FOREIGN KEY (COMUNA_id_comuna)
REFERENCES COMUNA (id_comuna);

ALTER TABLE COMUNA
ADD CONSTRAINT COMUNA_FK_REGION
FOREIGN KEY (REGION_id_region)
REFERENCES REGION (id_region);

ALTER TABLE DETALLE_VENTA
ADD CONSTRAINT DETALLE_VENTA_FK_VENTA
FOREIGN KEY (VENTA_id_venta)
REFERENCES VENTA (id_venta);

ALTER TABLE DETALLE_VENTA
ADD CONSTRAINT DETALLE_VENTA_FK_PRODUCTO
FOREIGN KEY (PRODUCTO_id_producto)
REFERENCES PRODUCTO (id_producto); 

ALTER TABLE ADMINISTRATIVO 
ADD CONSTRAINT ADMINISTRATIVO_FK_EMPLEADO
FOREIGN KEY (id_empleado)
REFERENCES EMPLEADO (id_empleado);

ALTER TABLE VENDEDOR 
ADD CONSTRAINT VENDEDOR_FK_EMPLEADO
FOREIGN KEY (id_empleado)
REFERENCES EMPLEADO (id_empleado);


ALTER TABLE EMPLEADO
ADD CONSTRAINT empleado_sueldo_base_ck 
CHECK (sueldo_base>= 400000);
 
ALTER TABLE VENDEDOR
ADD CONSTRAINT vendedor_comision_venta_ck
CHECK (comision_venta>=0 AND comision_venta <=0.25);

ALTER TABLE PRODUCTO 
ADD CONSTRAINT producto_stock_minimo_ck
CHECK (stock_minimo >=3);

ALTER TABLE PROVEEDOR
ADD CONSTRAINT proveedor_email_un
UNIQUE (email);

ALTER TABLE MARCA
ADD CONSTRAINT marca_nombre_marca_un
UNIQUE (nombre_marca);

ALTER TABLE DETALLE_VENTA
ADD CONSTRAINT detalle_venta_cantidad_ck
CHECK (cantidad>=1);

CREATE SEQUENCE seq_salud 
START WITH 2050 
INCREMENT BY 10;
 
CREATE SEQUENCE seq_empleado 
START WITH 750 
INCREMENT BY 3; 


INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado,SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL, '11111111-1','Marcela','Gonzáles','Pérez', '15-03-2022',950000,80000,'S', 'Administrativo', 2050,210, NULL);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado,SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL , '22222222-2','José','Muñoz','Ramírez','10-07-2021',900000,75000,'S','Administrativo',2060 ,216, NULL);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado,SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL, '3333333-3', 'Veronica','Soto','Alarcón', '05-01-2020',880000,70000,'S', 'Vendedor', 2060, 228, 750);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado,SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL, '44444444-4', 'Luis', 'Reyes', 'Fuentes','01-04-2023',560000,NULL,'S','Vendedor',2070 ,228,750);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado, SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL, '55555555-5', 'Claudia', 'Fernández', 'Lagos', '15-04-2023', 600000, NULL, 'S', 'Vendedor',2070, 216,753);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado, SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL, '66666666-6','Carlos', 'Navarro', 'Vega', '01/05/2023', 610000,NULL,'S','Administrativo', 2060,210,753);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado, SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL,'77777777-7', 'Javiera','Pino','Rojas', '10/05/2023',650000,NULL, 'S', 'Administrativo',2050,210,750);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado, SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL,'88888888-8', 'Diego', 'Mella', 'Contreras','12/05/2023', 620000,NULL,'S','Vendedor',2060,216,753);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado, SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL, '99999999-9','Fernanda', 'Salas', 'Herrera', '18/05/2023',570000,NULL,'S','Vendedor',2070,228,753);

INSERT INTO EMPLEADO (id_empleado, rut_empleado, nombre_empleado, apellido_paterno, apellido_materno,
    fecha_contratacion, sueldo_base, bono_jefatura, activo, tipo_empleado, SALUD_id_salud, AFP_id_afp, EMPLEADO_id_jefe)
VALUES (seq_empleado.NEXTVAL, '10101010-0', 'Tomás', 'Vidal', 'Espinoza', '01/06/2023',530000,NULL, 'S', 'Vendedor',2050,222,NULL);


INSERT INTO VENTA (fecha_venta,total_venta,MEDIO_PAGO_id_mpago,EMPLEADO_id_empleado)
VALUES ('12-05-2023',225990,12,753);

INSERT INTO VENTA (fecha_venta,total_venta,MEDIO_PAGO_id_mpago,EMPLEADO_id_empleado)
VALUES ('23-10-2023',524990,13,762);

INSERT INTO VENTA (fecha_venta,total_venta,MEDIO_PAGO_id_mpago,EMPLEADO_id_empleado)
VALUES ('17-02-2023',466990,11,759);

INSERT INTO VENTA (fecha_venta,total_venta,MEDIO_PAGO_id_mpago,EMPLEADO_id_empleado)
VALUES ('30-07-2023',235689,14,753);


INSERT INTO VENDEDOR(id_empleado, comision_venta)
VALUES (762,0.20);

INSERT INTO VENDEDOR(id_empleado, comision_venta)
VALUES (753, 0.15);

INSERT INTO VENDEDOR(id_empleado, comision_venta)
VALUES (756, 0.25);

INSERT INTO VENDEDOR(id_empleado, comision_venta)
VALUES (759, 0.13);


INSERT INTO MEDIO_PAGO (id_mpago, nombre_mpago)
VALUES (11,'Efectivo');

INSERT INTO MEDIO_PAGO (id_mpago, nombre_mpago)
VALUES (12, 'Tarjeta Débito');

INSERT INTO MEDIO_PAGO (id_mpago, nombre_mpago)
VALUES (13,'Tarjeta Crédito');

INSERT INTO MEDIO_PAGO (id_mpago, nombre_mpago)
VALUES (14,'Cheque');


INSERT INTO AFP (nom_afp) VALUES ('AFP Habitat');

INSERT INTO AFP (nom_afp) VALUES ('Cuprum');

INSERT INTO AFP (nom_afp) VALUES ('Provida');

INSERT INTO AFP (nom_afp) VALUES ('PlanVital');


INSERT INTO SALUD (id_salud,nom_salud) VALUES (seq_salud.NEXTVAL,'Fonasa');

INSERT INTO SALUD (id_salud,nom_salud) VALUES (seq_salud.NEXTVAL,'Isapre Colmena');

INSERT INTO SALUD (id_salud,nom_salud) VALUES  (seq_salud.NEXTVAL,'Isapre Banmédica');

INSERT INTO SALUD (id_salud,nom_salud) VALUES  (seq_salud.NEXTVAL,'Isapre Cruz Blanca');

SELECT 
    id_empleado AS "Identificador",
    nombre_empleado || ' ' || apellido_paterno  || ' ' || apellido_materno AS "Nombre Completo",
    sueldo_base AS "Salario",
    bono_jefatura AS "Bonificacion",
    (sueldo_base + bono_jefatura) AS "Salario Simulado"
FROM EMPLEADO
WHERE activo= 'S' AND bono_jefatura IS NOT NULL
ORDER BY (sueldo_base + bono_jefatura) DESC,
        apellido_paterno DESC;

SELECT nombre_empleado || ' ' || apellido_paterno  || ' ' || apellido_materno AS "Empleado",
sueldo_base AS "Sueldo",
(sueldo_base * 0.08) AS "Posible aumento",
(sueldo_base + (sueldo_base * 0.08 )) AS "Sueldo simulado"
FROM EMPLEADO
WHERE sueldo_base BETWEEN 550000 AND 800000
ORDER BY sueldo_base ASC;
