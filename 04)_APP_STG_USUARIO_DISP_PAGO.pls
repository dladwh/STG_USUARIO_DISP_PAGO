
/*****************************************************************************
--  Oracle Warehouse Builder
--  Generator Version           : 11.2.0.4.0
--  Minimum Runtime Repository
--   Version Required           : 11.2.0.4.0
--  Created Date                : Thu Oct 02 16:39:59 GMT-03:00 2014
--  Modified Date               : Thu Oct 02 16:39:59 GMT-03:00 2014
--  Created By                  : owb11204_idesa
--  Modified By                 : owb11204_idesa
--  Generated Object Type       : PL/SQL Package
--  Generated Object Name       : "APP_STG_USUARIO_DISP_PAGO"
--  Comments                    : 
*****************************************************************************/
--  Copyright (c) 2000, 2011, Oracle. Todos los Derechos Reservados.


WHENEVER SQLERROR EXIT FAILURE;

-- Create table OWB$TEMP_TABLES to store names of temp stage tables deployed with map packages,
-- if it does not already exist
BEGIN
  EXECUTE IMMEDIATE 'SELECT TABLE_NAME FROM OWB$TEMP_TABLES WHERE ROWNUM = 1';
  -- The OWB system table exists, now attempt to drop any previously deployed temp tables associated with this package
  DECLARE
  TYPE StageTableCur_T IS REF CURSOR;
  c1 StageTableCur_T;
  sql_stmt VARCHAR2(200);
  l_TableName VARCHAR2(32);
BEGIN
  -- Drop previously deployed temp tables associated with this map, if any
  sql_stmt := 'SELECT TABLE_NAME FROM OWB$TEMP_TABLES WHERE PACKAGE_NAME = ''APP_STG_USUARIO_DISP_PAGO''';
  OPEN c1 FOR sql_stmt;
  LOOP
    FETCH c1 INTO l_TableName;
    EXIT WHEN c1%NOTFOUND;
    -- process record
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE ' || l_TableName;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
    END;
  END LOOP;
  CLOSE c1;
  EXECUTE IMMEDIATE 'DELETE FROM OWB$TEMP_TABLES WHERE PACKAGE_NAME = ''APP_STG_USUARIO_DISP_PAGO''';
  COMMIT;
EXCEPTION WHEN OTHERS THEN
  DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;  
EXCEPTION WHEN OTHERS THEN
  BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE OWB$TEMP_TABLES';
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
  END;
  EXECUTE IMMEDIATE 'CREATE TABLE OWB$TEMP_TABLES(PACKAGE_NAME VARCHAR2(32), TABLE_NAME VARCHAR2(32))
';
END;
/
CREATE OR REPLACE PACKAGE "APP_STG_USUARIO_DISP_PAGO"  AS

-- Map Generation Timestamp
get_generation_date      VARCHAR2(100) := 'Thu Oct 02 16:39:59 GMT-03:00 2014';

-- Map runtime identification id
OWB$MAP_OBJECT_ID             VARCHAR2(32) := '';

-- Auditing mode constants
AUDIT_NONE                    CONSTANT BINARY_INTEGER := 0;
AUDIT_STATISTICS              CONSTANT BINARY_INTEGER := 1;
AUDIT_ERROR_DETAILS           CONSTANT BINARY_INTEGER := 2;
AUDIT_COMPLETE                CONSTANT BINARY_INTEGER := 3;

-- Operating mode constants
MODE_SET                      CONSTANT BINARY_INTEGER := 0;
MODE_ROW                      CONSTANT BINARY_INTEGER := 1;
MODE_ROW_TARGET               CONSTANT BINARY_INTEGER := 2;
MODE_SET_FAILOVER_ROW         CONSTANT BINARY_INTEGER := 3;
MODE_SET_FAILOVER_ROW_TARGET  CONSTANT BINARY_INTEGER := 4;

-- Variables for auditing
get_runtime_audit_id          NUMBER(22) := 0;
get_audit_detail_id           NUMBER(22) := 0;
get_audit_detail_type_id      NUMBER(22) := 0;
get_audit_level               BINARY_INTEGER := AUDIT_ERROR_DETAILS;
get_job_audit                 BOOLEAN := TRUE; 
get_cycle_date                CONSTANT DATE := SYSDATE;
get_lob_uoid                  CONSTANT VARCHAR2(40) := '04763AD8785965DFE053B200090A8550';
get_model_name                CONSTANT VARCHAR2(40) := '"APP_STG_USUARIO_DISP_PAGO"';
get_purge_group               VARCHAR2(40) := 'WB';
rowkey_counter                NUMBER(22) := 1;

-- Processing variables
get_selected                  NUMBER(22) := 0;
get_inserted                  NUMBER(22) := 0;
get_updated                   NUMBER(22) := 0;
get_deleted                   NUMBER(22) := 0;
get_merged                    NUMBER(22) := 0;
get_errors                    NUMBER(22) := 0;
get_logical_errors            NUMBER(22) := 0;
get_abort                     BOOLEAN    := FALSE;
get_abort_procedure           BOOLEAN    := FALSE; -- Causes the current procedure to be aborted, but not the entire map
get_trigger_success           BOOLEAN    := TRUE;
get_read_success              BOOLEAN    := TRUE;
get_status                    NUMBER(22) := 0;
get_column_seq                NUMBER(22) := 0;

get_processed                 NUMBER(22) := 0;
get_total_processed_rowcount  NUMBER(22) := 0;
get_chunk_iterator            NUMBER(22) := 0;
get_error_ratio               NUMBER(22) := 0;

get_audit_id                  NUMBER(22) := 0;

get_max_errors                NUMBER(22) := 50;
get_commit_frequency          NUMBER(22) := 1000;
get_operating_mode            BINARY_INTEGER := MODE_SET_FAILOVER_ROW;
get_table_function            BOOLEAN := false;
get_global_names              VARCHAR2(10) := 'FALSE';
check_record_cnt              NUMBER(22) := 0;
sql_stmt                      VARCHAR2(32767);
error_stmt                    VARCHAR2(2000);

-- Variable related to TF opertor
owb_temp_variable1       NUMBER(22);

-- Variables related to AW Load
"AWLOADLOAD_clob" clob;
"AWLOADLOAD_str" Varchar2(1000);

---- Begin Variables related to trickle feed maps
-- Variables related to LCR processing
lcr                           SYS.LCR$_ROW_RECORD := null;
lcr_original                  SYS.LCR$_ROW_RECORD := null;
lcr_old_values                SYS.LCR$_ROW_LIST   := null;
lcr_new_values                SYS.LCR$_ROW_LIST   := null;
lcr_new_old_values            SYS.LCR$_ROW_LIST   := null;

-- Variables related to message_event processing
message_event                 SYS.ANYDATA         := null;

-- Variables related to Chunking and parallel processing

start_range_id                NUMBER;
p_range_id                    NUMBER;
end_range_id                  NUMBER;
start_rowid                   ROWID;
end_rowid                     ROWID; 
chunksize                     PLS_INTEGER := NULL;
chunking_result               VARCHAR2(2000);
-- Variables related to trickle feed auditing and error handling
last_txn_id                   VARCHAR2(22)        := '';
is_session_initialized        BOOLEAN             := false;
last_error_number             NUMBER;
last_error_message            VARCHAR2(2000);
---- End Variables related to trickle feed maps

-- Special variables for controlling map execution
get_use_hc                    BOOLEAN    := FALSE;
get_no_commit                 BOOLEAN    := FALSE;
get_enable_parallel_dml       BOOLEAN    := FALSE;

TYPE a_table_to_analyze_type IS RECORD (
                                  ownname          VARCHAR2(30),
                                  tabname          VARCHAR2(30),
                                  estimate_percent NUMBER,
                                  granularity      VARCHAR2(10),
                                  cascade          BOOLEAN,
                                  degree           NUMBER);
TYPE tables_to_analyze_type IS TABLE OF a_table_to_analyze_type INDEX BY BINARY_INTEGER;
tables_to_analyze  tables_to_analyze_type;
get_rows_processed            BOOLEAN    := FALSE;

-- Buffer usage variables
TYPE t_get_buffer_done     IS TABLE OF BOOLEAN INDEX BY BINARY_INTEGER;
get_buffer_done            t_get_buffer_done;
get_buffer_done_index      BINARY_INTEGER := 1;

-- Bulk processing variables
get_bulk_size                 NATURAL := 1000;
get_bulk_loop_count           NATURAL := NULL;

-- DML Exceptions
checked_table_not_empty       EXCEPTION;
PRAGMA EXCEPTION_INIT(checked_table_not_empty, -111);
invalid_dml                   EXCEPTION;
PRAGMA EXCEPTION_INIT(invalid_dml, -112);

-- Status variable for Batch cursors
"STG_USUARIO_DISPOSITIVO_PA_St" Boolean;


-- Variables: user-defined variables via mapping Variable components,
--            and package global storage for user-defined mapping input parameters
"FN_TRAILER_CHECK_2_VALUE" BOOLEAN; -- OPERATOR FN_TRAILER_CHECK
"TABLE_NAME" VARCHAR2(32767); -- 
"COD_FECHA_DIARIO" NUMBER; -- 
"COD_FECHA" NUMBER; -- 
"CANT_FILAS" NUMBER; -- 

-- Access functions for user-defined variables via mapping Variable components,
--            and package global storage for user-defined mapping input parameters
-- Access function for OPERATOR FN_TRAILER_CHECK
FUNCTION "get_FN_TRAILER_CHECK_2_VALUE" RETURN BOOLEAN DETERMINISTIC PARALLEL_ENABLE;
FUNCTION "get_FN_TRAILER_CHECK_2_VALUE"(owb$p_value BOOLEAN, owb$p_write NUMBER) RETURN BOOLEAN DETERMINISTIC;
-- Access function for 
FUNCTION "GET_TABLE_NAME" RETURN VARCHAR2 DETERMINISTIC PARALLEL_ENABLE;
FUNCTION "GET_TABLE_NAME"(owb$p_value VARCHAR2, owb$p_write NUMBER) RETURN VARCHAR2 DETERMINISTIC;
-- Access function for 
FUNCTION "GET_COD_FECHA_DIARIO" RETURN NUMBER DETERMINISTIC PARALLEL_ENABLE;
FUNCTION "GET_COD_FECHA_DIARIO"(owb$p_value NUMBER, owb$p_write NUMBER) RETURN NUMBER DETERMINISTIC;
-- Access function for 
FUNCTION "GET_COD_FECHA" RETURN NUMBER DETERMINISTIC PARALLEL_ENABLE;
FUNCTION "GET_COD_FECHA"(owb$p_value NUMBER, owb$p_write NUMBER) RETURN NUMBER DETERMINISTIC;
-- Access function for 
FUNCTION "GET_CANT_FILAS" RETURN NUMBER DETERMINISTIC PARALLEL_ENABLE;
FUNCTION "GET_CANT_FILAS"(owb$p_value NUMBER, owb$p_write NUMBER) RETURN NUMBER DETERMINISTIC;

-- Package global declarations




-- Function Main -- Entry point in package "APP_STG_USUARIO_DISP_PAGO"
--------------------------------------------------
-- Function Main: Should only be called by OWB. --
--------------------------------------------------

FUNCTION Main("TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL, 
p_env IN OWBSYS.WB_RT_MAPAUDIT.WB_RT_NAME_VALUES)  RETURN NUMBER;  

-- Close cursors procedure:
PROCEDURE Close_Cursors;

-------------------------------------------------
-- Procedure Main:                             --
-- 1. An entry point for this map.             --
-- 2. Can be called by OWB user from SQL*Plus  -- 
--    or from user applications.               --
-- 3. This procedure can run even when the     --
--    runtime service is not running.          -- 
-------------------------------------------------
PROCEDURE Main(p_status OUT VARCHAR2,               "TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL, 
               p_max_no_of_errors IN VARCHAR2 DEFAULT NULL,
               p_commit_frequency IN VARCHAR2 DEFAULT NULL,
               p_operating_mode   IN VARCHAR2 DEFAULT NULL,
               p_bulk_size        IN VARCHAR2 DEFAULT NULL,
               p_audit_level      IN VARCHAR2 DEFAULT NULL,
               p_purge_group      IN VARCHAR2 DEFAULT NULL,
               p_job_audit        IN VARCHAR2 DEFAULT 'TRUE')
;







END "APP_STG_USUARIO_DISP_PAGO";


/

CREATE OR REPLACE PACKAGE BODY "APP_STG_USUARIO_DISP_PAGO" AS

-- Define cursors here so that they have global scope within the package (for debugger)

---------------------------------------------------------------------------
--
-- "EXT_USUARIO_DISPOSITIVO_PAGO_c" Cursor declaration 
--
---------------------------------------------------------------------------
CURSOR "EXT_USUARIO_DISPOSITIVO_PAGO_c" IS
 SELECT
/* EXT_USUARIO_DISPOSITIVO_PAGO.OUTGRP1 */
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_CLIENTE" "ID_CLIENTE",
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_PAGO" "ID_PAGO",
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_USUARIO_DISPOSITIVO" "ID_USUARIO_DISPOSITIVO"
FROM
  "EXT_USUARIO_DISPOSITIVO_PAGO"  "EXT_USUARIO_DISPOSITIVO_PAGO"; 

---------------------------------------------------------------------------
--
-- "EXT_USUARIO_DISPOSITIVO_PA_c$1" Cursor declaration 
--
---------------------------------------------------------------------------
CURSOR "EXT_USUARIO_DISPOSITIVO_PA_c$1" IS
 SELECT
/* EXT_USUARIO_DISPOSITIVO_PAGO.OUTGRP1 */
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_CLIENTE" "ID_CLIENTE",
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_PAGO" "ID_PAGO",
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_USUARIO_DISPOSITIVO" "ID_USUARIO_DISPOSITIVO"
FROM
  "EXT_USUARIO_DISPOSITIVO_PAGO"  "EXT_USUARIO_DISPOSITIVO_PAGO"; 


"STG_USUARIO_DISPOS_tt_sqlcode"  NUMBER := NULL;
"STG_USUARIO_DISPOS_tt_sqlerrm"  VARCHAR2(2000) := NULL;

a_table_to_analyze a_table_to_analyze_type;


PROCEDURE EXEC_AUTONOMOUS_SQL(CMD IN VARCHAR2) IS
  PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
  EXECUTE IMMEDIATE (CMD);
  COMMIT;
END;

-- Access functions for user-defined variables via mapping Variable components,
--            and package global storage for user-defined mapping input parameters
-- Access function for OPERATOR FN_TRAILER_CHECK
FUNCTION "get_FN_TRAILER_CHECK_2_VALUE" RETURN BOOLEAN IS
BEGIN
  RETURN "FN_TRAILER_CHECK_2_VALUE";
END "get_FN_TRAILER_CHECK_2_VALUE";
FUNCTION "get_FN_TRAILER_CHECK_2_VALUE"(owb$p_value BOOLEAN, owb$p_write NUMBER) RETURN BOOLEAN IS
BEGIN
  IF (owb$p_write IS NOT NULL AND owb$p_write = 1) THEN
    "FN_TRAILER_CHECK_2_VALUE" := owb$p_value;
  END IF;   
  RETURN "FN_TRAILER_CHECK_2_VALUE";
END "get_FN_TRAILER_CHECK_2_VALUE";
-- Access function for 
FUNCTION "GET_TABLE_NAME" RETURN VARCHAR2 IS
BEGIN
  RETURN "TABLE_NAME";
END "GET_TABLE_NAME";
FUNCTION "GET_TABLE_NAME"(owb$p_value VARCHAR2, owb$p_write NUMBER) RETURN VARCHAR2 IS
BEGIN
  IF (owb$p_write IS NOT NULL AND owb$p_write = 1) THEN
    "TABLE_NAME" := owb$p_value;
  END IF;   
  RETURN "TABLE_NAME";
END "GET_TABLE_NAME";
-- Access function for 
FUNCTION "GET_COD_FECHA_DIARIO" RETURN NUMBER IS
BEGIN
  RETURN "COD_FECHA_DIARIO";
END "GET_COD_FECHA_DIARIO";
FUNCTION "GET_COD_FECHA_DIARIO"(owb$p_value NUMBER, owb$p_write NUMBER) RETURN NUMBER IS
BEGIN
  IF (owb$p_write IS NOT NULL AND owb$p_write = 1) THEN
    "COD_FECHA_DIARIO" := owb$p_value;
  END IF;   
  RETURN "COD_FECHA_DIARIO";
END "GET_COD_FECHA_DIARIO";
-- Access function for 
FUNCTION "GET_COD_FECHA" RETURN NUMBER IS
BEGIN
  RETURN "COD_FECHA";
END "GET_COD_FECHA";
FUNCTION "GET_COD_FECHA"(owb$p_value NUMBER, owb$p_write NUMBER) RETURN NUMBER IS
BEGIN
  IF (owb$p_write IS NOT NULL AND owb$p_write = 1) THEN
    "COD_FECHA" := owb$p_value;
  END IF;   
  RETURN "COD_FECHA";
