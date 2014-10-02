/**********************************************************************
-- Product                   : Oracle Warehouse Builder
-- Generator Version         : 11.2.0.4.0 
-- Created Date              : Thu Oct 02 16:21:33 GMT-03:00 2014
-- Modified Date             : Thu Oct 02 16:21:33 GMT-03:00 2014
-- Created By                : owb11204_idesa
-- Modified By               : owb11204_idesa
-- Generated Object Type     : EXTERNAL TABLE
-- Generated Object Name     : EXT_USUARIO_DISPOSITIVO_PAGO
-- Comments                  : 
-- Copyright (c) 2000, 2014, Oracle. Todos los Derechos Reservados.
**********************************************************************/


WHENEVER SQLERROR EXIT FAILURE;


CREATE TABLE "EXT_USUARIO_DISPOSITIVO_PAGO"
(
"VALOR_DE_TIPO" VARCHAR2(1),
"ID_CLIENTE" NUMBER(10),
"ID_PAGO" NUMBER(10),
"ID_USUARIO_DISPOSITIVO" NUMBER(10)
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY EXTERNAL_TABLES
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    CHARACTERSET WE8MSWIN1252
    STRING SIZES ARE IN BYTES
    LOAD WHEN (
      ("VALOR_DE_TIPO"='D')
    )
    NOBADFILE
    NODISCARDFILE
    NOLOGFILE
    FIELDS
      TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"' AND '"'
      NOTRIM
      (
        "VALOR_DE_TIPO" CHAR,
        "ID_CLIENTE" CHAR,
        "ID_PAGO" CHAR,
        "ID_USUARIO_DISPOSITIVO" CHAR
      )
    )
  LOCATION (
      'USUARIO_DISPOSITIVO_PAGO.txt'
  )
)
REJECT LIMIT UNLIMITED
NOPARALLEL
;

