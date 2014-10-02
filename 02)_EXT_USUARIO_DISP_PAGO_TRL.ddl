/**********************************************************************
-- Product                   : Oracle Warehouse Builder
-- Generator Version         : 11.2.0.4.0 
-- Created Date              : Thu Oct 02 16:23:32 GMT-03:00 2014
-- Modified Date             : Thu Oct 02 16:23:32 GMT-03:00 2014
-- Created By                : owb11204_idesa
-- Modified By               : owb11204_idesa
-- Generated Object Type     : EXTERNAL TABLE
-- Generated Object Name     : EXT_USUARIO_DISP_PAGO_TRL
-- Comments                  : 
-- Copyright (c) 2000, 2014, Oracle. Todos los Derechos Reservados.
**********************************************************************/


WHENEVER SQLERROR EXIT FAILURE;


CREATE TABLE "EXT_USUARIO_DISP_PAGO_TRL"
(
"VALOR_DE_TIPO" VARCHAR2(1),
"COD_FECHA_DIARIO" VARCHAR2(8),
"COD_FECHA" VARCHAR2(8),
"CANT_FILAS" VARCHAR2(7),
"TABLENAME" VARCHAR2(30)
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY EXTERNAL_TABLES
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    CHARACTERSET WE8MSWIN1252
    STRING SIZES ARE IN BYTES
    LOAD WHEN (
      ("VALOR_DE_TIPO"='T')
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
        "COD_FECHA_DIARIO" CHAR,
        "COD_FECHA" CHAR,
        "CANT_FILAS" CHAR,
        "TABLENAME" CHAR
      )
    )
  LOCATION (
      'USUARIO_DISPOSITIVO_PAGO.txt'
  )
)
REJECT LIMIT UNLIMITED
NOPARALLEL
;