END "GET_COD_FECHA";
-- Access function for 
FUNCTION "GET_CANT_FILAS" RETURN NUMBER IS
BEGIN
  RETURN "CANT_FILAS";
END "GET_CANT_FILAS";
FUNCTION "GET_CANT_FILAS"(owb$p_value NUMBER, owb$p_write NUMBER) RETURN NUMBER IS
BEGIN
  IF (owb$p_write IS NOT NULL AND owb$p_write = 1) THEN
    "CANT_FILAS" := owb$p_value;
  END IF;   
  RETURN "CANT_FILAS";
END "GET_CANT_FILAS";



---------------------------------------------------------------------------
-- Function "STG_USUARIO_DISPOSITIVO_PA_Bat"
--   performs batch extraction
--   Returns TRUE on success
--   Returns FALSE on failure
---------------------------------------------------------------------------
FUNCTION "STG_USUARIO_DISPOSITIVO_PA_Bat"
("TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL) 
 RETURN BOOLEAN IS
 batch_selected        NUMBER(22) := 0;
 batch_errors          NUMBER(22) := 0;
 batch_inserted        NUMBER(22) := 0;
  batch_deleted         NUMBER(22) := 0;
  batch_merged          NUMBER(22) := 0;
  batch_action          VARCHAR2(20);
  actual_owner          VARCHAR2(30);
  actual_name           VARCHAR2(30);
  num_fk_err            NUMBER(22);
  l_rowkey              NUMBER(22) := 0;
  l_table               VARCHAR2(30) := 'CREATE';
  l_rowid               ROWID;
  l_owner               VARCHAR2(30);
  l_tablename           VARCHAR2(30);
  l_constraint          VARCHAR2(30);
  sql_excp_stmt         VARCHAR2(32767);
  batch_exception       BOOLEAN := FALSE;
  get_map_num_rows      NUMBER(22) := 0;
  TYPE exceptionsCurType IS REF CURSOR;
  exceptions_cursor     exceptionsCurType;
  batch_auditd_id       NUMBER(22) := 0;

BEGIN
  IF get_abort THEN
    RETURN FALSE;
  END IF;
  get_abort_procedure := FALSE;
          IF NOT (get_audit_level = AUDIT_NONE) THEN
    batch_auditd_id := OWBSYS.WB_RT_MAPAUDIT.auditd_begin(  -- Template BatchAuditDetailBegin
      p_rta=>get_runtime_audit_id,
      p_step=>0,
      p_name=>'"STG_USUARIO_DISPOSITIVO_PA_Bat"',
      p_source=>'*',
      p_source_uoid=>'*',
      p_target=>'"STG_USUARIO_DISPOSITIVO_PAGO"',
      p_target_uoid=>'04763AD8782C65DFE053B200090A8550',
      p_stm=>NULL,p_info=>NULL,
      
      p_exec_mode=>MODE_SET
    );
    get_audit_detail_id := batch_auditd_id;
  	get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
    p_rtd=>get_audit_detail_id,
    p_parent_operator_uoid=>'04763AD8793965DFE053B200090A8550', -- Operator STG_USUARIO_DISPOSITIVO_PAGO
    p_parent_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
    p_parent_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
    p_parent_object_type=>'Tabla',
    p_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
    p_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
    p_object_type=>'Tabla',
    p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- DW_STG_LOCATION1
  );
    	get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
    p_rtd=>get_audit_detail_id,
    p_parent_operator_uoid=>'04763AD8784065DFE053B200090A8550', -- Operator EXT_USUARIO_DISPOSITIVO_PAGO
    p_parent_object_name=>'EXT_USUARIO_DISPOSITIVO_PAGO',
    p_parent_object_uoid=>'04763AD877DC65DFE053B200090A8550', -- Tabla Externa EXT_USUARIO_DISPOSITIVO_PAGO
    p_parent_object_type=>'Tabla Externa',
    p_object_name=>'EXT_USUARIO_DISPOSITIVO_PAGO',
    p_object_uoid=>'04763AD877DC65DFE053B200090A8550', -- Tabla Externa EXT_USUARIO_DISPOSITIVO_PAGO
    p_object_type=>'Tabla Externa',
    p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- Location DW_STG_LOCATION1
  );
    	get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
    p_rtd=>get_audit_detail_id,
    p_parent_operator_uoid=>'04763AD8782C65DFE053B200090A8550', -- Operator STG_USUARIO_DISPOSITIVO_PAGO
    p_parent_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
    p_parent_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
    p_parent_object_type=>'Tabla',
    p_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
    p_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
    p_object_type=>'Tabla',
    p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- Location DW_STG_LOCATION1
  );
    
  END IF;
  IF NOT get_use_hc AND NOT get_no_commit THEN
    COMMIT; -- commit no.26
  END IF;
        
  IF NOT get_use_hc AND NOT get_no_commit THEN
    IF get_enable_parallel_dml THEN
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    ELSE
      EXECUTE IMMEDIATE 'ALTER SESSION DISABLE PARALLEL DML';
    END IF;
  END IF;

  BEGIN
  
    IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" THEN
      IF get_use_hc THEN
        IF "STG_USUARIO_DISPOS_tt_sqlcode" IS NOT NULL THEN
          RAISE_APPLICATION_ERROR(-20016, "STG_USUARIO_DISPOS_tt_sqlerrm");
        END IF;
      ELSE
        -- Truncate the target table
        EXECUTE IMMEDIATE 'TRUNCATE TABLE "STG_USUARIO_DISPOSITIVO_PAGO"';
      END IF;
    END IF;
    
  
    IF NOT get_use_hc AND NOT get_no_commit THEN
      COMMIT; -- commit no.4
    END IF;
  
    IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" THEN
    
      batch_action := 'BATCH INSERT';
      batch_selected := SQL%ROWCOUNT;
      
      INSERT
      INTO
        "STG_USUARIO_DISPOSITIVO_PAGO"  "STG_USUARIO_DISPOSITIVO_PAGO"
        ("ID_CLIENTE",
        "COD_PAGO",
        "COD_USUARIO_DISPOSITIVO",
        "COD_FECHA_DIARIO",
        "COD_FECHA")
        (SELECT
/* EXT_USUARIO_DISPOSITIVO_PAGO.OUTGRP1 */
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_CLIENTE" "ID_CLIENTE",
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_PAGO" "ID_PAGO",
  "EXT_USUARIO_DISPOSITIVO_PAGO"."ID_USUARIO_DISPOSITIVO" "ID_USUARIO_DISPOSITIVO",
  "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */ "COD_FECHA_DIARIO$1",
  "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */ "COD_FECHA$1"
FROM
  "EXT_USUARIO_DISPOSITIVO_PAGO"  "EXT_USUARIO_DISPOSITIVO_PAGO"
        )
      ;

      batch_inserted := SQL%ROWCOUNT;
      batch_selected := SQL%ROWCOUNT;
      get_total_processed_rowcount := get_total_processed_rowcount + batch_inserted;

      
      IF get_errors + batch_errors > get_max_errors THEN
        get_abort := TRUE;
      END IF;
      IF NOT get_use_hc AND NOT get_no_commit THEN
        COMMIT; -- commit no.5
      END IF;
    END IF;
  
  EXCEPTION WHEN OTHERS THEN
      last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
          
    IF NOT get_no_commit THEN
      ROLLBACK;
    END IF;
    batch_errors := batch_errors + 1;
    IF get_errors + batch_errors > get_max_errors THEN
      get_abort := TRUE;
    END IF;
    IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
      OWBSYS.WB_RT_MAPAUDIT.error(
        p_rta=>get_runtime_audit_id,
        p_step=>0,
        p_rtd=>batch_auditd_id,
        p_rowkey=>0,
        p_table=>'"STG_USUARIO_DISPOSITIVO_PAGO"',
        p_column=>'*',
        p_dstval=>NULL,
        p_stm=>'TRACE 15: ' || batch_action,
        p_sqlerr=>SQLCODE,
        p_sqlerrm=>SQLERRM,
        p_rowid=>NULL
      );
    END IF;
    get_errors := get_errors + batch_errors;
    get_selected := get_selected + batch_selected;
    
  
      IF NOT (get_audit_level = AUDIT_NONE) THEN
        OWBSYS.WB_RT_MAPAUDIT.auditd_end(
          p_rtd=>batch_auditd_id,
          p_sel=>batch_selected,
          p_ins=>NULL,
          p_upd=>NULL,
          p_del=>NULL,
          p_err=>batch_errors,
          p_dis=>NULL,  -- BatchErrorAuditDetailEnd
          p_mer=>NULL
        );
      END IF;
    IF NOT get_no_commit THEN
      COMMIT; -- commit no.6
    END IF;
    batch_exception := TRUE;
  END;
  
  IF batch_exception THEN
    RETURN FALSE;
  END IF;
        get_deleted := get_deleted + batch_deleted;
  get_inserted := get_inserted + batch_inserted;
  get_errors := get_errors + batch_errors;
  get_selected := get_selected + batch_selected;
  get_merged := get_merged + batch_merged;
  
          IF NOT (get_audit_level = AUDIT_NONE) THEN
    OWBSYS.WB_RT_MAPAUDIT.auditd_end(
      p_rtd=>batch_auditd_id,
      p_sel=>batch_selected,
      p_ins=>batch_inserted,
      p_upd=>NULL,
      p_del=>batch_deleted,
      p_err=>batch_errors,
      p_dis=>NULL,
      p_mer=>batch_merged, -- BatchAuditDetailEnd
      p_autotrans=>(NOT get_use_hc) 
    );
  END IF;
        
  IF NOT get_use_hc AND NOT get_no_commit THEN
    COMMIT; -- commit no.3
  END IF;
  RETURN TRUE;
END "STG_USUARIO_DISPOSITIVO_PA_Bat";



-- Procedure "EXT_USUARIO_DISPOSITIVO_PAGO_p" is the entry point for map "EXT_USUARIO_DISPOSITIVO_PAGO_p"

