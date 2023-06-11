``` abap


INTERFACE lif_visitor DEFERRED.

INTERFACE lif_visitible.
  TYPES:BEGIN OF ty_info,
          model 	TYPE string,
          p_date  	TYPE dats,
          capacity  TYPE num4,
		  issue 	TYPE string,
        END OF ty_info.
  METHODS:allow IMPORTING im_visitor TYPE REF TO lif_visitor,
    provide_info RETURNING VALUE(ls_info) TYPE ty_info.
ENDINTERFACE.

INTERFACE lif_visitor.
  METHODS:visit IMPORTING im_client      TYPE REF TO lif_visitible
                RETURNING VALUE(r_price) TYPE kbetr.
ENDINTERFACE.

CLASS lcl_visitor DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_visitor.
    ALIASES service FOR lif_visitor~visit.
ENDCLASS.

CLASS lcl_visitor IMPLEMENTATION.

  METHOD service.

    DATA(ls_info) = im_client->provide_info( ).

    IF ls_info-model = 'Whirlpool'
    AND ABS( ( sy-datum- ls_info-p_date ) ) LT 365.

      r_price = 0.

    ELSEIF ls_info-model = 'Whirlpool'
        AND ( sy-datum - ls_info-p_date ) GT 365
        AND ls_info-capacity LT 300.
      r_price = 450.

    ELSEIF ls_info-model = 'Whirlpool'
        AND ( sy-datum- ls_info-p_date ) GT 365
        AND ls_info-capacity GT 300.
      r_price = 550.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_client DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_visitible.
    ALIASES: my_info FOR lif_visitible~provide_info,
             allow FOR lif_visitible~allow.

    METHODS:constructor IMPORTING 
								  im_model 		TYPE string
                                  im_capacity  	TYPE num4
                                  im_p_date  	TYPE num4
								  im_issue 		type string,
      get_price RETURNING VALUE(r_price) TYPE string.

    DATA: l_model 		TYPE string,
          l_capacity  	TYPE num4,
          l_p_date  	TYPE dats,
          l_price 		TYPE kbetr,
		  l_issue 		TYPE string.

ENDCLASS.

CLASS lcl_client IMPLEMENTATION.

  METHOD constructor.
    l_model = im_model.
    l_p_date = im_p_date.
    l_capacity = im_capacity.
	l_issue = im_issue.
  ENDMETHOD.

  METHOD my_info.
    ls_info-model = me->l_model.
    ls_info-p_date = me->l_p_date.
    ls_info-capacity = me->l_capacity.
	ls_info-issue = me->l_issue.
  ENDMETHOD.

  METHOD allow.
    l_price = im_visitor->visit( me ).
  ENDMETHOD.

  METHOD get_price.
    r_price = |Model:{ me->l_model }, capacity:{ me->l_capacity ALPHA = OUT }, 
			   p_date: { l_p_date+0(4) } ==> Service Charge:{ me->l_price }|.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.

  DATA(lo_client) =  NEW lcl_client( im_model = 'Whirlpool' im_capacity = 275 
									 im_p_date = '01012016' im_issue = `Cooling Problem`).
  lo_client->allow( NEW lcl_visitor( ) ).

  cl_demo_output=>display(
         lo_client->get_price( )
  ).
  
  ```


  
