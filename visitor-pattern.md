``` abap

INTERFACE lif_visitor DEFERRED.

*---Creating Two interfaces for Handshaking between visiror and visitible (client) 
INTERFACE lif_visitible.
  TYPES:BEGIN OF ty_info,
          model TYPE string,
          year  TYPE num4,
          size  TYPE num4,
        END OF ty_info.
  METHODS:allow IMPORTING im_visitor TYPE REF TO lif_visitor,
    provide_info RETURNING VALUE(ls_info) TYPE ty_info.
ENDINTERFACE.

INTERFACE lif_visitor.
  METHODS:visit IMPORTING im_client      TYPE REF TO lif_visitible
                RETURNING VALUE(r_price) TYPE kbetr.
ENDINTERFACE.

*---Visitor needs to implement the right interface
CLASS lcl_visitor DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_visitor.
    ALIASES service FOR lif_visitor~visit.
ENDCLASS.

CLASS lcl_visitor IMPLEMENTATION.

*---This is the Visitor Task
  METHOD service.

    DATA(ls_info) = im_client->provide_info( ).

    IF ls_info-model = 'Whirlpool'
    AND ( sy-datum+4 - ls_info-year ) LT 1.

      r_price = 0.

    ELSEIF ls_info-model = 'Whirlpool'
        AND ( sy-datum - ls_info-year ) GT 1
        AND ls_info-size LT 300.
      r_price = 450.

    ELSEIF ls_info-model = 'Whirlpool'
        AND ( sy-datum - ls_info-year ) GT 1
        AND ls_info-size GT 300.
      r_price = 550.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

*---Client also needs to implement the client interface
CLASS lcl_client DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_visitible.
    ALIASES: refz_info FOR lif_visitible~provide_info,
             allow FOR lif_visitible~allow.

    METHODS:constructor IMPORTING im_model TYPE string
                                  im_size  TYPE num4
                                  im_year  TYPE num4,
      get_price RETURNING VALUE(r_price) TYPE string.

    DATA: l_model TYPE string,
          l_size  TYPE num4,
          l_year  TYPE num4,
          l_price TYPE kbetr.

ENDCLASS.

CLASS lcl_client IMPLEMENTATION.

*--Setting the required details during construction
  METHOD constructor.
    l_model = im_model.
    l_year = im_year.
    l_size = im_size.
  ENDMETHOD.

*---Client is making the data handy for the visitor
  METHOD refz_info.
    ls_info-model = me->l_model.
    ls_info-year = me->l_year.
    ls_info-size = me->l_size.
  ENDMETHOD.

*---Client is accpeting the visitor to perform certain Tasks
  METHOD allow.
    l_price = im_visitor->visit( me ).
  ENDMETHOD.

*---When client wants to know the cost 
  METHOD get_price.
    r_price = |Model:{ me->l_model }, Size:{ me->l_size ALPHA = OUT }, Year: { l_year } ==> Service Charge:{ me->l_price }|.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

*---Setting up the client Object.
  DATA(lo_client) =  NEW lcl_client( im_model = 'Whirlpool' im_size = 375 im_year = '2023' ).

*---Client asks the visitor to perform certain action  
  lo_client->allow( NEW lcl_visitor( ) ).

*---Client wants to know the cost / quotation 
  cl_demo_output=>display(
         lo_client->get_price( )
  ).
  
  
  ```


  