PROCEDURE "EXT_USUARIO_DISPOSITIVO_PAGO_p"
("TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL) IS
-- Constants for this map
get_map_name               CONSTANT VARCHAR2(40) := '"EXT_USUARIO_DISPOSITIVO_PAGO_p"';
get_source_name            CONSTANT VARCHAR2(2000) := SUBSTRB('"EXT_USUARIO_DISPOSITIVO_PAGO"',0,2000);
get_source_uoid            CONSTANT VARCHAR2(2000) := SUBSTRB('04763AD8784065DFE053B200090A8550',0,2000);
get_step_number            CONSTANT NUMBER(22) := 1;

cursor_exhausted           BOOLEAN := FALSE;
get_close_cursor           BOOLEAN := TRUE;
exit_loop_normal           BOOLEAN := FALSE;
exit_loop_early            BOOLEAN := FALSE;
loop_count                 NUMBER(22);

get_map_selected           NUMBER(22) := 0;
get_map_errors             NUMBER(22) := 0;
get_map_num_rows           NUMBER(22) := 0;
actual_owner               VARCHAR2(30);
actual_name                VARCHAR2(30);

-- Constraint management
num_fk_err                 NUMBER(22);
l_rowkey                   NUMBER(22) := 0;
l_table                    VARCHAR2(30) := 'CREATE';
l_rowid                    ROWID;
l_owner                    VARCHAR2(30);
l_tablename                VARCHAR2(30);
l_constraint               VARCHAR2(30);
l_exec_mode                BINARY_INTEGER := MODE_ROW;
sql_excp_stmt              VARCHAR2(32767);
TYPE exceptionsCurType IS REF CURSOR;
exceptions_cursor          exceptionsCurType;

normal_action              VARCHAR2(20);
extended_action            VARCHAR2(2000);
error_action               VARCHAR2(20);
-- The get_audit_detail_id variable has been moved to a package-level variable
-- get_audit_detail_id        NUMBER(22) := 0;
get_target_name            VARCHAR2(80);
error_column               VARCHAR2(80);
error_value                VARCHAR2(2000);
error_rowkey               NUMBER(22) := 0;

-- Scalar variables for auditing

"STG_USUARIO_DISPOSITIVO_PA_id" NUMBER(22) := 0;
"STG_USUARIO_DISPOSITIVO_PA_ins" NUMBER(22) := 0;
"STG_USUARIO_DISPOSITIVO_PA_upd" NUMBER(22) := 0;
"STG_USUARIO_DISPOSITIVO_PA_del" NUMBER(22) := 0;
"STG_USUARIO_DISPOSITIVO_PA_err" NUMBER(22) := 0;
-- Variables for auditing in bulk processing
one_rowkey            NUMBER(22) := 0;
get_rowkey            NUMBER(22) := 0;
get_rowkey_bulk       OWBSYS.WB_RT_MAPAUDIT.NUMBERLIST;
one_rowid             ROWID;
get_rowid             OWBSYS.WB_RT_MAPAUDIT.ROWIDLIST;
rowkey_bulk_index     NUMBER(22) := 0;
x_it_err_count        NUMBER(22) := 0;
get_rowkey_error      NUMBER(22) := 0;

"STG_USUARIO_DISPOSITIVO_PA_srk" OWBSYS.WB_RT_MAPAUDIT.NUMBERLIST;

-- Helper variables for implementing the correlated commit mechanism
TYPE index_redirect_array IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

"STG_USUARIO_DISPOSITIVO_PA_ir"  index_redirect_array;
"SV_STG_USUARIO_DISPOSITIV_srk" NUMBER;
"STG_USUARIO_DISPOSITIVO_PA_new"  BOOLEAN;
"STG_USUARIO_DISPOSITIVO_PA_nul"  BOOLEAN := FALSE;

-- Bulk processing
error_index                NUMBER(22);
update_bulk                OWBSYS.WB_RT_MAPAUDIT.NUMBERLIST;
update_bulk_index          NUMBER(22) := 0;
insert_bulk_index          NUMBER(22) := 0;
last_successful_index      NUMBER(22) := 0;
feedback_bulk_limit        NUMBER(22) := 0;
bulk_commit_count          NUMBER(22) := 0;
bulk_commit                BOOLEAN := FALSE;
get_row_status             BOOLEAN; 
dml_bsize                  NUMBER; 
row_count                  NUMBER(22);
bulk_count                 NUMBER(22);

"EXT_USUARIO_DISPOSITIVO_PA_si" NUMBER(22) := 0;

"EXT_USUARIO_DISPOSITIVO_PAGO_i" NUMBER(22) := 0;


"STG_USUARIO_DISPOSITIVO_PA_si" NUMBER(22) := 0;

"STG_USUARIO_DISPOSITIVO_PAGO_i" NUMBER(22) := 0;




-- Bulk: types for collection variables
TYPE "T_EXT_USUA_1_ID_CLIEN" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_ROWKEY_EXT_USUARIO_DISPOSIT" IS TABLE OF VARCHAR2(18) INDEX BY BINARY_INTEGER;
TYPE "T_EXT_USUA_2_ID_PAGO" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_EXT_USUA_3_ID_USUAR" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_0_ID_CLIEN" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_1_COD_PAGO" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_2_COD_USUA" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_3_COD_FECH" IS TABLE OF NUMBER(8) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_4_COD_FECH" IS TABLE OF NUMBER(8) INDEX BY BINARY_INTEGER;

-- Bulk: intermediate scalar variables
"SV_EXT_USUA_1_ID_CLIEN"  NUMBER(10);
"SV_ROWKEY_EXT_USUARIO_DISPOSIT"  VARCHAR2(18);
"SV_EXT_USUA_2_ID_PAGO"  NUMBER(10);
"SV_EXT_USUA_3_ID_USUAR"  NUMBER(10);
"SV_STG_USUA_0_ID_CLIEN"  NUMBER(10);
"SV_STG_USUA_1_COD_PAGO"  NUMBER(10);
"SV_STG_USUA_2_COD_USUA"  NUMBER(10);
"SV_STG_USUA_3_COD_FECH"  NUMBER(8);
"SV_STG_USUA_4_COD_FECH"  NUMBER(8);

-- Bulk: intermediate collection variables
"EXT_USUA_1_ID_CLIEN" "T_EXT_USUA_1_ID_CLIEN";
"ROWKEY_EXT_USUARIO_DISPOSITIV" "T_ROWKEY_EXT_USUARIO_DISPOSIT";
"EXT_USUA_2_ID_PAGO" "T_EXT_USUA_2_ID_PAGO";
"EXT_USUA_3_ID_USUAR" "T_EXT_USUA_3_ID_USUAR";
"STG_USUA_0_ID_CLIEN" "T_STG_USUA_0_ID_CLIEN";
"STG_USUA_1_COD_PAGO" "T_STG_USUA_1_COD_PAGO";
"STG_USUA_2_COD_USUA" "T_STG_USUA_2_COD_USUA";
"STG_USUA_3_COD_FECH" "T_STG_USUA_3_COD_FECH";
"STG_USUA_4_COD_FECH" "T_STG_USUA_4_COD_FECH";

PROCEDURE Main_ES(p_step_number IN NUMBER, p_rowkey IN NUMBER, p_table IN VARCHAR2, p_col IN VARCHAR2, p_value IN VARCHAR2 default 'VALUE DISABLED') IS
BEGIN
  get_column_seq := get_column_seq + 1;
  OWBSYS.WB_RT_MAPAUDIT.error_source(
    p_rta=>get_runtime_audit_id,
    p_rowkey=>p_rowkey,
    p_seq=>get_column_seq,
    p_instance=>1,
    p_table=>SUBSTR(p_table,0,80),
    p_column=>SUBSTR(p_col,0,80),
    p_value=>SUBSTRB(p_value,0,2000),
    p_step=>p_step_number,
    p_role=>'T'
  );
END;

---------------------------------------------------------------------------
-- This procedure records column values of one erroneous source row
-- into an audit trail table named WB_RT_ERROR_SOURCES.  Each column is
-- recorded by one row in the audit trail.  To collect all source column
-- values corresponding to one erroneous source row, query the audit
-- trail and specify:
--    RTA_IID, uniquely identifies one audited run,
--    RTE_ROWKEY, uniquely identifies a source row within and audited run
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO_PA_ES"(error_index IN NUMBER) IS
BEGIN

  OWBSYS.WB_RT_MAPAUDIT.error_source(
    p_rta=>get_runtime_audit_id,
    p_rowkey=>get_rowkey + error_index - 1,
    p_seq=>1,
    p_instance=>1,
    p_table=>SUBSTR('"EXT_USUARIO_DISPOSITIVO_PAGO"',0,80),
    p_column=>SUBSTR('ID_CLIENTE',0,80),
    p_value=>SUBSTRB("EXT_USUA_1_ID_CLIEN"(error_index),0,2000),
    p_step=>get_step_number,
    p_role=>'S'
    );
  OWBSYS.WB_RT_MAPAUDIT.error_source(
    p_rta=>get_runtime_audit_id,
    p_rowkey=>get_rowkey + error_index - 1,
    p_seq=>2,
    p_instance=>1,
    p_table=>SUBSTR('"EXT_USUARIO_DISPOSITIVO_PAGO"',0,80),
    p_column=>SUBSTR('ID_PAGO',0,80),
    p_value=>SUBSTRB("EXT_USUA_2_ID_PAGO"(error_index),0,2000),
    p_step=>get_step_number,
    p_role=>'S'
    );
  OWBSYS.WB_RT_MAPAUDIT.error_source(
    p_rta=>get_runtime_audit_id,
    p_rowkey=>get_rowkey + error_index - 1,
    p_seq=>3,
    p_instance=>1,
    p_table=>SUBSTR('"EXT_USUARIO_DISPOSITIVO_PAGO"',0,80),
    p_column=>SUBSTR('ID_USUARIO_DISPOSITIVO',0,80),
    p_value=>SUBSTRB("EXT_USUA_3_ID_USUAR"(error_index),0,2000),
    p_step=>get_step_number,
    p_role=>'S'
    );
  RETURN;
    
  END "EXT_USUARIO_DISPOSITIVO_PA_ES";

---------------------------------------------------------------------------
-- Procedure "EXT_USUARIO_DISPOSITIVO_PA_ER" registers error for one erroneous row
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO_PA_ER"(p_statement IN VARCHAR2, p_column IN VARCHAR2, p_col_value IN VARCHAR2, p_sqlcode IN NUMBER, p_sqlerrm IN VARCHAR2, p_auditd_id IN NUMBER, p_error_index IN NUMBER) IS
l_source_target_name VARCHAR2(80);
BEGIN
  IF p_auditd_id IS NULL THEN
    l_source_target_name := SUBSTR(get_source_name,0,80);
  ELSE
    l_source_target_name := get_target_name;
  END IF;

  IF p_error_index = 0 THEN  
  get_rowkey_error := 0;
ELSE  
  get_rowkey_error := get_rowkey + p_error_index - 1;
END IF;

  IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
    OWBSYS.WB_RT_MAPAUDIT.error(
      p_rta=>get_runtime_audit_id,
      p_step=>get_step_number,
      p_rtd=>p_auditd_id,
      p_rowkey=>get_rowkey_error,
      p_table=>l_source_target_name,
      p_column=>p_column,
      p_dstval=>p_col_value,
      p_stm=>'TRACE 16: ' || p_statement,
      p_sqlerr=>p_sqlcode,
      p_sqlerrm=>p_sqlerrm,
      p_rowid=>NULL
    );
  END IF;

  IF ( get_audit_level = AUDIT_COMPLETE ) AND (get_rowkey_error > 0) THEN
    OWBSYS.WB_RT_MAPAUDIT.register_feedback(
      p_rta=>get_runtime_audit_id,
      p_step=>get_step_number,
      p_rowkey=>get_rowkey_error,
      p_status=>'ERROR',
      p_table=>l_source_target_name,
      p_role=>'T',
      p_action=>SUBSTR(p_statement,0,30)
    );
  END IF;

  IF ( get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE ) AND (get_rowkey_error > 0) THEN
    "EXT_USUARIO_DISPOSITIVO_PA_ES"(p_error_index);
  END IF;
END "EXT_USUARIO_DISPOSITIVO_PA_ER";



---------------------------------------------------------------------------
-- Procedure "EXT_USUARIO_DISPOSITIVO_PA_SU" opens and initializes data source
-- for map "EXT_USUARIO_DISPOSITIVO_PAGO_p"
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO_PA_SU" IS
BEGIN
  IF get_abort THEN
    RETURN;
  END IF;
  IF (NOT "EXT_USUARIO_DISPOSITIVO_PAGO_c"%ISOPEN) THEN
    OPEN "EXT_USUARIO_DISPOSITIVO_PAGO_c";
  END IF;
  get_read_success := TRUE;
END "EXT_USUARIO_DISPOSITIVO_PA_SU";

---------------------------------------------------------------------------
-- Procedure "EXT_USUARIO_DISPOSITIVO_PA_RD" fetches a bulk of rows from
--   the data source for map "EXT_USUARIO_DISPOSITIVO_PAGO_p"
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO_PA_RD" IS
BEGIN
  IF NOT get_read_success THEN
    get_abort := TRUE;
    IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
      OWBSYS.WB_RT_MAPAUDIT.error(
        p_rta=>get_runtime_audit_id,
        p_step=>0,
        p_rtd=>NULL,
        p_rowkey=>0,
        p_table=>NULL,
        p_column=>NULL,
        p_dstval=>NULL,
        p_stm=>NULL,
        p_sqlerr=>-20007,
        p_sqlerrm=>'CursorFetchMapTerminationRTV20007',
        p_rowid=>NULL
      );
    END IF;
                END IF;

  IF get_abort OR get_abort_procedure THEN
    RETURN;
  END IF;

  BEGIN
    "EXT_USUA_1_ID_CLIEN".DELETE;
    "EXT_USUA_2_ID_PAGO".DELETE;
    "EXT_USUA_3_ID_USUAR".DELETE;

    FETCH
      "EXT_USUARIO_DISPOSITIVO_PAGO_c"
    BULK COLLECT INTO
      "EXT_USUA_1_ID_CLIEN",
      "EXT_USUA_2_ID_PAGO",
      "EXT_USUA_3_ID_USUAR"
    LIMIT get_bulk_size;

    get_total_processed_rowcount := get_total_processed_rowcount + "EXT_USUA_1_ID_CLIEN".COUNT;

    IF "EXT_USUARIO_DISPOSITIVO_PAGO_c"%NOTFOUND AND "EXT_USUA_1_ID_CLIEN".COUNT = 0 THEN
      RETURN;
    END IF;
    -- register feedback for successful reads
    IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
      get_rowkey := rowkey_counter;
      rowkey_counter := rowkey_counter + "EXT_USUA_1_ID_CLIEN".COUNT;
    END IF;
    
    IF get_audit_level = AUDIT_COMPLETE THEN
      OWBSYS.WB_RT_MAPAUDIT.register_feedback_bulk(
        p_rta=>get_runtime_audit_id,
        p_step=>get_step_number,
        p_rowkey=>get_rowkey,
        p_status=>'NEW',
        p_table=>get_source_name,
        p_role=>'S',
        p_action=>'SELECT'
      );
    END IF;
    get_map_selected := get_map_selected + "EXT_USUA_1_ID_CLIEN".COUNT;
  EXCEPTION
    WHEN OTHERS THEN
        last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
      get_read_success := FALSE;
      -- register error
      IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
        one_rowkey := rowkey_counter;
        rowkey_counter := rowkey_counter + 1;
        OWBSYS.WB_RT_MAPAUDIT.error(
          p_rta=>get_runtime_audit_id,
          p_step=>get_step_number,
          p_rtd=>NULL,
          p_rowkey=>one_rowkey,
          p_table=>get_source_name,
          p_column=>'*',
          p_dstval=>NULL,
          p_stm=>'TRACE 17: SELECT',
          p_sqlerr=>SQLCODE,
          p_sqlerrm=>SQLERRM,
          p_rowid=>NULL
        );
      END IF;
      
      -- register feedback for the erroneous row
      IF get_audit_level = AUDIT_COMPLETE THEN
        OWBSYS.WB_RT_MAPAUDIT.register_feedback(
          p_rta=>get_runtime_audit_id,
          p_step=>get_step_number,
          p_rowkey=>one_rowkey,
          p_status=>'ERROR',
          p_table=>get_source_name,
          p_role=>'S',
          p_action=>'SELECT'
        );
      END IF;
      get_errors := get_errors + 1;
      IF get_errors > get_max_errors THEN get_abort := TRUE; END IF;
  END;
END "EXT_USUARIO_DISPOSITIVO_PA_RD";

---------------------------------------------------------------------------
-- Procedure "EXT_USUARIO_DISPOSITIVO_PA_DML" does DML for a bulk of rows starting from index si.
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO_PA_DML"(si NUMBER, firstround BOOLEAN) IS
 "STG_USUARIO_DISPOSITIVO__ins0" NUMBER := "STG_USUARIO_DISPOSITIVO_PA_ins";
BEGIN
 IF get_use_hc THEN
  IF firstround AND NOT get_row_status THEN
   RETURN;
  END IF;
  get_row_status := TRUE;
 END IF;
 IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" AND (NOT get_use_hc OR get_row_status) 
AND (NOT (get_use_hc AND "STG_USUARIO_DISPOSITIVO_PA_nul")) THEN
  -- Insert DML for "STG_USUARIO_DISPOSITIVO_PAGO"
  normal_action := 'INSERT';
  error_action  := 'INSERT';
  get_target_name := '"STG_USUARIO_DISPOSITIVO_PAGO"';
  get_audit_detail_id := "STG_USUARIO_DISPOSITIVO_PA_id";
  IF get_use_hc AND NOT firstround THEN
    "STG_USUARIO_DISPOSITIVO_PA_si" := "STG_USUARIO_DISPOSITIVO_PA_ir"(si);
    IF "STG_USUARIO_DISPOSITIVO_PA_si" = 0 THEN
      "STG_USUARIO_DISPOSITIVO_PAGO_i" := 0;
    ELSE
      "STG_USUARIO_DISPOSITIVO_PAGO_i" := "STG_USUARIO_DISPOSITIVO_PA_si" + 1;
    END IF;
  ELSE
    "STG_USUARIO_DISPOSITIVO_PA_si" := 1;
  END IF;
  LOOP
    IF NOT get_use_hc THEN
    EXIT WHEN "STG_USUARIO_DISPOSITIVO_PAGO_i" <= get_bulk_size 
 AND "EXT_USUARIO_DISPOSITIVO_PAGO_c"%FOUND AND NOT get_abort;
    ELSE
      EXIT WHEN "STG_USUARIO_DISPOSITIVO_PA_si" >= "STG_USUARIO_DISPOSITIVO_PAGO_i";
    END IF;
    get_rowid.DELETE;

    BEGIN
      FORALL i IN "STG_USUARIO_DISPOSITIVO_PA_si".."STG_USUARIO_DISPOSITIVO_PAGO_i" - 1
        INSERT 
        INTO
          "STG_USUARIO_DISPOSITIVO_PAGO"
          ("STG_USUARIO_DISPOSITIVO_PAGO"."ID_CLIENTE",
          "STG_USUARIO_DISPOSITIVO_PAGO"."COD_PAGO",
          "STG_USUARIO_DISPOSITIVO_PAGO"."COD_USUARIO_DISPOSITIVO",
          "STG_USUARIO_DISPOSITIVO_PAGO"."COD_FECHA_DIARIO",
          "STG_USUARIO_DISPOSITIVO_PAGO"."COD_FECHA"
          )
        VALUES
          ("STG_USUA_0_ID_CLIEN"(i),
          "STG_USUA_1_COD_PAGO"(i),
          "STG_USUA_2_COD_USUA"(i),
          "STG_USUA_3_COD_FECH"(i),
          "STG_USUA_4_COD_FECH"(i)
          )
        RETURNING ROWID BULK COLLECT INTO get_rowid;
      error_index := "STG_USUARIO_DISPOSITIVO_PA_si" + get_rowid.COUNT;
    EXCEPTION
      WHEN OTHERS THEN
          last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
        IF get_use_hc THEN
          get_row_status := FALSE;
          ROLLBACK;
          IF firstround THEN
            EXIT;
          END IF;
        END IF;
        error_index := "STG_USUARIO_DISPOSITIVO_PA_si" + get_rowid.COUNT;
        IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
          error_rowkey := "STG_USUARIO_DISPOSITIVO_PA_srk"(error_index);
          OWBSYS.WB_RT_MAPAUDIT.error(
            p_rta=>get_runtime_audit_id,
            p_step=>get_step_number,
            p_rtd=>get_audit_detail_id,
            p_rowkey=>error_rowkey,
            p_table=>get_target_name,
            p_column=>'*',
            p_dstval=>NULL,
            p_stm=>'TRACE 18: ' || error_action,
            p_sqlerr=>SQLCODE,
            p_sqlerrm=>SQLERRM,
            p_rowid=>NULL
          );
          get_column_seq := 0;
          

          
          
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."ID_CLIENTE"',0,80),SUBSTRB("STG_USUA_0_ID_CLIEN"(error_index),0,2000));
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."COD_PAGO"',0,80),SUBSTRB("STG_USUA_1_COD_PAGO"(error_index),0,2000));
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."COD_USUARIO_DISPOSITIVO"',0,80),SUBSTRB("STG_USUA_2_COD_USUA"(error_index),0,2000));
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."COD_FECHA_DIARIO"',0,80),SUBSTRB("STG_USUA_3_COD_FECH"(error_index),0,2000));
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."COD_FECHA"',0,80),SUBSTRB("STG_USUA_4_COD_FECH"(error_index),0,2000));
          
        END IF;
        IF get_audit_level = AUDIT_COMPLETE THEN
          OWBSYS.WB_RT_MAPAUDIT.register_feedback(
            p_rta=>get_runtime_audit_id,
            p_step=>get_step_number,
            p_rowkey=>error_rowkey,
            p_status=>'ERROR',
            p_table=>get_target_name,
            p_role=>'T',
            p_action=>error_action
          );
        END IF; 
        "STG_USUARIO_DISPOSITIVO_PA_err" := "STG_USUARIO_DISPOSITIVO_PA_err" + 1;
        
        IF get_errors + "STG_USUARIO_DISPOSITIVO_PA_err" > get_max_errors THEN
          get_abort:= TRUE;
        END IF;
    END;
    -- feedback for a bulk of rows
    IF get_audit_level = AUDIT_COMPLETE THEN
      get_rowkey_bulk.DELETE;
      rowkey_bulk_index := 1;
      FOR rowkey_index IN "STG_USUARIO_DISPOSITIVO_PA_si"..error_index - 1 LOOP
        get_rowkey_bulk(rowkey_bulk_index) := "STG_USUARIO_DISPOSITIVO_PA_srk"(rowkey_index);
        rowkey_bulk_index := rowkey_bulk_index + 1;
      END LOOP;
    END IF;
    
IF get_audit_level = AUDIT_COMPLETE THEN
  OWBSYS.WB_RT_MAPAUDIT.register_feedback_bulk(
    p_rta=>get_runtime_audit_id,
    p_step=>get_step_number,
    p_rowkey=>get_rowkey_bulk,
    p_status=>'NEW',
    p_table=>get_target_name,
    p_role=>'T',
    p_action=>normal_action,
    p_rowid=>get_rowid
  );
END IF;

    "STG_USUARIO_DISPOSITIVO_PA_ins" := "STG_USUARIO_DISPOSITIVO_PA_ins" + get_rowid.COUNT;
    "STG_USUARIO_DISPOSITIVO_PA_si" := error_index + 1;

    IF "STG_USUARIO_DISPOSITIVO_PA_si" >= "STG_USUARIO_DISPOSITIVO_PAGO_i" OR get_abort THEN
      "STG_USUARIO_DISPOSITIVO_PAGO_i" := 1;
      EXIT;
    END IF;
  END LOOP;
END IF;
IF get_use_hc THEN
  "STG_USUARIO_DISPOSITIVO_PAGO_i" := 1; 
END IF;


 IF get_use_hc AND NOT firstround THEN
  COMMIT; -- commit no.27
 END IF;
 IF get_use_hc AND NOT get_row_status THEN
 "STG_USUARIO_DISPOSITIVO_PA_ins" := "STG_USUARIO_DISPOSITIVO__ins0";
END IF;

END "EXT_USUARIO_DISPOSITIVO_PA_DML";

---------------------------------------------------------------------------
-- "EXT_USUARIO_DISPOSITIVO_PAGO_p" main
---------------------------------------------------------------------------

BEGIN
  IF get_abort OR get_abort_procedure THEN
    
    RETURN;
  END IF;

  
  IF NOT get_no_commit THEN
  COMMIT;  -- commit no.7
  sql_stmt := 'ALTER SESSION DISABLE PARALLEL DML';
  EXECUTE IMMEDIATE sql_stmt;
END IF;

  IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" THEN
    -- For normal cursor query loop operation, skip map procedure initialization if 
    -- cursor is already open - procedure initialization should only be done the 
    -- first time the procedure is called (since mapping debugger
    -- executes the procedure multiple times and leaves the cursor open). 
    -- For table function (parallel row mode) operation, the cursor will already be
    -- open when the procedure is called, so execute the initialization.
    IF get_table_function OR (NOT "EXT_USUARIO_DISPOSITIVO_PAGO_c"%ISOPEN) THEN
      IF NOT (get_audit_level = AUDIT_NONE) THEN
        IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" THEN
          "STG_USUARIO_DISPOSITIVO_PA_id" :=
            OWBSYS.WB_RT_MAPAUDIT.auditd_begin(  -- Template AuditDetailBegin
              p_rta=>get_runtime_audit_id,
              p_step=>get_step_number,
              p_name=>get_map_name,
              p_source=>get_source_name,
              p_source_uoid=>get_source_uoid,
              p_target=>'"STG_USUARIO_DISPOSITIVO_PAGO"',
              p_target_uoid=>'04763AD8782C65DFE053B200090A8550',
              p_stm=>'TRACE 20',
            	p_info=>NULL,
              p_exec_mode=>l_exec_mode
            );
            get_audit_detail_id := "STG_USUARIO_DISPOSITIVO_PA_id";
              
get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
              p_rtd=>get_audit_detail_id,
              p_parent_operator_uoid=>'04763AD8793965DFE053B200090A8550', -- Operator STG_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
              p_parent_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_type=>'Tabla',
              p_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
              p_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
              p_object_type=>'Tabla',
              p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- DW_STG_LOCATION1
            );  
