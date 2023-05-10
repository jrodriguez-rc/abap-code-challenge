CLASS zcl_challenge_adt_base DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
    "! <p class="shorttext synchronized" lang="en">Execute test</p>
    METHODS execute ABSTRACT
      RAISING
        cx_static_check
        cx_dynamic_check.

    "! <p class="shorttext synchronized" lang="en">Write ADT output</p>
    "!
    "! @parameter ig_data | <p class="shorttext synchronized" lang="en">Data</p>
    "! @parameter iv_name | <p class="shorttext synchronized" lang="en">Name</p>
    METHODS write
      IMPORTING
        ig_data TYPE any
        iv_name TYPE csequence OPTIONAL.

  PRIVATE SECTION.
    DATA mi_out TYPE REF TO if_oo_adt_intrnl_classrun.

    METHODS write_exception
      IMPORTING
        ix_exception TYPE REF TO cx_root.

ENDCLASS.



CLASS zcl_challenge_adt_base IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    mi_out = out.

    TRY.
        execute( ).
      CATCH /bobf/cx_frw_fatal /bobf/cx_frw_int_access.
      CATCH cx_root INTO DATA(lx_exception).
        write_exception( lx_exception ).
    ENDTRY.

  ENDMETHOD.


  METHOD write.

    mi_out->write( data = ig_data name = CONV string( iv_name ) ).

  ENDMETHOD.


  METHOD write_exception.

    IF ix_exception IS NOT BOUND.
      RETURN.
    ENDIF.

    write( ix_exception->get_text( ) ).

    write_exception( ix_exception->previous ).

  ENDMETHOD.


ENDCLASS.
