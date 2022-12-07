*&---------------------------------------------------------------------*
*& Report ZIR_REPO_UVAIS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zir_repo_uvais NO STANDARD PAGE HEADING LINE-COUNT 20(2).

TYPES: BEGIN OF ty_mara,
         matnr TYPE mara-matnr,
         mbrsh TYPE mara-mbrsh,
         mtart TYPE mara-mtart,
         ersda TYPE mara-ersda,
         ernam TYPE mara-ernam,
         matkl TYPE mara-matkl,
       END OF ty_mara.

DATA: it_mara TYPE STANDARD TABLE OF ty_mara,
      wa_mara TYPE ty_mara.

DATA: s_var  TYPE mara-matnr,
      lv_var TYPE char50.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME.
SELECT-OPTIONS: s_matnr FOR s_var.
SELECTION-SCREEN END OF BLOCK b1.

TOP-OF-PAGE.
  ULINE.
  WRITE:  3    'Material Number'              , 20 '|',
               'Industry Sector'              ,    '|',
               'Material Type'                ,    '|',
               'Created ON'                   ,    '|',
               'Person Who Created the Object',    '|',
           110 'Material Group'.
  ULINE.

START-OF-SELECTION.

  PERFORM fd_mara.

END-of-SELECTION.
  LOOP AT it_mara INTO wa_mara.
    WRITE:/    wa_mara-matnr COLOR 1 HOTSPOT,    '|',
           29  wa_mara-mbrsh COLOR 2        , 38 '|',
           45  wa_mara-mtart COLOR 3        , 54 '|',
               wa_mara-ersda COLOR 4        ,    '|',
           79  wa_mara-ernam COLOR 5        , 99 '|',
           110 wa_mara-matkl COLOR 6.
    HIDE wa_mara-matnr.
  ENDLOOP.


AT LINE-SELECTION.
  GET CURSOR FIELD lv_var.
  PERFORM fd_makt.

end-of-PAGE.
  ULINE.
  WRITE: 45 'PAGE NUMBER', sy-pagno COLOR 7 , 'Ends Here'.

*&---------------------------------------------------------------------*
*&      Form  FD_MARA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fd_mara .
  SELECT matnr
         mbrsh
         mtart
         ersda
         ernam
         matkl
    FROM mara INTO TABLE it_mara
    WHERE matnr IN s_matnr.

  IF sy-subrc = 0.
    SORT it_mara BY matnr.
  ELSE.
    MESSAGE 'Material does not exist.' TYPE 'E'.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  FD_MAKT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fd_makt .
  SELECT matnr, spras, maktx FROM makt INTO @DATA(wa_makt)
    WHERE matnr = @wa_mara-matnr.
  ENDSELECT.

  ULINE.
  WRITE:  'Material Number      : ' COLOR 6, wa_makt-matnr,
        / 'Language             : ' COLOR 7, wa_makt-spras,
        / 'Material Description : ' COLOR 5, wa_makt-maktx.
  ULINE.
ENDFORM.
