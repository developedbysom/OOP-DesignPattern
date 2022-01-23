REPORT zsingleton.

CLASS lcl_singleton DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    DATA v_data TYPE string.
    CLASS-DATA: o_singleton TYPE REF TO lcl_singleton.
    METHODS set_data IMPORTING
        im_data TYPE string.
    METHODS get_data RETURNING VALUE(re_data) TYPE string .
    CLASS-METHODS: get_instance RETURNING VALUE(re_obj) TYPE REF TO lcl_singleton.
ENDCLASS.

CLASS lcl_singleton IMPLEMENTATION.
  METHOD set_data.
    v_data = im_data.
  ENDMETHOD.
  METHOD get_data.
    re_data = v_data.
  ENDMETHOD.
  METHOD get_instance.
    IF o_singleton IS BOUND.
      re_obj = o_singleton.
    ELSE.
      CREATE OBJECT o_singleton.
      re_obj = o_singleton.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
          
START-OF-SELECTION.

*   DATA lo_singleton TYPE REF TO lcl_singleton.
*   DATA lo_singleton1 TYPE REF TO lcl_singleton.

*   CREATE OBJECT lo_singleton.
*   CREATE OBJECT lo_singleton1.

*   lo_singleton->set_data( im_data = 'John Doe' ).
*   WRITE:/ lo_singleton->get_data( ).


*   lo_singleton1->set_data( im_data = 'Somnath Paul' ).
*   WRITE:/ lo_singleton1->get_data( ).


  lcl_singleton=>get_instance( )->set_data( 'somnath paul' ).
  WRITE:/ lcl_singleton=>get_instance( )->get_data( ).

  IF lcl_singleton=>get_instance( ) EQ lcl_singleton=>get_instance( ).
    WRITE:/ 'Same instance'.
  ENDIF.