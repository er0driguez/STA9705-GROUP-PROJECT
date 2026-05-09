/* NOTE FOR TEAMMATES:
   Save the Olive Oil dataset locally to your SAS studio library of files
   Copy that path and place it in the DATAFILE="..." so you can use the data
*/

/* ============================================================
   STEP 2: Import the CSV file
   - DATAFILE: replace this with the filepath of your saved CSV
   - OUT: names the dataset "olive" in the temporary WORK library
   - DBMS=CSV: tells SAS the file is comma-separated
   - REPLACE: overwrites the dataset if you re-run the code
   - GETNAMES=YES: first row becomes the variable names
   ============================================================ */
PROC IMPORT 
    DATAFILE="/home/u64436288/sasuser.v94/Olive Oil Data Set.csv"
    OUT=WORK.olive
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

/* ============================================================
   STEP 3: Verify the import worked correctly
   - PROC CONTENTS: shows variable names, types, and structure
   - PROC PRINT: displays first 10 rows to visually check data
   - PROC MEANS: gives basic summary stats as a sanity check
   ============================================================ */
PROC CONTENTS DATA=WORK.olive; RUN;

PROC PRINT DATA=WORK.olive (OBS=10); RUN;

PROC MEANS DATA=WORK.olive; RUN;