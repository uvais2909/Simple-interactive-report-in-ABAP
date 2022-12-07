# Simple-interactive-report-in-ABAP
A simple interactive report using some reporting events in ABAP.

Hi everyone, we will see that how can we create a simple interactive report in ABAP.
As we know that reports are the one of most important parts for a business. SAP has provided many libraries like REUSE to make reports and also we have object oriented approches to make reports easily but for now, we will only focus on some reporting events and how can we make our report interactive.

First create an executable program using SE38.

## Create a structure, Internal table and work area.
First we have to do the declarations. I have created a structure type named TY_MARA with the fields:
1.matnr   (MATERIAL NUMBER)
2.mbrsh   (INDUSTRY SECTOR)
3.mtart   (MATERIAL TYPE)
4.ersda   (CREATED ON)
5.ernam   (PERSON WHO CREATED THE OBJECT)
6.matkl   (MATERIAL GROUP)

MARA is the table which has data for these fields.

Then i have declared an internal table | IT_MARA | and a work-area | WA_MARA | also two variables S_VAR for select-options and LV_VAR for our sub-report. 

## Use select-options for input from user
select-options used for taking input in the form of range. You can check syntax from code file.

## TOP-OF-PAGE
This event is basically used when you want to display headings.
Used this events to show column names.

## START-OF-SELECTION
Here, you can perform fetching of the data from table and store them into internal table. 
I have created a subroutine and write all the fetching logic in it.

## END-OF-SELECTION
Here you can write the code to display data as output after fetching.
I have put a loop on internal table and display it using only write statement.
also I have used a keyword HOTSPOT for MATNR field, It will create a hyperlink to jump into sub-report.
I have used HIDE keyword to store the value of particular MATNR and behalf of this MATNR our sub-report will show MATERIAL DESCRIPTION for that MATNR.

## AT LINE-SELECTION
Used to perform some specific tasks for a line at selection screen.
When user will click on a particular MATNR, First system will capture the value of that MATNR and jump to this event and perform all the tasks related to that MATNR.
I have created a subroutine which is fetching MAKTX : material description, SPRAS : language from MAKT table and will display these as a sub-report.

## END-OF-PAGE
This event acts as footer for a page. Here i have used a system variable SY-PAGNO to display the current page number.
To trigger this event, we have to tell the system that a page will contain 10 records or 20 records.
To do this, in the first line we have to use keyword LINE-COUNT <Number of records>.
Check the syntax from file.

# RESULT
![image](https://user-images.githubusercontent.com/98871199/206196686-b1c82a66-280a-4b6e-8766-0ddbd1caae8c.png)

![image](https://user-images.githubusercontent.com/98871199/206196795-ffe47c69-33e5-4dcf-baa9-5cafcf1e9b50.png)

# Clicked on a material number
![image](https://user-images.githubusercontent.com/98871199/206197010-7c1b0b5b-4b32-44a8-aada-75e88f8413ce.png)

NOTE: I have used GET CURSOR FIELD keyword to store the clicked fields name. You can use IF ELSE statement to display different outputs like
IF VAR = 'MATNR'.
do someting....
ELSEIF VAR = 'MBRSH'.
do something.....
ENDIF.

Thanks! 
