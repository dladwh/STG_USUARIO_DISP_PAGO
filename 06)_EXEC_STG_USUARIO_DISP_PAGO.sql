Declare
   V_status                     Varchar2 (4000);
   V_trailer_cant_filas         Number;
   V_trailer_table_name         Varchar2 (30);
   V_trailer_cod_fecha          Number;
   V_trailer_cod_fecha_diario   Number;
Begin
   Select Cant_filas, Tablename, Cod_fecha, Cod_fecha_diario
   Into   V_trailer_cant_filas, V_trailer_table_name, V_trailer_cod_fecha, V_trailer_cod_fecha_diario
   From EXT_USUARIO_DISP_PAGO_TRL;

   Dw_stg.APP_STG_USUARIO_DISP_PAGO.Main (P_status                => V_status
                                       , Cant_filas              => V_trailer_cant_filas
                                       , Cod_fecha               => V_trailer_cod_fecha
                                       , Table_name              => V_trailer_table_name
                                       , Cod_fecha_diario        => V_trailer_cod_fecha_diario
                                       , P_max_no_of_errors      => 50
                                       , P_commit_frequency      => 1000
                                       , P_operating_mode        => 'ROW_BASED_TARGET_ONLY'
                                       , P_bulk_size             => 1000
                                       , P_audit_level           => 'ERROR_DETAILS'
                                       , P_purge_group           => 'WB'
                                       , P_job_audit             => 'TRUE');
   DBMS_OUTPUT.Put_line (' ' || V_status);

   If (INSTR (V_status, 'FAILURE', 1) != 0) Then
      DBMS_OUTPUT.Put_line ('---------------------------------------------------');
      DBMS_OUTPUT.Put_line ('ERROR AL PROCESAR MAPPING');
   End If;
End;