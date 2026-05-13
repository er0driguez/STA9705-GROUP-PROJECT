/* MULTIVARIATE REGRESSION */
/* PURPOSE: Quantify how regional origin predicts the fatty 
            acid composition of olive oil using multivariate
            linear regression								 */

/* STEP 1: Re-import the data - Update the DATAFILE path to match your file location */
PROC IMPORT 
    DATAFILE="/home/u64436288/sasuser.v94/Olive Oil Data Set.csv"
    OUT=WORK.olive
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

/* STEP 2: Create indicator variables for region
   - Southern Italy is the reference category (no dummy needed)
   - NorthernItaly = 1 if the observation is from Northern Italy, 0 otherwise
   - Sardinia = 1 if the observation is from Sardinia, 0 otherwise
   - When both dummies = 0, the observation is Southern Italy
 */

DATA WORK.olive_dummy;
    SET WORK.olive;
    NorthernItaly = (region = 'Northern Italy');
    Sardinia      = (region = 'Sardinia');
RUN;

/* STEP 3: Verify the dummy variables were created correctly with right counts */

PROC FREQ DATA=WORK.olive_dummy;
    TABLES region * NorthernItaly region * Sardinia / NOCOL NOROW NOPERCENT;
RUN;

/* STEP 4: Run the multivariate linear regression using PROC REG
   - NorthernItaly and Sardinia are the dummy predictors (X)
*/

PROC REG DATA=WORK.olive_dummy;
    MODEL palmitic palmitoleic stearic oleic linoleic
          linolenic arachidic eicosenoic = NorthernItaly Sardinia;
    OVERALL: MTEST / PRINT CANPRINT MSTAT=EXACT;
RUN;
QUIT;