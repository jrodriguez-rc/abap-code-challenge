CLASS zcl_challenge_abap2ui5 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_user,
        selected TYPE abap_bool,
        username TYPE xubname,
        fullname TYPE string,
      END OF ty_user,
      ty_users TYPE STANDARD TABLE OF ty_user WITH EMPTY KEY.

    DATA username TYPE xubname.
    DATA execution_date TYPE d.
    DATA f4_users TYPE ty_users.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA initialized TYPE abap_bool.
    DATA mv_view_main TYPE string.
    DATA mv_view_popup TYPE string.

    METHODS initialize.

    METHODS get_user_name
      IMPORTING
        input         TYPE xubname
      RETURNING
        VALUE(result) TYPE string.

    METHODS get_user_fullname
      IMPORTING
        input         TYPE xubname
      RETURNING
        VALUE(result) TYPE string.

ENDCLASS.



CLASS zcl_challenge_abap2ui5 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    DATA(render_view) = ``.

    initialize( ).

    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |App executed on { execution_date DATE = USER } by { get_user_name( username ) }| ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-id_prev_app_stack  ) ).

    ENDCASE.

    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->shell(
        )->page(
                title          = 'SAP Developer Code Challenge'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = abap_true
            )->header_content(
                )->link(
                    text = 'Challenge'  target = '_blank'
                    href = 'https://groups.community.sap.com/t5/application-development/sap-developer-code-challenge-open-source-abap-week-2/m-p/260727#M1372'
                )->get_parent(
                )->simple_form( title = 'Open-Source ABAP (Week 2)'
                    )->content( 'form'
                        )->title( 'Input'
                        )->label( 'User'
                        )->input( value       = client->_bind( username )
                                  placeholder = 'Username'
                        )->label( 'Date'
                        )->date_picker( value       = execution_date
                                        placeholder = 'Execution date'
                        )->button(
                            text  = 'post'
                            press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).

  ENDMETHOD.


  METHOD initialize.

    CLEAR f4_users.

    IF initialized = abap_true.
      RETURN.
    ENDIF.

    initialized = abap_true.

    username       = cl_abap_syst=>get_user_name( ).
    execution_date = sy-datum.

  ENDMETHOD.


  METHOD get_user_name.

    DATA:
      address         TYPE bapiaddr3,
      return_messages TYPE bapiret2_t.

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username = username
      IMPORTING
        address  = address
      TABLES
        return   = return_messages.

    result = COND #( LET fullname = get_user_fullname( input ) IN
                     WHEN fullname IS NOT INITIAL THEN fullname ELSE username ).

  ENDMETHOD.


  METHOD get_user_fullname.

    DATA:
      address         TYPE bapiaddr3,
      return_messages TYPE bapiret2_t.

    CALL FUNCTION 'BAPI_USER_GET_DETAIL'
      EXPORTING
        username = username
      IMPORTING
        address  = address
      TABLES
        return   = return_messages.

    result = address-fullname.

  ENDMETHOD.


ENDCLASS.
