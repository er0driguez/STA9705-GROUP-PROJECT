/* DATA */

PROC IMPORT 
    DATAFILE="/home/u64442666/STA9705/Course Project/Olive Oil Data Set.csv"
    OUT=WORK.olive
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.olive;
RUN;

/* Standardize chemical composition variables to mean=0, SD=1 */

proc standard data=WORK.olive out=WORK.olive mean=0 std=1;
  var palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
run;

proc print data=WORK.olive;
run;

/* REGION LEVEL */

/* LDA */

TITLE 'LDA - Region';
PROC DISCRIM DATA= WORK.olive POOL=yes CROSSVALIDATE; 
   CLASS region;
   VAR palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic; 
   PRIORS proportional;
RUN;

/* QDA */ 

TITLE 'QDA - Region';
PROC DISCRIM DATA= WORK.olive POOL=no LIST CROSSVALIDATE; 
   CLASS region;
   VAR palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
   PRIORS proportional; 
RUN;

/* KNN */

TITLE 'KNN - Region';
PROC DISCRIM DATA= WORK.olive LIST POOL=yes METHOD=npar k=4 CROSSVALIDATE;
   CLASS region;
   VAR palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
   PRIORS proportional;
RUN;

/* AREA LEVEL */

/* LDA */

TITLE 'LDA - Area';
PROC DISCRIM DATA= WORK.olive POOL=yes CROSSVALIDATE; 
   CLASS area;
   VAR palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic; 
   PRIORS proportional;
RUN;

/* QDA */ 

TITLE 'QDA - Area';
PROC DISCRIM DATA= WORK.olive POOL=no LIST CROSSVALIDATE; /*QDA*/
   CLASS area;
   VAR palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
   PRIORS proportional; 
RUN;

/* KNN */

TITLE 'KNN - Area';
PROC DISCRIM DATA= WORK.olive LIST POOL=yes METHOD=npar k=4 CROSSVALIDATE;
   CLASS area;
   VAR palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
   PRIORS proportional;
RUN;
