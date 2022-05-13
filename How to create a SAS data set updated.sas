dm log 'clear';

libname amr 'E:\phc6081';

data amr.class;
input gender $ age weight height;
datalines;
M 10 50 120
M 11 45 135
F 12 40 121
M 15 55 120
F 13 45 122
;
proc print;
run;

proc import datafile= 'E:\phc6081\class.csv'
out= amr.classcsv
DBMS=csv
Replace;
Getnames=YES;
Datarow=2;
Guessingrows=Max;
run;

proc import datafile= 'E:\phc6081\class.xlsx'
out= amr.classexcel
DBMS=xlsx
Replace;
Getnames=YES;
Datarow=2;
run;

/* Removing the guessingrows statement made it work */

proc import datafile= 'E:\phc6081\class.txt'
out= amr.classtxt
DBMS=dlm
Replace;
Getnames=YES;
Datarow=2;
run;

/* The above code created a delimited dataset*/

/* The blow code worked for comma-delimited text files */

proc import datafile= 'E:\phc6081\class_comma.txt'
out= amr.classcommatxt
DBMS=dlm
Replace;
delimiter=',';
Getnames=YES;
Datarow=2;
run;

/* Finally the below code worked for the tab delimited version */

proc import datafile= 'E:\phc6081\class_tab.txt'
out= amr.classtabtxt
DBMS=dlm
Replace;
delimiter='';
Getnames=YES;
Datarow=2;
run;

/* Now, we move to the "infile" method */

data /*name of the dataset*/;
length /*optional - specifies the length of values and whether they are character or numeric*/
infile /*give the location and file name for the data to import*/;
input /*list variables and indicate if they are character or numeric*/;
run;

/* How to read a csv file into SAS */
/*

data= to name the SAS data set.
infile= to guide me where the original dataset is stored.
dsd= to reset the delimiter from a blank to a comma.
firstobs=2 means that you're telling SAS to leave the first row to the variables, whereas the values
of the observations will start from the second row.
input= tells SAS the variable names and their types. $ follows a categorical variable.

*/

data amr.class_csv_infile;
infile 'E:\phc6081\class.csv' dsd firstobs=2;
input gender $ age weight height;
run;

/* The above code can also work with dlm=',' instead of dsd */

data amr.class_csv_infile;
infile 'E:\phc6081\class.csv' dlm=',' firstobs=2;
input gender $ age weight height;
run;


/* Can I repeat the same infile method for a text file? */

data amr.class_text_infile;
infile 'E:\phc6081\class_tab.txt' dlm='' firstobs=2;
input gender $ age weight height;
run;

/* This code worked! */

data amr.class_comma_infile;
infile 'E:\phc6081\class_comma.txt' dlm=',' firstobs=2;
input gender $ age weight height;
run;

