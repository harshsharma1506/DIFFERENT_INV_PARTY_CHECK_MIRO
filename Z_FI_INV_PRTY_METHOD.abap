***************************************************
* Here a global class in SE24 class pool is used  *
* Paramaters -                                    *
* Importing I_TCODE TYPE SY-TCODE                 *
*           I_BUKRS TYPE BUKRS                    *
* EXPORTING E_RET   TYPE CHAR1                    *
***************************************************
*--> Entry structure Name , low has combination of MIRO_BUKRS and HIGH has 'X'

DATA(lv_low) = i_tcode && '_' && i_bukrs.
CONSTANT c_name = 'Z_CC_SET_INV_PTY'
SELECT SINGLE high FROM 
                   tvarvc 
                   WHERE name = @c_name 
                   AND   low  = @lv_low
                   INTO  @e_ret. 
IF sy-subrc <> 0. 
   CLEAR e_ret.
ENDIF.