get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
              p_rtd=>get_audit_detail_id,
              p_parent_operator_uoid=>'04763AD8784065DFE053B200090A8550', -- Operator EXT_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_name=>'EXT_USUARIO_DISPOSITIVO_PAGO',
              p_parent_object_uoid=>'04763AD877DC65DFE053B200090A8550', -- Tabla Externa EXT_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_type=>'Tabla Externa',
              p_object_name=>'EXT_USUARIO_DISPOSITIVO_PAGO',
              p_object_uoid=>'04763AD877DC65DFE053B200090A8550', -- Tabla Externa EXT_USUARIO_DISPOSITIVO_PAGO
              p_object_type=>'Tabla Externa',
              p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- Location DW_STG_LOCATION1
            );  
get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
              p_rtd=>get_audit_detail_id,
              p_parent_operator_uoid=>'04763AD8782C65DFE053B200090A8550', -- Operator STG_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
              p_parent_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_type=>'Tabla',
              p_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
              p_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
              p_object_type=>'Tabla',
              p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- Location DW_STG_LOCATION1
            );
        END IF;
        IF NOT get_no_commit THEN
          COMMIT; -- commit no.10
        END IF;
      END IF;

      IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" THEN
  BEGIN
    -- Truncate the target table, if the cursor has not been opened yet.
    -- If the cursor is open, then this is not the first call of this procedure for 
    -- the run, so the target has already been truncated.
    IF NOT "EXT_USUARIO_DISPOSITIVO_PAGO_c"%ISOPEN THEN
      IF get_use_hc THEN
        IF "STG_USUARIO_DISPOS_tt_sqlcode" IS NOT NULL THEN
          RAISE_APPLICATION_ERROR(-20016, "STG_USUARIO_DISPOS_tt_sqlerrm");
        END IF;
      ELSE
        EXECUTE IMMEDIATE 'TRUNCATE TABLE "STG_USUARIO_DISPOSITIVO_PAGO"';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
        last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
            IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
              OWBSYS.WB_RT_MAPAUDIT.error(
                p_rta=>get_runtime_audit_id,
                p_step=>1,
                p_rtd=>"STG_USUARIO_DISPOSITIVO_PA_id",
                p_rowkey=>0,
                p_table=>'"STG_USUARIO_DISPOSITIVO_PAGO"',
                p_column=>'*',
                p_dstval=>NULL,
                p_stm=>'TRACE 21: TRUNCATE',
                p_sqlerr=>SQLCODE,
                p_sqlerrm=>SQLERRM,
                p_rowid=>NULL
              );
            END IF;
      get_abort := TRUE;
  END;
END IF;
      

      -- Initialize buffer variables
      get_buffer_done.DELETE;
      get_buffer_done_index := 1;

    END IF; -- End if cursor not open

    -- Initialize internal loop index variables
    "EXT_USUARIO_DISPOSITIVO_PA_si" := 0;
    "STG_USUARIO_DISPOSITIVO_PAGO_i" := 1;
    get_rows_processed := FALSE;

    IF NOT get_abort AND NOT get_abort_procedure THEN
      "EXT_USUARIO_DISPOSITIVO_PA_SU";

      LOOP
        IF "EXT_USUARIO_DISPOSITIVO_PA_si" = 0 THEN
          "EXT_USUARIO_DISPOSITIVO_PA_RD";   -- Fetch data from source
          IF NOT get_read_success THEN
            bulk_count := "EXT_USUA_1_ID_CLIEN".COUNT - 1;
          ELSE
            bulk_count := "EXT_USUA_1_ID_CLIEN".COUNT;
          END IF;
                                        IF bulk_commit THEN
                                                bulk_commit_count := 0;
                                                bulk_commit := FALSE;
                                        END IF;
                                        bulk_commit_count := bulk_commit_count + bulk_count;

 
          IF get_use_hc THEN
            dml_bsize := 0;
            "STG_USUARIO_DISPOSITIVO_PA_ir".DELETE;
"STG_USUARIO_DISPOSITIVO_PAGO_i" := 1;
          END IF;
        END IF;

        -- Processing:
        "EXT_USUARIO_DISPOSITIVO_PAGO_i" := "EXT_USUARIO_DISPOSITIVO_PA_si";
        BEGIN
          
          LOOP
            EXIT WHEN "STG_USUARIO_DISPOSITIVO_PAGO_i" > get_bulk_size OR get_abort OR get_abort_procedure;

            "EXT_USUARIO_DISPOSITIVO_PAGO_i" := "EXT_USUARIO_DISPOSITIVO_PAGO_i" + 1;
            "EXT_USUARIO_DISPOSITIVO_PA_si" := "EXT_USUARIO_DISPOSITIVO_PAGO_i";
            IF get_use_hc THEN
              get_row_status := TRUE;
                "STG_USUARIO_DISPOSITIVO_PA_new" := FALSE;
            END IF;

            get_buffer_done(get_buffer_done_index) := 
              ("EXT_USUARIO_DISPOSITIVO_PAGO_c"%NOTFOUND AND
               "EXT_USUARIO_DISPOSITIVO_PAGO_i" > bulk_count);

            IF (NOT get_buffer_done(get_buffer_done_index)) AND
              "EXT_USUARIO_DISPOSITIVO_PAGO_i" > bulk_count THEN
            
              "EXT_USUARIO_DISPOSITIVO_PA_si" := 0;
              EXIT;
            END IF;


            
