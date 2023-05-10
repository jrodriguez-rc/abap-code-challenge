CLASS zcl_challenge_hello_world DEFINITION
  PUBLIC
  INHERITING FROM zcl_challenge_adt_base
  CREATE PUBLIC .

  PUBLIC SECTION.

  PROTECTED SECTION.
    METHODS: execute REDEFINITION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_challenge_hello_world IMPLEMENTATION.


  METHOD execute.

    write( `Hello World!` ).

  ENDMETHOD.


ENDCLASS.
