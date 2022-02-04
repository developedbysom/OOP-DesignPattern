REPORT zocp.

INTERFACE lif_shape.
  METHODS calculate_area RETURNING VALUE(l_area) TYPE string.
ENDINTERFACE.

CLASS lcl_rectangle DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES lif_shape.
    DATA l_length TYPE i.
    DATA l_breath TYPE i.
ENDCLASS.

CLASS lcl_rectangle IMPLEMENTATION.
  METHOD lif_shape~calculate_area.
    l_length  = 5.
    l_breath = 3.
    l_area = l_breath * l_length.
  ENDMETHOD.
ENDCLASS.
          
CLASS lcl_circle DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES lif_shape.
    DATA l_radius TYPE i.
ENDCLASS.
          
CLASS lcl_circle IMPLEMENTATION.
  METHOD lif_shape~calculate_area.
    l_radius  = 10.
    l_area =  22  / 7 * ( l_radius  * l_radius ) .
  ENDMETHOD.
ENDCLASS.
                    
START-OF-SELECTION.
CLASS lcl_main DEFINITION PUBLIC.
  PUBLIC SECTION.
    CLASS-DATA lo_shape TYPE REF TO lif_shape.
    CLASS-METHODS: calculate_area IMPORTING
        im_shape TYPE string.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD calculate_area.

    DATA l_class TYPE string.
    l_class = 'LCL_' && to_upper( im_shape ).
 
    CREATE OBJECT lo_shape TYPE (l_class).   

    IF lo_shape IS BOUND.
      WRITE:/ 'Area of : ' && im_shape && ' -> ' &&  lo_shape->calculate_area( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

 lcl_main=>calculate_area( 'circle' ).

 lcl_main=>calculate_area( 'rectangle' ).
  