get_target_name := '"STG_USUARIO_DISPOSITIVO_PAGO"';
            get_audit_detail_id := "STG_USUARIO_DISPOSITIVO_PA_id";
            IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" AND NOT get_buffer_done(get_buffer_done_index) THEN
              BEGIN
                get_rows_processed := true; -- Set to indicate that some row data was processed (for debugger)
            		error_stmt := SUBSTRB('"STG_USUA_0_ID_CLIEN"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "EXT_USUA_1_ID_CLIEN"("EXT_USUARIO_DISPOSITIVO_PAGO_i");',0,2000);
            error_column := SUBSTRB('"STG_USUA_0_ID_CLIEN"',0,80);
            
            BEGIN
              error_value := SUBSTRB("EXT_USUA_1_ID_CLIEN"("EXT_USUARIO_DISPOSITIVO_PAGO_i"),0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_0_ID_CLIEN"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "EXT_USUA_1_ID_CLIEN"("EXT_USUARIO_DISPOSITIVO_PAGO_i");
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_0_ID_CLIEN" :=
            
            "EXT_USUA_1_ID_CLIEN"("EXT_USUARIO_DISPOSITIVO_PAGO_i");
            
            ELSE
              NULL;
            END IF;
            
            		error_stmt := SUBSTRB('"STG_USUA_1_COD_PAGO"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "EXT_USUA_2_ID_PAGO"("EXT_USUARIO_DISPOSITIVO_PAGO_i");',0,2000);
            error_column := SUBSTRB('"STG_USUA_1_COD_PAGO"',0,80);
            
            BEGIN
              error_value := SUBSTRB("EXT_USUA_2_ID_PAGO"("EXT_USUARIO_DISPOSITIVO_PAGO_i"),0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_1_COD_PAGO"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "EXT_USUA_2_ID_PAGO"("EXT_USUARIO_DISPOSITIVO_PAGO_i");
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_1_COD_PAGO" :=
            
            "EXT_USUA_2_ID_PAGO"("EXT_USUARIO_DISPOSITIVO_PAGO_i");
            
            ELSE
              NULL;
            END IF;
            
            		error_stmt := SUBSTRB('"STG_USUA_2_COD_USUA"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "EXT_USUA_3_ID_USUAR"("EXT_USUARIO_DISPOSITIVO_PAGO_i");',0,2000);
            error_column := SUBSTRB('"STG_USUA_2_COD_USUA"',0,80);
            
            BEGIN
              error_value := SUBSTRB("EXT_USUA_3_ID_USUAR"("EXT_USUARIO_DISPOSITIVO_PAGO_i"),0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_2_COD_USUA"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "EXT_USUA_3_ID_USUAR"("EXT_USUARIO_DISPOSITIVO_PAGO_i");
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_2_COD_USUA" :=
            
            "EXT_USUA_3_ID_USUAR"("EXT_USUARIO_DISPOSITIVO_PAGO_i");
            
            ELSE
              NULL;
            END IF;
            
            		error_stmt := SUBSTRB('"STG_USUA_3_COD_FECH"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */;',0,2000);
            error_column := SUBSTRB('"STG_USUA_3_COD_FECH"',0,80);
            
            BEGIN
              error_value := SUBSTRB("APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */,0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_3_COD_FECH"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */;
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_3_COD_FECH" :=
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */;
            
            ELSE
              NULL;
            END IF;
            
            		error_stmt := SUBSTRB('"STG_USUA_4_COD_FECH"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */;',0,2000);
            error_column := SUBSTRB('"STG_USUA_4_COD_FECH"',0,80);
            
            BEGIN
              error_value := SUBSTRB("APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */,0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_4_COD_FECH"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */;
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_4_COD_FECH" :=
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */;
            
            ELSE
              NULL;
            END IF;
            
            
            
                IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
                  IF NOT get_use_hc THEN
                    "STG_USUARIO_DISPOSITIVO_PA_srk"("STG_USUARIO_DISPOSITIVO_PAGO_i") := get_rowkey + "EXT_USUARIO_DISPOSITIVO_PAGO_i" - 1;
                  ELSIF get_row_status THEN
                    "SV_STG_USUARIO_DISPOSITIV_srk" := get_rowkey + "EXT_USUARIO_DISPOSITIVO_PAGO_i" - 1;
                  ELSE
                    NULL;
                  END IF;
                  END IF;
                  IF get_use_hc THEN
                  "STG_USUARIO_DISPOSITIVO_PA_new" := TRUE;
                ELSE
                  "STG_USUARIO_DISPOSITIVO_PAGO_i" := "STG_USUARIO_DISPOSITIVO_PAGO_i" + 1;
                END IF;
              EXCEPTION
                WHEN OTHERS THEN
                    last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
             
                  "EXT_USUARIO_DISPOSITIVO_PA_ER"('TRACE 22: ' || error_stmt, error_column, error_value, SQLCODE, SQLERRM, get_audit_detail_id, "EXT_USUARIO_DISPOSITIVO_PAGO_i");
                  
                  "STG_USUARIO_DISPOSITIVO_PA_err" := "STG_USUARIO_DISPOSITIVO_PA_err" + 1;
                  
                  IF get_errors + "STG_USUARIO_DISPOSITIVO_PA_err" > get_max_errors THEN
                    get_abort:= TRUE;
                  END IF;
                  get_row_status := FALSE; 
              END;
            END IF;
            
            
            
              
            
             EXIT WHEN get_buffer_done(get_buffer_done_index);

            IF get_use_hc AND get_row_status AND ("STG_USUARIO_DISPOSITIVO_PA_new") THEN
              dml_bsize := dml_bsize + 1;
            	IF "STG_USUARIO_DISPOSITIVO_PA_new" 
            AND (NOT "STG_USUARIO_DISPOSITIVO_PA_nul") THEN
              "STG_USUARIO_DISPOSITIVO_PA_ir"(dml_bsize) := "STG_USUARIO_DISPOSITIVO_PAGO_i";
            	"STG_USUA_0_ID_CLIEN"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_0_ID_CLIEN";
            	"STG_USUA_1_COD_PAGO"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_1_COD_PAGO";
            	"STG_USUA_2_COD_USUA"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_2_COD_USUA";
            	"STG_USUA_3_COD_FECH"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_3_COD_FECH";
            	"STG_USUA_4_COD_FECH"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_4_COD_FECH";
              "STG_USUARIO_DISPOSITIVO_PA_srk"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUARIO_DISPOSITIV_srk";
              "STG_USUARIO_DISPOSITIVO_PAGO_i" := "STG_USUARIO_DISPOSITIVO_PAGO_i" + 1;
            ELSE
              "STG_USUARIO_DISPOSITIVO_PA_ir"(dml_bsize) := 0;
            END IF;
            END IF;
            
          END LOOP;

          "EXT_USUARIO_DISPOSITIVO_PA_DML"(1, TRUE);
          IF get_use_hc THEN
            IF NOT get_row_status THEN
              FOR start_index IN 1..dml_bsize LOOP
                "EXT_USUARIO_DISPOSITIVO_PA_DML"(start_index, FALSE);
              END LOOP;
            ELSE
              COMMIT;
            END IF;
          END IF;
          
        EXCEPTION
          WHEN OTHERS THEN
              last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
            "EXT_USUARIO_DISPOSITIVO_PA_ER"('TRACE 19: ' || error_stmt, '*', NULL, SQLCODE, SQLERRM, NULL, "EXT_USUARIO_DISPOSITIVO_PAGO_i");
            get_errors := get_errors + 1;
            IF get_errors > get_max_errors THEN  
  get_abort := TRUE;
END IF;
            
        END;
        
  IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" AND bulk_commit_count > get_commit_frequency THEN
            IF NOT (get_audit_level = AUDIT_NONE) THEN
              OWBSYS.WB_RT_MAPAUDIT.auditd_progress(
                p_rtd=>"STG_USUARIO_DISPOSITIVO_PA_id",
                p_sel=>get_map_selected,
                p_ins=>"STG_USUARIO_DISPOSITIVO_PA_ins",
                p_upd=>"STG_USUARIO_DISPOSITIVO_PA_upd",
                p_del=>"STG_USUARIO_DISPOSITIVO_PA_del",
                p_err=>"STG_USUARIO_DISPOSITIVO_PA_err",
                p_dis=>NULL
              );
            END IF;
            IF NOT get_no_commit THEN
              COMMIT; -- commit no.25
              bulk_commit := TRUE;
            END IF;
          END IF;


        cursor_exhausted := "EXT_USUARIO_DISPOSITIVO_PAGO_c"%NOTFOUND;
        exit_loop_normal := get_abort OR get_abort_procedure OR (cursor_exhausted AND "EXT_USUARIO_DISPOSITIVO_PAGO_i" > bulk_count);
        exit_loop_early := get_rows_processed AND get_bulk_loop_count IS NOT NULL AND "EXT_USUARIO_DISPOSITIVO_PAGO_i" >= get_bulk_loop_count;
        get_close_cursor := get_abort OR get_abort_procedure OR cursor_exhausted;
        EXIT WHEN exit_loop_normal OR exit_loop_early;

      END LOOP;
    END IF;
    IF NOT get_no_commit THEN
      COMMIT; -- commit no.11
    END IF;
    BEGIN
      IF get_close_cursor THEN
        CLOSE "EXT_USUARIO_DISPOSITIVO_PAGO_c";
      END IF;
    EXCEPTION WHEN OTHERS THEN
      NULL;
      END;
    -- Do post processing only after procedure has been called for the last time and the cursor is closing
    IF get_close_cursor THEN
      
      NULL;
    END IF; -- If get_close_cursor
  END IF;
  
  IF NOT "STG_USUARIO_DISPOSITIVO_PA_St"
    AND NOT (get_audit_level = AUDIT_NONE) THEN
      OWBSYS.WB_RT_MAPAUDIT.auditd_end(
        p_rtd=>"STG_USUARIO_DISPOSITIVO_PA_id",
        p_sel=>get_map_selected,  -- AuditDetailEnd1
        p_ins=>"STG_USUARIO_DISPOSITIVO_PA_ins",
        p_upd=>"STG_USUARIO_DISPOSITIVO_PA_upd",
        p_del=>"STG_USUARIO_DISPOSITIVO_PA_del",
        p_err=>"STG_USUARIO_DISPOSITIVO_PA_err",
        p_dis=>NULL
      );
    END IF;
  	get_inserted := get_inserted + "STG_USUARIO_DISPOSITIVO_PA_ins";
    get_updated  := get_updated  + "STG_USUARIO_DISPOSITIVO_PA_upd";
    get_deleted  := get_deleted  + "STG_USUARIO_DISPOSITIVO_PA_del";
    get_errors   := get_errors   + "STG_USUARIO_DISPOSITIVO_PA_err";

  get_selected := get_selected + get_map_selected;
  IF NOT get_no_commit THEN
  COMMIT;  -- commit no.21
END IF;

END "EXT_USUARIO_DISPOSITIVO_PAGO_p";



-- Procedure "EXT_USUARIO_DISPOSITIVO_PAGO_t" is the entry point for map "EXT_USUARIO_DISPOSITIVO_PAGO_t"

PROCEDURE "EXT_USUARIO_DISPOSITIVO_PAGO_t"
("TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL) IS
-- Constants for this map
get_map_name               CONSTANT VARCHAR2(40) := '"EXT_USUARIO_DISPOSITIVO_PAGO_t"';
get_source_name            CONSTANT VARCHAR2(2000) := SUBSTRB('"EXT_USUARIO_DISPOSITIVO_PAGO"',0,2000);
get_source_uoid            CONSTANT VARCHAR2(2000) := SUBSTRB('04763AD8784065DFE053B200090A8550',0,2000);
get_step_number            CONSTANT NUMBER(22) := 1;

cursor_exhausted           BOOLEAN := FALSE;
get_close_cursor           BOOLEAN := TRUE;
exit_loop_normal           BOOLEAN := FALSE;
exit_loop_early            BOOLEAN := FALSE;
loop_count                 NUMBER(22);

get_map_selected           NUMBER(22) := 0;
get_map_errors             NUMBER(22) := 0;
get_map_num_rows           NUMBER(22) := 0;
actual_owner               VARCHAR2(30);
actual_name                VARCHAR2(30);

-- Constraint management
num_fk_err                 NUMBER(22);
l_rowkey                   NUMBER(22) := 0;
l_table                    VARCHAR2(30) := 'CREATE';
l_rowid                    ROWID;
l_owner                    VARCHAR2(30);
l_tablename                VARCHAR2(30);
l_constraint               VARCHAR2(30);
l_exec_mode                BINARY_INTEGER := MODE_ROW_TARGET;
sql_excp_stmt              VARCHAR2(32767);
TYPE exceptionsCurType IS REF CURSOR;
exceptions_cursor          exceptionsCurType;

normal_action              VARCHAR2(20);
extended_action            VARCHAR2(2000);
error_action               VARCHAR2(20);
-- The get_audit_detail_id variable has been moved to a package-level variable
-- get_audit_detail_id        NUMBER(22) := 0;
get_target_name            VARCHAR2(80);
error_column               VARCHAR2(80);
error_value                VARCHAR2(2000);
error_rowkey               NUMBER(22) := 0;

-- Scalar variables for auditing

"STG_USUARIO_DISPOSITIVO_PA_id" NUMBER(22) := 0;
"STG_USUARIO_DISPOSITIVO_PA_ins" NUMBER(22) := 0;
"STG_USUARIO_DISPOSITIVO_PA_upd" NUMBER(22) := 0;
"STG_USUARIO_DISPOSITIVO_PA_del" NUMBER(22) := 0;
"STG_USUARIO_DISPOSITIVO_PA_err" NUMBER(22) := 0;
-- Variables for auditing in bulk processing
one_rowkey            NUMBER(22) := 0;
get_rowkey            NUMBER(22) := 0;
get_rowkey_bulk       OWBSYS.WB_RT_MAPAUDIT.NUMBERLIST;
one_rowid             ROWID;
get_rowid             OWBSYS.WB_RT_MAPAUDIT.ROWIDLIST;
rowkey_bulk_index     NUMBER(22) := 0;
x_it_err_count        NUMBER(22) := 0;
get_rowkey_error      NUMBER(22) := 0;

"STG_USUARIO_DISPOSITIVO_PA_srk" OWBSYS.WB_RT_MAPAUDIT.NUMBERLIST;

-- Helper variables for implementing the correlated commit mechanism
TYPE index_redirect_array IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

"STG_USUARIO_DISPOSITIVO_PA_ir"  index_redirect_array;
"SV_STG_USUARIO_DISPOSITIV_srk" NUMBER;
"STG_USUARIO_DISPOSITIVO_PA_new"  BOOLEAN;
"STG_USUARIO_DISPOSITIVO_PA_nul"  BOOLEAN := FALSE;

-- Bulk processing
error_index                NUMBER(22);
update_bulk                OWBSYS.WB_RT_MAPAUDIT.NUMBERLIST;
update_bulk_index          NUMBER(22) := 0;
insert_bulk_index          NUMBER(22) := 0;
last_successful_index      NUMBER(22) := 0;
feedback_bulk_limit        NUMBER(22) := 0;
bulk_commit_count          NUMBER(22) := 0;
bulk_commit                BOOLEAN := FALSE;
get_row_status             BOOLEAN; 
dml_bsize                  NUMBER; 
row_count                  NUMBER(22);
bulk_count                 NUMBER(22);

"EXT_USUARIO_DISPOSITIVO__si$1" NUMBER(22) := 0;

"EXT_USUARIO_DISPOSITIVO_PA_i$1" NUMBER(22) := 0;


"STG_USUARIO_DISPOSITIVO_PA_si" NUMBER(22) := 0;

"STG_USUARIO_DISPOSITIVO_PAGO_i" NUMBER(22) := 0;




-- Bulk: types for collection variables
TYPE "T_EXT_USUA_1_ID_CLIEN$1" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_ROWKEY_EXT_USUARIO_DISPOS$1" IS TABLE OF VARCHAR2(18) INDEX BY BINARY_INTEGER;
TYPE "T_EXT_USUA_2_ID_PAGO$1" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_EXT_USUA_3_ID_USUAR$1" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_ROWKEY_DUMMY_TABLE_CURSOR" IS TABLE OF VARCHAR2(18) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_0_ID_CLIEN$1" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_1_COD_PAGO$1" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_2_COD_USUA$1" IS TABLE OF NUMBER(10) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_3_COD_FECH$1" IS TABLE OF NUMBER(8) INDEX BY BINARY_INTEGER;
TYPE "T_STG_USUA_4_COD_FECH$1" IS TABLE OF NUMBER(8) INDEX BY BINARY_INTEGER;

-- Bulk: intermediate scalar variables
"SV_EXT_USUA_1_ID_CLIEN$1"  NUMBER(10);
"SV_ROWKEY_EXT_USUARIO_DISPOS$1"  VARCHAR2(18);
"SV_EXT_USUA_2_ID_PAGO$1"  NUMBER(10);
"SV_EXT_USUA_3_ID_USUAR$1"  NUMBER(10);
"SV_ROWKEY_DUMMY_TABLE_CURSOR"  VARCHAR2(18);
"SV_STG_USUA_0_ID_CLIEN$1"  NUMBER(10);
"SV_STG_USUA_1_COD_PAGO$1"  NUMBER(10);
"SV_STG_USUA_2_COD_USUA$1"  NUMBER(10);
"SV_STG_USUA_3_COD_FECH$1"  NUMBER(8);
"SV_STG_USUA_4_COD_FECH$1"  NUMBER(8);

-- Bulk: intermediate collection variables
"EXT_USUA_1_ID_CLIEN$1" "T_EXT_USUA_1_ID_CLIEN$1";
"ROWKEY_EXT_USUARIO_DISPOSIT$1" "T_ROWKEY_EXT_USUARIO_DISPOS$1";
"EXT_USUA_2_ID_PAGO$1" "T_EXT_USUA_2_ID_PAGO$1";
"EXT_USUA_3_ID_USUAR$1" "T_EXT_USUA_3_ID_USUAR$1";
"ROWKEY_DUMMY_TABLE_CURSOR" "T_ROWKEY_DUMMY_TABLE_CURSOR";
"STG_USUA_0_ID_CLIEN$1" "T_STG_USUA_0_ID_CLIEN$1";
"STG_USUA_1_COD_PAGO$1" "T_STG_USUA_1_COD_PAGO$1";
"STG_USUA_2_COD_USUA$1" "T_STG_USUA_2_COD_USUA$1";
"STG_USUA_3_COD_FECH$1" "T_STG_USUA_3_COD_FECH$1";
"STG_USUA_4_COD_FECH$1" "T_STG_USUA_4_COD_FECH$1";

PROCEDURE Main_ES(p_step_number IN NUMBER, p_rowkey IN NUMBER, p_table IN VARCHAR2, p_col IN VARCHAR2, p_value IN VARCHAR2 default 'VALUE DISABLED') IS
BEGIN
  get_column_seq := get_column_seq + 1;
  OWBSYS.WB_RT_MAPAUDIT.error_source(
    p_rta=>get_runtime_audit_id,
    p_rowkey=>p_rowkey,
    p_seq=>get_column_seq,
    p_instance=>1,
    p_table=>SUBSTR(p_table,0,80),
    p_column=>SUBSTR(p_col,0,80),
    p_value=>SUBSTRB(p_value,0,2000),
    p_step=>p_step_number,
    p_role=>'T'
  );
END;

---------------------------------------------------------------------------
-- This procedure records column values of one erroneous source row
-- into an audit trail table named WB_RT_ERROR_SOURCES.  Each column is
-- recorded by one row in the audit trail.  To collect all source column
-- values corresponding to one erroneous source row, query the audit
-- trail and specify:
--    RTA_IID, uniquely identifies one audited run,
--    RTE_ROWKEY, uniquely identifies a source row within and audited run
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO__ES$1"(error_index IN NUMBER) IS
BEGIN

  OWBSYS.WB_RT_MAPAUDIT.error_source(
    p_rta=>get_runtime_audit_id,
    p_rowkey=>get_rowkey + error_index - 1,
    p_seq=>1,
    p_instance=>1,
    p_table=>SUBSTR('"EXT_USUARIO_DISPOSITIVO_PAGO"',0,80),
    p_column=>SUBSTR('ID_CLIENTE',0,80),
    p_value=>SUBSTRB("EXT_USUA_1_ID_CLIEN$1"(error_index),0,2000),
    p_step=>get_step_number,
    p_role=>'S'
    );
  OWBSYS.WB_RT_MAPAUDIT.error_source(
    p_rta=>get_runtime_audit_id,
    p_rowkey=>get_rowkey + error_index - 1,
    p_seq=>2,
    p_instance=>1,
    p_table=>SUBSTR('"EXT_USUARIO_DISPOSITIVO_PAGO"',0,80),
    p_column=>SUBSTR('ID_PAGO',0,80),
    p_value=>SUBSTRB("EXT_USUA_2_ID_PAGO$1"(error_index),0,2000),
    p_step=>get_step_number,
    p_role=>'S'
    );
  OWBSYS.WB_RT_MAPAUDIT.error_source(
    p_rta=>get_runtime_audit_id,
    p_rowkey=>get_rowkey + error_index - 1,
    p_seq=>3,
    p_instance=>1,
    p_table=>SUBSTR('"EXT_USUARIO_DISPOSITIVO_PAGO"',0,80),
    p_column=>SUBSTR('ID_USUARIO_DISPOSITIVO',0,80),
    p_value=>SUBSTRB("EXT_USUA_3_ID_USUAR$1"(error_index),0,2000),
    p_step=>get_step_number,
    p_role=>'S'
    );
  RETURN;
    
  END "EXT_USUARIO_DISPOSITIVO__ES$1";

---------------------------------------------------------------------------
-- Procedure "EXT_USUARIO_DISPOSITIVO__ER$1" registers error for one erroneous row
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO__ER$1"(p_statement IN VARCHAR2, p_column IN VARCHAR2, p_col_value IN VARCHAR2, p_sqlcode IN NUMBER, p_sqlerrm IN VARCHAR2, p_auditd_id IN NUMBER, p_error_index IN NUMBER) IS
l_source_target_name VARCHAR2(80);
BEGIN
  IF p_auditd_id IS NULL THEN
    l_source_target_name := SUBSTR(get_source_name,0,80);
  ELSE
    l_source_target_name := get_target_name;
  END IF;

  IF p_error_index = 0 THEN  
  get_rowkey_error := 0;
ELSE  
  get_rowkey_error := get_rowkey + p_error_index - 1;
END IF;

  IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
    OWBSYS.WB_RT_MAPAUDIT.error(
      p_rta=>get_runtime_audit_id,
      p_step=>get_step_number,
      p_rtd=>p_auditd_id,
      p_rowkey=>get_rowkey_error,
      p_table=>l_source_target_name,
      p_column=>p_column,
      p_dstval=>p_col_value,
      p_stm=>'TRACE 23: ' || p_statement,
      p_sqlerr=>p_sqlcode,
      p_sqlerrm=>p_sqlerrm,
      p_rowid=>NULL
    );
  END IF;

  IF ( get_audit_level = AUDIT_COMPLETE ) AND (get_rowkey_error > 0) THEN
    OWBSYS.WB_RT_MAPAUDIT.register_feedback(
      p_rta=>get_runtime_audit_id,
      p_step=>get_step_number,
      p_rowkey=>get_rowkey_error,
      p_status=>'ERROR',
      p_table=>l_source_target_name,
      p_role=>'T',
      p_action=>SUBSTR(p_statement,0,30)
    );
  END IF;

  IF ( get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE ) AND (get_rowkey_error > 0) THEN
    "EXT_USUARIO_DISPOSITIVO__ES$1"(p_error_index);
  END IF;
END "EXT_USUARIO_DISPOSITIVO__ER$1";



---------------------------------------------------------------------------
-- Procedure "EXT_USUARIO_DISPOSITIVO__SU$1" opens and initializes data source
-- for map "EXT_USUARIO_DISPOSITIVO_PAGO_t"
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO__SU$1" IS
BEGIN
  IF get_abort THEN
    RETURN;
  END IF;
  IF (NOT "EXT_USUARIO_DISPOSITIVO_PA_c$1"%ISOPEN) THEN
    OPEN "EXT_USUARIO_DISPOSITIVO_PA_c$1";
  END IF;
  get_read_success := TRUE;
END "EXT_USUARIO_DISPOSITIVO__SU$1";

---------------------------------------------------------------------------
-- Procedure "EXT_USUARIO_DISPOSITIVO__RD$1" fetches a bulk of rows from
--   the data source for map "EXT_USUARIO_DISPOSITIVO_PAGO_t"
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO__RD$1" IS
BEGIN
  IF NOT get_read_success THEN
    get_abort := TRUE;
    IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
      OWBSYS.WB_RT_MAPAUDIT.error(
        p_rta=>get_runtime_audit_id,
        p_step=>0,
        p_rtd=>NULL,
        p_rowkey=>0,
        p_table=>NULL,
        p_column=>NULL,
        p_dstval=>NULL,
        p_stm=>NULL,
        p_sqlerr=>-20007,
        p_sqlerrm=>'CursorFetchMapTerminationRTV20007',
        p_rowid=>NULL
      );
    END IF;
                END IF;

  IF get_abort OR get_abort_procedure THEN
    RETURN;
  END IF;

  BEGIN
    "EXT_USUA_1_ID_CLIEN$1".DELETE;
    "EXT_USUA_2_ID_PAGO$1".DELETE;
    "EXT_USUA_3_ID_USUAR$1".DELETE;

    FETCH
      "EXT_USUARIO_DISPOSITIVO_PA_c$1"
    BULK COLLECT INTO
      "EXT_USUA_1_ID_CLIEN$1",
      "EXT_USUA_2_ID_PAGO$1",
      "EXT_USUA_3_ID_USUAR$1"
    LIMIT get_bulk_size;

    get_total_processed_rowcount := get_total_processed_rowcount + "EXT_USUA_1_ID_CLIEN$1".COUNT;

    IF "EXT_USUARIO_DISPOSITIVO_PA_c$1"%NOTFOUND AND "EXT_USUA_1_ID_CLIEN$1".COUNT = 0 THEN
      RETURN;
    END IF;
    -- register feedback for successful reads
    IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
      get_rowkey := rowkey_counter;
      rowkey_counter := rowkey_counter + "EXT_USUA_1_ID_CLIEN$1".COUNT;
    END IF;
    
    IF get_audit_level = AUDIT_COMPLETE THEN
      OWBSYS.WB_RT_MAPAUDIT.register_feedback_bulk(
        p_rta=>get_runtime_audit_id,
        p_step=>get_step_number,
        p_rowkey=>get_rowkey,
        p_status=>'NEW',
        p_table=>get_source_name,
        p_role=>'S',
        p_action=>'SELECT'
      );
    END IF;
    get_map_selected := get_map_selected + "EXT_USUA_1_ID_CLIEN$1".COUNT;
  EXCEPTION
    WHEN OTHERS THEN
        last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
      get_read_success := FALSE;
      -- register error
      IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
        one_rowkey := rowkey_counter;
        rowkey_counter := rowkey_counter + 1;
        OWBSYS.WB_RT_MAPAUDIT.error(
          p_rta=>get_runtime_audit_id,
          p_step=>get_step_number,
          p_rtd=>NULL,
          p_rowkey=>one_rowkey,
          p_table=>get_source_name,
          p_column=>'*',
          p_dstval=>NULL,
          p_stm=>'TRACE 24: SELECT',
          p_sqlerr=>SQLCODE,
          p_sqlerrm=>SQLERRM,
          p_rowid=>NULL
        );
      END IF;
      
      -- register feedback for the erroneous row
      IF get_audit_level = AUDIT_COMPLETE THEN
        OWBSYS.WB_RT_MAPAUDIT.register_feedback(
          p_rta=>get_runtime_audit_id,
          p_step=>get_step_number,
          p_rowkey=>one_rowkey,
          p_status=>'ERROR',
          p_table=>get_source_name,
          p_role=>'S',
          p_action=>'SELECT'
        );
      END IF;
      get_errors := get_errors + 1;
      IF get_errors > get_max_errors THEN get_abort := TRUE; END IF;
  END;
END "EXT_USUARIO_DISPOSITIVO__RD$1";

---------------------------------------------------------------------------
-- Procedure "EXT_USUARIO_DISPOSITIVO__DML$1" does DML for a bulk of rows starting from index si.
---------------------------------------------------------------------------
PROCEDURE "EXT_USUARIO_DISPOSITIVO__DML$1"(si NUMBER, firstround BOOLEAN) IS
 "STG_USUARIO_DISPOSITIVO__ins0" NUMBER := "STG_USUARIO_DISPOSITIVO_PA_ins";
BEGIN
 IF get_use_hc THEN
  IF firstround AND NOT get_row_status THEN
   RETURN;
  END IF;
  get_row_status := TRUE;
 END IF;
 IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" AND (NOT get_use_hc OR get_row_status) 
AND (NOT (get_use_hc AND "STG_USUARIO_DISPOSITIVO_PA_nul")) THEN
  -- Insert DML for "STG_USUARIO_DISPOSITIVO_PAGO"
  normal_action := 'INSERT';
  error_action  := 'INSERT';
  get_target_name := '"STG_USUARIO_DISPOSITIVO_PAGO"';
  get_audit_detail_id := "STG_USUARIO_DISPOSITIVO_PA_id";
  IF get_use_hc AND NOT firstround THEN
    "STG_USUARIO_DISPOSITIVO_PA_si" := "STG_USUARIO_DISPOSITIVO_PA_ir"(si);
    IF "STG_USUARIO_DISPOSITIVO_PA_si" = 0 THEN
      "STG_USUARIO_DISPOSITIVO_PAGO_i" := 0;
    ELSE
      "STG_USUARIO_DISPOSITIVO_PAGO_i" := "STG_USUARIO_DISPOSITIVO_PA_si" + 1;
    END IF;
  ELSE
    "STG_USUARIO_DISPOSITIVO_PA_si" := 1;
  END IF;
  LOOP
    IF NOT get_use_hc THEN
    EXIT WHEN "STG_USUARIO_DISPOSITIVO_PAGO_i" <= get_bulk_size 
 AND "EXT_USUARIO_DISPOSITIVO_PA_c$1"%FOUND AND NOT get_abort;
    ELSE
      EXIT WHEN "STG_USUARIO_DISPOSITIVO_PA_si" >= "STG_USUARIO_DISPOSITIVO_PAGO_i";
    END IF;
    get_rowid.DELETE;

    BEGIN
      FORALL i IN "STG_USUARIO_DISPOSITIVO_PA_si".."STG_USUARIO_DISPOSITIVO_PAGO_i" - 1
        INSERT 
        INTO
          "STG_USUARIO_DISPOSITIVO_PAGO"
          ("STG_USUARIO_DISPOSITIVO_PAGO"."ID_CLIENTE",
          "STG_USUARIO_DISPOSITIVO_PAGO"."COD_PAGO",
          "STG_USUARIO_DISPOSITIVO_PAGO"."COD_USUARIO_DISPOSITIVO",
          "STG_USUARIO_DISPOSITIVO_PAGO"."COD_FECHA_DIARIO",
          "STG_USUARIO_DISPOSITIVO_PAGO"."COD_FECHA"
          )
        VALUES
          ("STG_USUA_0_ID_CLIEN$1"(i),
          "STG_USUA_1_COD_PAGO$1"(i),
          "STG_USUA_2_COD_USUA$1"(i),
          "STG_USUA_3_COD_FECH$1"(i),
          "STG_USUA_4_COD_FECH$1"(i)
          )
        RETURNING ROWID BULK COLLECT INTO get_rowid;
      error_index := "STG_USUARIO_DISPOSITIVO_PA_si" + get_rowid.COUNT;
    EXCEPTION
      WHEN OTHERS THEN
          last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
        IF get_use_hc THEN
          get_row_status := FALSE;
          ROLLBACK;
          IF firstround THEN
            EXIT;
          END IF;
        END IF;
        error_index := "STG_USUARIO_DISPOSITIVO_PA_si" + get_rowid.COUNT;
        IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
          error_rowkey := "STG_USUARIO_DISPOSITIVO_PA_srk"(error_index);
          OWBSYS.WB_RT_MAPAUDIT.error(
            p_rta=>get_runtime_audit_id,
            p_step=>get_step_number,
            p_rtd=>get_audit_detail_id,
            p_rowkey=>error_rowkey,
            p_table=>get_target_name,
            p_column=>'*',
            p_dstval=>NULL,
            p_stm=>'TRACE 25: ' || error_action,
            p_sqlerr=>SQLCODE,
            p_sqlerrm=>SQLERRM,
            p_rowid=>NULL
          );
          get_column_seq := 0;
          

          
          
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."ID_CLIENTE"',0,80),SUBSTRB("STG_USUA_0_ID_CLIEN$1"(error_index),0,2000));
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."COD_PAGO"',0,80),SUBSTRB("STG_USUA_1_COD_PAGO$1"(error_index),0,2000));
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."COD_USUARIO_DISPOSITIVO"',0,80),SUBSTRB("STG_USUA_2_COD_USUA$1"(error_index),0,2000));
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."COD_FECHA_DIARIO"',0,80),SUBSTRB("STG_USUA_3_COD_FECH$1"(error_index),0,2000));
          Main_ES(get_step_number,error_rowkey,get_target_name,SUBSTRB('"STG_USUARIO_DISPOSITIVO_PAGO"."COD_FECHA"',0,80),SUBSTRB("STG_USUA_4_COD_FECH$1"(error_index),0,2000));
          
        END IF;
        IF get_audit_level = AUDIT_COMPLETE THEN
          OWBSYS.WB_RT_MAPAUDIT.register_feedback(
            p_rta=>get_runtime_audit_id,
            p_step=>get_step_number,
            p_rowkey=>error_rowkey,
            p_status=>'ERROR',
            p_table=>get_target_name,
            p_role=>'T',
            p_action=>error_action
          );
        END IF; 
        "STG_USUARIO_DISPOSITIVO_PA_err" := "STG_USUARIO_DISPOSITIVO_PA_err" + 1;
        
        IF get_errors + "STG_USUARIO_DISPOSITIVO_PA_err" > get_max_errors THEN
          get_abort:= TRUE;
        END IF;
    END;
    -- feedback for a bulk of rows
    IF get_audit_level = AUDIT_COMPLETE THEN
      get_rowkey_bulk.DELETE;
      rowkey_bulk_index := 1;
      FOR rowkey_index IN "STG_USUARIO_DISPOSITIVO_PA_si"..error_index - 1 LOOP
        get_rowkey_bulk(rowkey_bulk_index) := "STG_USUARIO_DISPOSITIVO_PA_srk"(rowkey_index);
        rowkey_bulk_index := rowkey_bulk_index + 1;
      END LOOP;
    END IF;
    
IF get_audit_level = AUDIT_COMPLETE THEN
  OWBSYS.WB_RT_MAPAUDIT.register_feedback_bulk(
    p_rta=>get_runtime_audit_id,
    p_step=>get_step_number,
    p_rowkey=>get_rowkey_bulk,
    p_status=>'NEW',
    p_table=>get_target_name,
    p_role=>'T',
    p_action=>normal_action,
    p_rowid=>get_rowid
  );
END IF;

    "STG_USUARIO_DISPOSITIVO_PA_ins" := "STG_USUARIO_DISPOSITIVO_PA_ins" + get_rowid.COUNT;
    "STG_USUARIO_DISPOSITIVO_PA_si" := error_index + 1;

    IF "STG_USUARIO_DISPOSITIVO_PA_si" >= "STG_USUARIO_DISPOSITIVO_PAGO_i" OR get_abort THEN
      "STG_USUARIO_DISPOSITIVO_PAGO_i" := 1;
      EXIT;
    END IF;
  END LOOP;
END IF;
IF get_use_hc THEN
  "STG_USUARIO_DISPOSITIVO_PAGO_i" := 1; 
END IF;


 IF get_use_hc AND NOT firstround THEN
  COMMIT; -- commit no.27
 END IF;
 IF get_use_hc AND NOT get_row_status THEN
 "STG_USUARIO_DISPOSITIVO_PA_ins" := "STG_USUARIO_DISPOSITIVO__ins0";
END IF;

END "EXT_USUARIO_DISPOSITIVO__DML$1";

---------------------------------------------------------------------------
-- "EXT_USUARIO_DISPOSITIVO_PAGO_t" main
---------------------------------------------------------------------------

BEGIN
  IF get_abort OR get_abort_procedure THEN
    
    RETURN;
  END IF;

  
  IF NOT get_no_commit THEN
  COMMIT;  -- commit no.7
  sql_stmt := 'ALTER SESSION DISABLE PARALLEL DML';
  EXECUTE IMMEDIATE sql_stmt;
END IF;

  IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" THEN
    -- For normal cursor query loop operation, skip map procedure initialization if 
    -- cursor is already open - procedure initialization should only be done the 
    -- first time the procedure is called (since mapping debugger
    -- executes the procedure multiple times and leaves the cursor open). 
    -- For table function (parallel row mode) operation, the cursor will already be
    -- open when the procedure is called, so execute the initialization.
    IF get_table_function OR (NOT "EXT_USUARIO_DISPOSITIVO_PA_c$1"%ISOPEN) THEN
      IF NOT (get_audit_level = AUDIT_NONE) THEN
        IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" THEN
          "STG_USUARIO_DISPOSITIVO_PA_id" :=
            OWBSYS.WB_RT_MAPAUDIT.auditd_begin(  -- Template AuditDetailBegin
              p_rta=>get_runtime_audit_id,
              p_step=>get_step_number,
              p_name=>get_map_name,
              p_source=>get_source_name,
              p_source_uoid=>get_source_uoid,
              p_target=>'"STG_USUARIO_DISPOSITIVO_PAGO"',
              p_target_uoid=>'04763AD8782C65DFE053B200090A8550',
              p_stm=>'TRACE 27',
            	p_info=>NULL,
              p_exec_mode=>l_exec_mode
            );
            get_audit_detail_id := "STG_USUARIO_DISPOSITIVO_PA_id";
              
get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
              p_rtd=>get_audit_detail_id,
              p_parent_operator_uoid=>'04763AD8793965DFE053B200090A8550', -- Operator STG_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
              p_parent_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_type=>'Tabla',
              p_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
              p_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
              p_object_type=>'Tabla',
              p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- DW_STG_LOCATION1
            );  
get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
              p_rtd=>get_audit_detail_id,
              p_parent_operator_uoid=>'04763AD8784065DFE053B200090A8550', -- Operator EXT_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_name=>'EXT_USUARIO_DISPOSITIVO_PAGO',
              p_parent_object_uoid=>'04763AD877DC65DFE053B200090A8550', -- Tabla Externa EXT_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_type=>'Tabla Externa',
              p_object_name=>'EXT_USUARIO_DISPOSITIVO_PAGO',
              p_object_uoid=>'04763AD877DC65DFE053B200090A8550', -- Tabla Externa EXT_USUARIO_DISPOSITIVO_PAGO
              p_object_type=>'Tabla Externa',
              p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- Location DW_STG_LOCATION1
            );  
get_audit_detail_type_id := OWBSYS.WB_RT_MAPAUDIT.register_audit_detail_type(
              p_rtd=>get_audit_detail_id,
              p_parent_operator_uoid=>'04763AD8782C65DFE053B200090A8550', -- Operator STG_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
              p_parent_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
              p_parent_object_type=>'Tabla',
              p_object_name=>'STG_USUARIO_DISPOSITIVO_PAGO',
              p_object_uoid=>'04763AD8781965DFE053B200090A8550', -- Tabla STG_USUARIO_DISPOSITIVO_PAGO
              p_object_type=>'Tabla',
              p_location_uoid=>'03C05C514D115B62E053B200090A5929' -- Location DW_STG_LOCATION1
            );
        END IF;
        IF NOT get_no_commit THEN
          COMMIT; -- commit no.10
        END IF;
      END IF;

      IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" THEN
  BEGIN
    -- Truncate the target table, if the cursor has not been opened yet.
    -- If the cursor is open, then this is not the first call of this procedure for 
    -- the run, so the target has already been truncated.
    IF NOT "EXT_USUARIO_DISPOSITIVO_PA_c$1"%ISOPEN THEN
      IF get_use_hc THEN
        IF "STG_USUARIO_DISPOS_tt_sqlcode" IS NOT NULL THEN
          RAISE_APPLICATION_ERROR(-20016, "STG_USUARIO_DISPOS_tt_sqlerrm");
        END IF;
      ELSE
        EXECUTE IMMEDIATE 'TRUNCATE TABLE "STG_USUARIO_DISPOSITIVO_PAGO"';
      END IF;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
        last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
            IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
              OWBSYS.WB_RT_MAPAUDIT.error(
                p_rta=>get_runtime_audit_id,
                p_step=>1,
                p_rtd=>"STG_USUARIO_DISPOSITIVO_PA_id",
                p_rowkey=>0,
                p_table=>'"STG_USUARIO_DISPOSITIVO_PAGO"',
                p_column=>'*',
                p_dstval=>NULL,
                p_stm=>'TRACE 28: TRUNCATE',
                p_sqlerr=>SQLCODE,
                p_sqlerrm=>SQLERRM,
                p_rowid=>NULL
              );
            END IF;
      get_abort := TRUE;
  END;
END IF;
      

      -- Initialize buffer variables
      get_buffer_done.DELETE;
      get_buffer_done_index := 1;

    END IF; -- End if cursor not open

    -- Initialize internal loop index variables
    "EXT_USUARIO_DISPOSITIVO__si$1" := 0;
    "STG_USUARIO_DISPOSITIVO_PAGO_i" := 1;
    get_rows_processed := FALSE;

    IF NOT get_abort AND NOT get_abort_procedure THEN
      "EXT_USUARIO_DISPOSITIVO__SU$1";

      LOOP
        IF "EXT_USUARIO_DISPOSITIVO__si$1" = 0 THEN
          "EXT_USUARIO_DISPOSITIVO__RD$1";   -- Fetch data from source
          IF NOT get_read_success THEN
            bulk_count := "EXT_USUA_1_ID_CLIEN$1".COUNT - 1;
          ELSE
            bulk_count := "EXT_USUA_1_ID_CLIEN$1".COUNT;
          END IF;
                                        IF bulk_commit THEN
                                                bulk_commit_count := 0;
                                                bulk_commit := FALSE;
                                        END IF;
                                        bulk_commit_count := bulk_commit_count + bulk_count;

 
          IF get_use_hc THEN
            dml_bsize := 0;
            "STG_USUARIO_DISPOSITIVO_PA_ir".DELETE;
"STG_USUARIO_DISPOSITIVO_PAGO_i" := 1;
          END IF;
        END IF;

        -- Processing:
        "EXT_USUARIO_DISPOSITIVO_PA_i$1" := "EXT_USUARIO_DISPOSITIVO__si$1";
        BEGIN
          
          LOOP
            EXIT WHEN "STG_USUARIO_DISPOSITIVO_PAGO_i" > get_bulk_size OR get_abort OR get_abort_procedure;

            "EXT_USUARIO_DISPOSITIVO_PA_i$1" := "EXT_USUARIO_DISPOSITIVO_PA_i$1" + 1;
            "EXT_USUARIO_DISPOSITIVO__si$1" := "EXT_USUARIO_DISPOSITIVO_PA_i$1";
            IF get_use_hc THEN
              get_row_status := TRUE;
                "STG_USUARIO_DISPOSITIVO_PA_new" := FALSE;
            END IF;

            get_buffer_done(get_buffer_done_index) := 
              ("EXT_USUARIO_DISPOSITIVO_PA_c$1"%NOTFOUND AND
               "EXT_USUARIO_DISPOSITIVO_PA_i$1" > bulk_count);

            IF (NOT get_buffer_done(get_buffer_done_index)) AND
              "EXT_USUARIO_DISPOSITIVO_PA_i$1" > bulk_count THEN
            
              "EXT_USUARIO_DISPOSITIVO__si$1" := 0;
              EXIT;
            END IF;


            
get_target_name := '"STG_USUARIO_DISPOSITIVO_PAGO"';
            get_audit_detail_id := "STG_USUARIO_DISPOSITIVO_PA_id";
            IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" AND NOT get_buffer_done(get_buffer_done_index) THEN
              BEGIN
                get_rows_processed := true; -- Set to indicate that some row data was processed (for debugger)
            		error_stmt := SUBSTRB('"STG_USUA_0_ID_CLIEN$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "EXT_USUA_1_ID_CLIEN$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");',0,2000);
            error_column := SUBSTRB('"STG_USUA_0_ID_CLIEN$1"',0,80);
            
            BEGIN
              error_value := SUBSTRB("EXT_USUA_1_ID_CLIEN$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1"),0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_0_ID_CLIEN$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "EXT_USUA_1_ID_CLIEN$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_0_ID_CLIEN$1" :=
            
            "EXT_USUA_1_ID_CLIEN$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");
            
            ELSE
              NULL;
            END IF;
            
            		error_stmt := SUBSTRB('"STG_USUA_1_COD_PAGO$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "EXT_USUA_2_ID_PAGO$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");',0,2000);
            error_column := SUBSTRB('"STG_USUA_1_COD_PAGO$1"',0,80);
            
            BEGIN
              error_value := SUBSTRB("EXT_USUA_2_ID_PAGO$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1"),0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_1_COD_PAGO$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "EXT_USUA_2_ID_PAGO$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_1_COD_PAGO$1" :=
            
            "EXT_USUA_2_ID_PAGO$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");
            
            ELSE
              NULL;
            END IF;
            
            		error_stmt := SUBSTRB('"STG_USUA_2_COD_USUA$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "EXT_USUA_3_ID_USUAR$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");',0,2000);
            error_column := SUBSTRB('"STG_USUA_2_COD_USUA$1"',0,80);
            
            BEGIN
              error_value := SUBSTRB("EXT_USUA_3_ID_USUAR$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1"),0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_2_COD_USUA$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "EXT_USUA_3_ID_USUAR$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_2_COD_USUA$1" :=
            
            "EXT_USUA_3_ID_USUAR$1"("EXT_USUARIO_DISPOSITIVO_PA_i$1");
            
            ELSE
              NULL;
            END IF;
            
            		error_stmt := SUBSTRB('"STG_USUA_3_COD_FECH$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */;',0,2000);
            error_column := SUBSTRB('"STG_USUA_3_COD_FECH$1"',0,80);
            
            BEGIN
              error_value := SUBSTRB("APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */,0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_3_COD_FECH$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */;
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_3_COD_FECH$1" :=
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO"/* ATTRIBUTE P_COD_FECHA_DIARIO.OUTGRP1.COD_FECHA_DIARIO */;
            
            ELSE
              NULL;
            END IF;
            
            		error_stmt := SUBSTRB('"STG_USUA_4_COD_FECH$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := 
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */;',0,2000);
            error_column := SUBSTRB('"STG_USUA_4_COD_FECH$1"',0,80);
            
            BEGIN
              error_value := SUBSTRB("APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */,0,2000);
            EXCEPTION 
              WHEN OTHERS THEN
                error_value := '*';
            END;
            
            IF NOT get_use_hc THEN
              "STG_USUA_4_COD_FECH$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") :=
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */;
            
            ELSIF get_row_status THEN
              "SV_STG_USUA_4_COD_FECH$1" :=
            
            "APP_STG_USUARIO_DISP_PAGO"."COD_FECHA"/* ATTRIBUTE P_COD_FECHA.OUTGRP1.COD_FECHA */;
            
            ELSE
              NULL;
            END IF;
            
            
            
                IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
                  IF NOT get_use_hc THEN
                    "STG_USUARIO_DISPOSITIVO_PA_srk"("STG_USUARIO_DISPOSITIVO_PAGO_i") := get_rowkey + "EXT_USUARIO_DISPOSITIVO_PA_i$1" - 1;
                  ELSIF get_row_status THEN
                    "SV_STG_USUARIO_DISPOSITIV_srk" := get_rowkey + "EXT_USUARIO_DISPOSITIVO_PA_i$1" - 1;
                  ELSE
                    NULL;
                  END IF;
                  END IF;
                  IF get_use_hc THEN
                  "STG_USUARIO_DISPOSITIVO_PA_new" := TRUE;
                ELSE
                  "STG_USUARIO_DISPOSITIVO_PAGO_i" := "STG_USUARIO_DISPOSITIVO_PAGO_i" + 1;
                END IF;
              EXCEPTION
                WHEN OTHERS THEN
                    last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
             
                  "EXT_USUARIO_DISPOSITIVO__ER$1"('TRACE 29: ' || error_stmt, error_column, error_value, SQLCODE, SQLERRM, get_audit_detail_id, "EXT_USUARIO_DISPOSITIVO_PA_i$1");
                  
                  "STG_USUARIO_DISPOSITIVO_PA_err" := "STG_USUARIO_DISPOSITIVO_PA_err" + 1;
                  
                  IF get_errors + "STG_USUARIO_DISPOSITIVO_PA_err" > get_max_errors THEN
                    get_abort:= TRUE;
                  END IF;
                  get_row_status := FALSE; 
              END;
            END IF;
            
            
            
              
            
             EXIT WHEN get_buffer_done(get_buffer_done_index);

            IF get_use_hc AND get_row_status AND ("STG_USUARIO_DISPOSITIVO_PA_new") THEN
              dml_bsize := dml_bsize + 1;
            	IF "STG_USUARIO_DISPOSITIVO_PA_new" 
            AND (NOT "STG_USUARIO_DISPOSITIVO_PA_nul") THEN
              "STG_USUARIO_DISPOSITIVO_PA_ir"(dml_bsize) := "STG_USUARIO_DISPOSITIVO_PAGO_i";
            	"STG_USUA_0_ID_CLIEN$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_0_ID_CLIEN$1";
            	"STG_USUA_1_COD_PAGO$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_1_COD_PAGO$1";
            	"STG_USUA_2_COD_USUA$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_2_COD_USUA$1";
            	"STG_USUA_3_COD_FECH$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_3_COD_FECH$1";
            	"STG_USUA_4_COD_FECH$1"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUA_4_COD_FECH$1";
              "STG_USUARIO_DISPOSITIVO_PA_srk"("STG_USUARIO_DISPOSITIVO_PAGO_i") := "SV_STG_USUARIO_DISPOSITIV_srk";
              "STG_USUARIO_DISPOSITIVO_PAGO_i" := "STG_USUARIO_DISPOSITIVO_PAGO_i" + 1;
            ELSE
              "STG_USUARIO_DISPOSITIVO_PA_ir"(dml_bsize) := 0;
            END IF;
            END IF;
            
          END LOOP;

          "EXT_USUARIO_DISPOSITIVO__DML$1"(1, TRUE);
          IF get_use_hc THEN
            IF NOT get_row_status THEN
              FOR start_index IN 1..dml_bsize LOOP
                "EXT_USUARIO_DISPOSITIVO__DML$1"(start_index, FALSE);
              END LOOP;
            ELSE
              COMMIT;
            END IF;
          END IF;
          
        EXCEPTION
          WHEN OTHERS THEN
              last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
            "EXT_USUARIO_DISPOSITIVO__ER$1"('TRACE 26: ' || error_stmt, '*', NULL, SQLCODE, SQLERRM, NULL, "EXT_USUARIO_DISPOSITIVO_PA_i$1");
            get_errors := get_errors + 1;
            IF get_errors > get_max_errors THEN  
  get_abort := TRUE;
END IF;
            
        END;
        
  IF NOT "STG_USUARIO_DISPOSITIVO_PA_St" AND bulk_commit_count > get_commit_frequency THEN
            IF NOT (get_audit_level = AUDIT_NONE) THEN
              OWBSYS.WB_RT_MAPAUDIT.auditd_progress(
                p_rtd=>"STG_USUARIO_DISPOSITIVO_PA_id",
                p_sel=>get_map_selected,
                p_ins=>"STG_USUARIO_DISPOSITIVO_PA_ins",
                p_upd=>"STG_USUARIO_DISPOSITIVO_PA_upd",
                p_del=>"STG_USUARIO_DISPOSITIVO_PA_del",
                p_err=>"STG_USUARIO_DISPOSITIVO_PA_err",
                p_dis=>NULL
              );
            END IF;
            IF NOT get_no_commit THEN
              COMMIT; -- commit no.25
              bulk_commit := TRUE;
            END IF;
          END IF;


        cursor_exhausted := "EXT_USUARIO_DISPOSITIVO_PA_c$1"%NOTFOUND;
        exit_loop_normal := get_abort OR get_abort_procedure OR (cursor_exhausted AND "EXT_USUARIO_DISPOSITIVO_PA_i$1" > bulk_count);
        exit_loop_early := get_rows_processed AND get_bulk_loop_count IS NOT NULL AND "EXT_USUARIO_DISPOSITIVO_PA_i$1" >= get_bulk_loop_count;
        get_close_cursor := get_abort OR get_abort_procedure OR cursor_exhausted;
        EXIT WHEN exit_loop_normal OR exit_loop_early;

      END LOOP;
    END IF;
    IF NOT get_no_commit THEN
      COMMIT; -- commit no.11
    END IF;
    BEGIN
      IF get_close_cursor THEN
        CLOSE "EXT_USUARIO_DISPOSITIVO_PA_c$1";
      END IF;
    EXCEPTION WHEN OTHERS THEN
      NULL;
      END;
    -- Do post processing only after procedure has been called for the last time and the cursor is closing
    IF get_close_cursor THEN
      
      NULL;
    END IF; -- If get_close_cursor
  END IF;
  
  IF NOT "STG_USUARIO_DISPOSITIVO_PA_St"
    AND NOT (get_audit_level = AUDIT_NONE) THEN
      OWBSYS.WB_RT_MAPAUDIT.auditd_end(
        p_rtd=>"STG_USUARIO_DISPOSITIVO_PA_id",
        p_sel=>get_map_selected,  -- AuditDetailEnd1
        p_ins=>"STG_USUARIO_DISPOSITIVO_PA_ins",
        p_upd=>"STG_USUARIO_DISPOSITIVO_PA_upd",
        p_del=>"STG_USUARIO_DISPOSITIVO_PA_del",
        p_err=>"STG_USUARIO_DISPOSITIVO_PA_err",
        p_dis=>NULL
      );
    END IF;
  	get_inserted := get_inserted + "STG_USUARIO_DISPOSITIVO_PA_ins";
    get_updated  := get_updated  + "STG_USUARIO_DISPOSITIVO_PA_upd";
    get_deleted  := get_deleted  + "STG_USUARIO_DISPOSITIVO_PA_del";
    get_errors   := get_errors   + "STG_USUARIO_DISPOSITIVO_PA_err";

  get_selected := get_selected + get_map_selected;
  IF NOT get_no_commit THEN
  COMMIT;  -- commit no.21
END IF;

END "EXT_USUARIO_DISPOSITIVO_PAGO_t";







PROCEDURE logTextToUser(p_text IN VARCHAR2) IS
  log_clob CLOB;
  log_line VARCHAR2(32767);
BEGIN
  DBMS_LOB.CREATETEMPORARY(log_clob,TRUE);
  dbms_lob.open(log_clob, DBMS_LOB.LOB_READWRITE);
  log_line := p_text || '
';
  dbms_lob.writeappend(log_clob, LENGTH(log_line), log_line);
  dbms_lob.close(log_clob);
  WB_RT_MAPAUDIT.log_file(p_rta=>get_runtime_audit_id, p_text=>log_clob);
EXCEPTION WHEN OTHERS THEN
  dbms_output.put_line(SQLERRM);
END logTextToUser;

PROCEDURE Initialize("TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL, 
p_env IN OWBSYS.WB_RT_MAPAUDIT.WB_RT_NAME_VALUES)  IS
BEGIN
  get_selected := 0;
  get_inserted := 0;
  get_updated  := 0;
  get_deleted  := 0;
  get_merged   := 0;
  get_errors   := 0;
  get_logical_errors := 0;
  get_abort    := FALSE;
  get_abort_procedure  := FALSE;

  FOR i IN 1..p_env.COUNT LOOP
    IF p_env(i).param_value IS NOT NULL THEN
      IF p_env(i).param_name = 'MAX_NO_OF_ERRORS' THEN
        get_max_errors := p_env(i).param_value;

      ELSIF p_env(i).param_name = 'COMMIT_FREQUENCY' THEN
        get_commit_frequency := p_env(i).param_value;
      ELSIF p_env(i).param_name = 'OPERATING_MODE' THEN
        get_operating_mode := p_env(i).param_value;
      ELSIF p_env(i).param_name = 'BULK_SIZE' THEN
        get_bulk_size := p_env(i).param_value;
      ELSIF p_env(i).param_name = 'AUDIT_LEVEL' THEN
        get_audit_level := p_env(i).param_value;
      ELSIF p_env(i).param_name = 'AUDIT_ID' THEN
        get_audit_id := p_env(i).param_value;
      ELSIF p_env(i).param_name = 'PURGE_GROUP' THEN
        get_purge_group := p_env(i).param_value;
      ELSIF p_env(i).param_name = 'OBJECT_ID' THEN
        OWB$MAP_OBJECT_ID := p_env(i).param_value;
      END IF;
    END IF;
  END LOOP;


-- Mapping input parameter global variable assignments

"APP_STG_USUARIO_DISP_PAGO"."TABLE_NAME" := "APP_STG_USUARIO_DISP_PAGO".Initialize."TABLE_NAME";
"APP_STG_USUARIO_DISP_PAGO"."COD_FECHA_DIARIO" := "APP_STG_USUARIO_DISP_PAGO".Initialize."COD_FECHA_DIARIO";
"APP_STG_USUARIO_DISP_PAGO"."COD_FECHA" := "APP_STG_USUARIO_DISP_PAGO".Initialize."COD_FECHA";
"APP_STG_USUARIO_DISP_PAGO"."CANT_FILAS" := "APP_STG_USUARIO_DISP_PAGO".Initialize."CANT_FILAS";


        IF NOT (get_job_audit) THEN
            get_audit_level := AUDIT_NONE;
        END IF;

  IF NOT (get_audit_level = AUDIT_NONE) THEN
    get_runtime_audit_id := OWBSYS.WB_RT_MAPAUDIT.audit_begin(  -- Template AuditBegin
      p_auditid=>get_audit_id,
      p_lob_uoid=>get_lob_uoid,
      p_lob_name=>get_model_name,
      p_purge_group=>get_purge_group,
      p_parent=>NULL,
      p_source=>'"EXT_USUARIO_DISPOSITIVO_PAGO"',
      p_source_uoid=>'04763AD8784065DFE053B200090A8550',
      p_target=>'"STG_USUARIO_DISPOSITIVO_PAGO"',
      p_target_uoid=>'04763AD8782C65DFE053B200090A8550',      p_info=>NULL,
      
            p_type=>'PLSQLMap',
      
      p_date=>get_cycle_date
    );
  END IF;




BEGIN
  -- Expression statement
      error_stmt := SUBSTRB('
  
  
  "FN_TRAILER_CHECK_2_VALUE" := 
  "PACK_STG_UTILS"."FN_TRAILER_CHECK"(("APP_STG_USUARIO_DISP_PAGO"."TABLE_NAME"/* ATTRIBUTE P_TABLE_NAME.OUTGRP1.TABLE_NAME */),("APP_STG_USUARIO_DISP_PAGO"."CANT_FILAS"/* ATTRIBUTE P_CANT_FILAS.OUTGRP1.CANT_FILAS */))/* OPERATOR FN_TRAILER_CHECK */;
  
  ',0,2000);
  
  
  "FN_TRAILER_CHECK_2_VALUE" := 
  "PACK_STG_UTILS"."FN_TRAILER_CHECK"(("APP_STG_USUARIO_DISP_PAGO"."TABLE_NAME"/* ATTRIBUTE P_TABLE_NAME.OUTGRP1.TABLE_NAME */),("APP_STG_USUARIO_DISP_PAGO"."CANT_FILAS"/* ATTRIBUTE P_CANT_FILAS.OUTGRP1.CANT_FILAS */))/* OPERATOR FN_TRAILER_CHECK */;
  
    -- End expression statement
  
  
    
EXCEPTION WHEN OTHERS THEN
  last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
  IF get_audit_level = AUDIT_ERROR_DETAILS OR get_audit_level = AUDIT_COMPLETE THEN
    OWBSYS.WB_RT_MAPAUDIT.error(
      p_rta=>get_runtime_audit_id,
      p_step=>0,
      p_rtd=>NULL,
      p_rowkey=>0,
      p_table=>NULL,
      p_column=>NULL,
      p_dstval=>NULL,
      p_stm=>'PRE_MAP_TRIGGER',
      p_sqlerr=>SQLCODE,
      p_sqlerrm=>SQLERRM,
      p_rowid=>NULL
    );
  END IF;
  get_errors := get_errors + 1;
  get_abort  := TRUE;
  get_trigger_success := FALSE;
END;


  IF NOT get_no_commit THEN
    COMMIT; -- commit no.1
  END IF;
END Initialize;

PROCEDURE Truncate_Targets IS
BEGIN
	BEGIN
  EXECUTE IMMEDIATE 'TRUNCATE TABLE "STG_USUARIO_DISPOSITIVO_PAGO"';
EXCEPTION
  WHEN OTHERS THEN
      last_error_number  := SQLCODE;
  last_error_message := SQLERRM;
    "STG_USUARIO_DISPOS_tt_sqlcode" := SQLCODE;
    "STG_USUARIO_DISPOS_tt_sqlerrm" := SQLERRM;
END;

END Truncate_Targets;

PROCEDURE Analyze_Targets IS
BEGIN
  FOR i IN 1..tables_to_analyze.COUNT LOOP
    OWBSYS.WB_RT_MAPAUDIT_UTIL_INVOKER.gather_table_stats(
      p_ownname          => tables_to_analyze(i).ownname,
      p_tabname          => tables_to_analyze(i).tabname,
      p_estimate_percent => tables_to_analyze(i).estimate_percent,
      p_granularity      => tables_to_analyze(i).granularity,
      p_cascade          => tables_to_analyze(i).cascade,
      p_degree           => tables_to_analyze(i).degree);
  END LOOP;
END Analyze_Targets;


PROCEDURE Finalize("TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL, 
p_env IN OWBSYS.WB_RT_MAPAUDIT.WB_RT_NAME_VALUES)  IS
BEGIN
  IF NOT get_no_commit THEN
    COMMIT; -- commit no.13
  END IF;





  IF get_abort THEN
    get_status := 1;
  ELSIF get_errors > 0 THEN
    get_status := 2;
  ELSE
    get_status := 0;
  END IF;
  get_processed := get_inserted + get_deleted + get_updated + get_merged; 
  IF (get_errors = 0) THEN
    get_error_ratio := 0;
  ELSE
    get_error_ratio := (get_errors /(get_errors + get_processed)) * 100;
  END IF;

  IF NOT (get_audit_level = AUDIT_NONE) THEN
  IF get_status = 0 THEN
    OWBSYS.WB_RT_MAPAUDIT.audit_end(
      p_rta=>get_runtime_audit_id,
      p_sel=>get_selected,
      p_ins=>get_inserted,
      p_upd=>get_updated,
      p_del=>get_deleted,
      p_err=>get_errors,
      p_dis=>NULL,
      p_logical_err=>get_logical_errors,
      p_mer=>get_merged
    );
  ELSE
    OWBSYS.WB_RT_MAPAUDIT.audit_fail(
      p_rta=>get_runtime_audit_id,
      p_status=>get_status,
      p_sel=>get_selected,
      p_ins=>get_inserted,
      p_upd=>get_updated,
      p_del=>get_deleted,
      p_err=>get_errors,
      p_dis=>NULL,
      p_logical_err=>get_logical_errors,
      p_mer=>get_merged
    );
  END IF;
END IF;


  Analyze_Targets;

        
END Finalize;



FUNCTION Main("TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL, 
p_env IN OWBSYS.WB_RT_MAPAUDIT.WB_RT_NAME_VALUES)  RETURN NUMBER IS
get_batch_status           BOOLEAN := TRUE;
x_schema                   VARCHAR2(30);
BEGIN

  IF OWBSYS.WB_RT_MAPAUDIT_UTIL.supportsDesignClient(p_designVersion=>'11.2.0.4.0', p_minRuntimeVersion=>'11.2.0.4.0') < 1 THEN
    raise_application_error(-20103, 'Incompatible runtime and design client versions.');
  END IF;
        
        SELECT ao.owner INTO x_schema
        FROM   user_objects uo, all_objects ao
        WHERE  uo.object_type = 'PACKAGE'
        AND    uo.object_name = 'APP_STG_USUARIO_DISP_PAGO'
        AND    uo.object_id = ao.object_id;
 
        OWBSYS.wb_rt_mapaudit_util.set_schema_workspace(x_schema);
    
  Initialize("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS", 
  p_env);
   
  
  
  
  
  
  IF get_trigger_success THEN
  Truncate_Targets;
    
  NULL;
  END IF;
  
  
   -- Initialize all batch status variables
   "STG_USUARIO_DISPOSITIVO_PA_St" := FALSE;
   IF get_trigger_success THEN
  
   --  Processing for different operating modes
   IF get_operating_mode = MODE_SET THEN
    IF get_use_hc AND NOT get_no_commit THEN
     IF get_enable_parallel_dml THEN
      EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
     ELSE
      EXECUTE IMMEDIATE 'ALTER SESSION DISABLE PARALLEL DML';
     END IF;
    END IF;
    
    IF NOT get_use_hc OR get_batch_status THEN
        "STG_USUARIO_DISPOSITIVO_PA_St" := "STG_USUARIO_DISPOSITIVO_PA_Bat"("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS");
        get_batch_status := get_batch_status AND "STG_USUARIO_DISPOSITIVO_PA_St";
      END IF;
  
    IF get_use_hc THEN
     IF NOT get_batch_status THEN
      get_inserted := 0;
      get_updated  := 0;
      get_deleted  := 0;
      get_merged   := 0;
      get_logical_errors := 0;
     END IF;
    END IF;
  
   END IF;
   IF get_operating_mode = MODE_ROW THEN
   "EXT_USUARIO_DISPOSITIVO_PAGO_p"("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS");
   END IF;
   IF get_operating_mode = MODE_SET_FAILOVER_ROW THEN
    
    IF get_batch_status THEN
        IF NOT get_use_hc OR get_batch_status THEN
          "STG_USUARIO_DISPOSITIVO_PA_St" := "STG_USUARIO_DISPOSITIVO_PA_Bat"("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS");
          get_batch_status := get_batch_status AND "STG_USUARIO_DISPOSITIVO_PA_St";
        END IF;
      END IF;
    IF get_use_hc THEN
     IF NOT get_batch_status AND get_use_hc THEN
      get_inserted := 0;
      get_updated  := 0;
      get_deleted  := 0;
      get_merged   := 0;
      get_logical_errors := 0;
  "STG_USUARIO_DISPOSITIVO_PA_St" := FALSE;
  
     END IF;
    END IF;
  
  "EXT_USUARIO_DISPOSITIVO_PAGO_p"("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS");
  
   END IF;
   IF get_operating_mode = MODE_ROW_TARGET THEN
  "EXT_USUARIO_DISPOSITIVO_PAGO_t"("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS");
  
   END IF;
   IF get_operating_mode = MODE_SET_FAILOVER_ROW_TARGET THEN
    
    IF get_batch_status THEN
        IF NOT get_use_hc OR get_batch_status THEN
          "STG_USUARIO_DISPOSITIVO_PA_St" := "STG_USUARIO_DISPOSITIVO_PA_Bat"("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS");
          get_batch_status := get_batch_status AND "STG_USUARIO_DISPOSITIVO_PA_St";
        END IF;
      END IF;
    IF NOT get_batch_status AND get_use_hc THEN
     get_inserted := 0;
     get_updated  := 0;
     get_deleted  := 0;
     get_merged   := 0;
     get_logical_errors := 0;
  "STG_USUARIO_DISPOSITIVO_PA_St" := FALSE;
  
    END IF;
  "EXT_USUARIO_DISPOSITIVO_PAGO_t"("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS");
  
   END IF;
  END IF;
  
  
   Finalize("TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS", 
  p_env);
   
   RETURN get_status;
  END;

FUNCTION encode_operating_mode(p_operating_mode IN VARCHAR2) RETURN NUMBER IS
BEGIN
  IF p_operating_mode IS NULL THEN
    RETURN get_operating_mode;
  END IF;
  IF p_operating_mode = 'SET_BASED' THEN
    RETURN MODE_SET;
  ELSIF p_operating_mode = 'ROW_BASED' THEN
    RETURN MODE_ROW;
  ELSIF p_operating_mode = 'ROW_BASED_TARGET_ONLY' THEN
    RETURN MODE_ROW_TARGET;
  ELSIF p_operating_mode = 'SET_BASED_FAIL_OVER_TO_ROW_BASED' THEN
    RETURN MODE_SET_FAILOVER_ROW;
  ELSE
    RETURN MODE_SET_FAILOVER_ROW_TARGET;
  END IF;
END encode_operating_mode;

FUNCTION encode_audit_level(p_audit_level IN VARCHAR2) RETURN NUMBER IS
BEGIN
  IF p_audit_level IS NULL THEN
    RETURN get_audit_level;
  END IF;
  IF p_audit_level = 'NONE' THEN
    RETURN AUDIT_NONE;
  ELSIF p_audit_level = 'STATISTICS' THEN
    RETURN AUDIT_STATISTICS;
  ELSIF p_audit_level = 'ERROR_DETAILS' THEN
    RETURN AUDIT_ERROR_DETAILS;
  ELSE
    RETURN AUDIT_COMPLETE;
  END IF;
END encode_audit_level;

FUNCTION encode_job_audit(p_job_audit IN VARCHAR2) RETURN BOOLEAN IS
BEGIN
  IF upper(p_job_audit) = 'TRUE' THEN
     RETURN true;
  ELSIF upper(p_job_audit) = 'FALSE' THEN
     RETURN false;
  ELSE
     RETURN true;
  END IF;
END encode_job_audit;



PROCEDURE Main(p_status OUT VARCHAR2,               "TABLE_NAME" IN VARCHAR2
 DEFAULT NULL,
"COD_FECHA_DIARIO" IN NUMBER
 DEFAULT NULL,
"COD_FECHA" IN NUMBER
 DEFAULT NULL,
"CANT_FILAS" IN NUMBER
 DEFAULT NULL, 
               p_max_no_of_errors IN VARCHAR2 DEFAULT NULL,
               p_commit_frequency IN VARCHAR2 DEFAULT NULL,
               p_operating_mode   IN VARCHAR2 DEFAULT NULL,
               p_bulk_size        IN VARCHAR2 DEFAULT NULL,
               p_audit_level      IN VARCHAR2 DEFAULT NULL,
               p_purge_group      IN VARCHAR2 DEFAULT NULL,
               p_job_audit        IN VARCHAR2 DEFAULT 'TRUE')
 IS
  x_schema      VARCHAR2(30);

  x_audit_id    NUMBER;
  x_object_id   NUMBER;

  x_env         OWBSYS.wb_rt_mapaudit.wb_rt_name_values;
  x_param       OWBSYS.wb_rt_mapaudit.wb_rt_name_value;

  x_result      NUMBER;
  x_return_code NUMBER;

BEGIN
  -- validate parameters

  IF NOT OWBSYS.wb_rt_mapaudit_util.validate_runtime_parameter('MAX_NO_OF_ERRORS',
                                                        p_max_no_of_errors) OR
     NOT OWBSYS.wb_rt_mapaudit_util.validate_runtime_parameter('COMMIT_FREQUENCY',
                                                        p_commit_frequency) OR
     NOT OWBSYS.wb_rt_mapaudit_util.validate_runtime_parameter('OPERATING_MODE',
                                                        p_operating_mode)   OR
     NOT OWBSYS.wb_rt_mapaudit_util.validate_runtime_parameter('BULK_SIZE',
                                                        p_bulk_size)        OR
     NOT OWBSYS.wb_rt_mapaudit_util.validate_runtime_parameter('AUDIT_LEVEL',
                                                        p_audit_level) THEN
    p_status := 'FAILURE';
    RETURN;
  END IF;

  -- perform pre-run setup

  SELECT ao.owner INTO x_schema
  FROM   user_objects uo, all_objects ao
  WHERE  uo.object_type = 'PACKAGE'
  AND    uo.object_name = 'APP_STG_USUARIO_DISP_PAGO'
  AND    uo.object_id = ao.object_id;
 
  get_job_audit := encode_job_audit(p_job_audit);

  IF get_job_audit THEN 
     OWBSYS.wb_rt_mapaudit_util.premap('APP_STG_USUARIO_DISP_PAGO', x_schema, x_audit_id, x_object_id);
  ELSE
    OWBSYS.wb_rt_mapaudit_util.set_schema_workspace(x_schema);
  END IF;

  -- prepare parameters for Main:

  x_param.param_name := 'AUDIT_ID';
  x_param.param_value := x_audit_id;
  x_env(1) := x_param;

  x_param.param_name := 'OBJECT_ID';
  x_param.param_value := x_object_id;
  x_env(2) := x_param;

  x_param.param_name := 'MAX_NO_OF_ERRORS';
  x_param.param_value := p_max_no_of_errors;
  x_env(3) := x_param;

  x_param.param_name := 'COMMIT_FREQUENCY';
  x_param.param_value := p_commit_frequency;
  x_env(4) := x_param;

  x_param.param_name := 'OPERATING_MODE';
  x_param.param_value := encode_operating_mode(p_operating_mode);
  x_env(5) := x_param;

  x_param.param_name := 'BULK_SIZE';
  x_param.param_value := p_bulk_size;
  x_env(6) := x_param;

  x_param.param_name := 'AUDIT_LEVEL';
  x_param.param_value := encode_audit_level(p_audit_level);
  x_env(7) := x_param;

  x_param.param_name := 'PURGE_GROUP';
  x_param.param_value := p_purge_group;
  x_env(8) := x_param;


  IF get_job_audit AND x_audit_id IS NOT NULL THEN
  -- register "system" parameters:
  FOR i IN 3..8 LOOP
    IF x_env(i).param_value IS NOT NULL THEN
      OWBSYS.wb_rt_mapaudit_util.register_sys_param(x_audit_id,
                                             x_env(i).param_name,
                                             x_env(i).param_value);
    END IF;
  END LOOP;
  END IF;

  -- register custom input parameters:
  -- Temp fix until selective registration ensures correct handling of complex types
-- OWBSYS.wb_rt_mapaudit_util.register_custom_param(x_audit_id,
                                            -- '"TABLE_NAME"',
                                            -- TO_CHAR("TABLE_NAME"));
  -- Temp fix until selective registration ensures correct handling of complex types
-- OWBSYS.wb_rt_mapaudit_util.register_custom_param(x_audit_id,
                                            -- '"COD_FECHA_DIARIO"',
                                            -- TO_CHAR("COD_FECHA_DIARIO"));
  -- Temp fix until selective registration ensures correct handling of complex types
-- OWBSYS.wb_rt_mapaudit_util.register_custom_param(x_audit_id,
                                            -- '"COD_FECHA"',
                                            -- TO_CHAR("COD_FECHA"));
  -- Temp fix until selective registration ensures correct handling of complex types
-- OWBSYS.wb_rt_mapaudit_util.register_custom_param(x_audit_id,
                                            -- '"CANT_FILAS"',
                                            -- TO_CHAR("CANT_FILAS"));
  -- really run it:
  -- return code from mapping is
  --   0 - success
  --   1 - failure
  --   2 - completed (with errors/warnings)
  x_return_code := NULL;
  BEGIN
      x_result := Main( "TABLE_NAME", "COD_FECHA_DIARIO", "COD_FECHA", "CANT_FILAS",
      x_env);
  EXCEPTION
    WHEN OTHERS THEN
      x_result := 1;
      x_return_code := SQLCODE;
  END;

  IF get_job_audit AND x_audit_id IS NOT NULL THEN
  -- perform post map cleanup

  IF (get_job_audit) THEN
    OWBSYS.wb_rt_mapaudit_util.postmap(x_audit_id, x_result, x_return_code);
  END IF;

  -- show results:
  OWBSYS.wb_rt_mapaudit_util.show_run_results(x_audit_id);
  END IF;

  -- set return status
  IF x_result = 0 THEN
    p_status := 'OK';
  ELSIF x_result = 1 THEN
    p_status := 'FAILURE (ERROR CODE='||x_return_code||')';
  ELSE
    p_status := 'OK_WITH_WARNINGS';
  END IF;

END Main;

PROCEDURE Close_Cursors IS
BEGIN
BEGIN
  IF "EXT_USUARIO_DISPOSITIVO_PAGO_c"%ISOPEN THEN
    CLOSE "EXT_USUARIO_DISPOSITIVO_PAGO_c";
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    NULL;    
END;BEGIN
  IF "EXT_USUARIO_DISPOSITIVO_PA_c$1"%ISOPEN THEN
    CLOSE "EXT_USUARIO_DISPOSITIVO_PA_c$1";
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    NULL;    
END;

END Close_Cursors;



END "APP_STG_USUARIO_DISP_PAGO";

/



