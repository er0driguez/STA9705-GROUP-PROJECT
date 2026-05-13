/* MANOVA TEST */
/* PURPOSE: Test whether fatty acid profiles differ significantly
            across olive oil regions using MANOVA 					*/

/* STEP 1: Re-import the data - Update the DATAFILE path to match your file location */
PROC IMPORT 
    DATAFILE="/home/u64436288/sasuser.v94/Olive Oil Data Set.csv"
    OUT=WORK.olive
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

/* STEP 2: Run the MANOVA with follow-up univariate tests
   - MEANS runs follow-up univariate tests to identify which
     fatty acids are driving the differences between regions
   - TUKEY performs Tukey's post-hoc test, comparing every pair
     of regions to see which specific pairs differ 				*/
PROC GLM DATA=WORK.olive;
    CLASS region;
    MODEL palmitic palmitoleic stearic oleic linoleic 
          linolenic arachidic eicosenoic = region;
    MANOVA H=region / PRINTE PRINTH MSTAT=EXACT;
    MEANS region / TUKEY;
RUN;
QUIT;