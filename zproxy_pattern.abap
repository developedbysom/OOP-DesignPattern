REPORT zproxy.

INTERFACE lif_data.
  METHODS get_data IMPORTING
    im_country_id TYPE string
    EXPORTING
        ex_country_name TYPE string.
ENDINTERFACE.

*---server
CLASS lcl_server DEFINITION PUBLIC FINAL.
  PUBLIC SECTION.
    INTERFACES lif_data.
ENDCLASS.

CLASS lcl_server IMPLEMENTATION.
  METHOD lif_data~get_data.
    CLEAR ex_country_name.
    CASE im_country_id.
      WHEN 'IN'.
        ex_country_name = 'India'.
      WHEN 'DE'.
        ex_country_name = 'Germany'.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

*---proxy class
CLASS lcl_proxy DEFINITION PUBLIC FINAL.
  PUBLIC SECTION.
    INTERFACES lif_data.
    DATA o_server_ref TYPE REF TO lif_data.
ENDCLASS.

CLASS lcl_proxy IMPLEMENTATION.
  METHOD lif_data~get_data.
*--validation
    IF im_country_id IS INITIAL.
      RETURN .
    ENDIF.
*--auth check

*--create object
    CREATE OBJECT o_server_ref TYPE lcl_server.
    o_server_ref->get_data(
        EXPORTING im_country_id = im_country_id
        IMPORTING ex_country_name = ex_country_name ).
  ENDMETHOD.
ENDCLASS.

*---client
CLASS lcl_client DEFINITION PUBLIC FINAL.
  PUBLIC SECTION.
    CLASS-METHODS:run.
   
ENDCLASS.

CLASS lcl_client IMPLEMENTATION.
  METHOD run.
    DATA o_proxy_ref TYPE REF TO lif_data.
    DATA l_country_name TYPE string.

    CREATE OBJECT o_proxy_ref TYPE lcl_proxy.
    o_proxy_ref->get_data(
        EXPORTING im_country_id = 'IN'
        IMPORTING ex_country_name = l_country_name ).
    WRITE:/ l_country_name.

    CLEAR l_country_name..
    o_proxy_ref->get_data(
        EXPORTING im_country_id = 'DE'
        IMPORTING ex_country_name = l_country_name ).
    WRITE:/ l_country_name.
    
    CLEAR l_country_name.
    o_proxy_ref->get_data(
        EXPORTING im_country_id = ' '
        IMPORTING ex_country_name = l_country_name ).
    WRITE:/ l_country_name.
  ENDMETHOD.
ENDCLASS.
          
START-OF-SELECTION.
  lcl_client=>run( ).

          
