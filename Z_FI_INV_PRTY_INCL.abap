*INCLUDE - you can use this diectly in the enhacmenet implementation block*

CONSTANTS: c_msgid       TYPE char2  VALUE 'M8',
           c_msgno(3)    TYPE n      VALUE '286',
           c_error       TYPE char1  VALUE 'E',
           c_setname     TYPE char34 VALUE 'Z_INV_PRTY_LIFNR_EXCEPT',
           c_lfa1        TYPE char30 VALUE 'LFA1',
           c_lifnr       TYPE char30 VALUE 'LIFNR'.
DATA:      t_set         TYPE TABLE OF rgsb4,
           wa_set        TYPE rgsb4,
           v_check       TYPE c      VALUE ' ',
           lv_chk        TYPE char1,
           ls_msg        TYPE LINE OF mrm_tab_errprot,
           lv_tabix      TYPE sy-tabix,
           lv_lifnr_chk  TYPE lifnr.

CALL METHOD z_inv_prty_cls=>inv_prty_bukrs_chk "copy the code of method inside here 
  EXPORTING
    i_tcode = sy-tcode
    i_bukrs = i_rbkpv-bukrs
  IMPORTING
    e_ret   = lv_chk.

*IF bukrs is met 
IF lv_chk IS NOT INITIAL.
  READ TABLE t_errprot
   INTO ls_msg WITH KEY
               msgid = c_msgid
               msgno = c_msgno.
  IF sy-subrc IS INITIAL     AND
      sy-tabix IS NOT INITIAL AND
      ls_msg IS NOT INITIAL.
    lv_tabix = sy-tabix.
    CALL FUNCTION 'G_SET_GET_ALL_VALUES' "read vendor for exception !
          EXPORTING
            client        = sy-mandt
            setnr         = c_setname
            table         = c_lfa1
            class         = '0000'
            fieldname     = c_lifnr
          TABLES
            set_values    = t_set
          EXCEPTIONS
            set_not_found = 1
            OTHERS        = 2.
    IF sy-subrc <> 0.
* Implement suitable error handling here
    ELSE.
      "vendor exclusion
      CALL FUNCTION 'CONVERSION_EXIT_ALPHA_INPUT'    " use conversion exit to have include zeroes in the start your set will always have that 
        EXPORTING
          input  = ls_msg-msgv3
        IMPORTING
          output = lv_lifnr_chk.
      READ TABLE t_set WITH KEY from = lv_lifnr_chk
      TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        ls_msg-msgty    = c_error.
        MODIFY t_errprot FROM ls_msg INDEX lv_tabix.
      ENDIF.
    ENDIF.
  ENDIF.
ENDIF.
