TITLE 'Group Project Final: PCA on Olive Oil';

PROC IMPORT DATAFILE='/home/u64436333/olive.csv' OUT=oil DBMS=CSV REPLACE;
   GETNAMES=YES;
   GUESSINGROWS=MAX;
RUN;


PROC FACTOR DATA=oil METHOD=PRIN  plots(ncomp = 2)=score(ellipse);
   VAR palmitic palmitoleic stearic oleic linoleic linolenic arachidic eicosenoic;
   TITLE 'Step 1: PCA diagnostics for choosing m';
RUN;


PROC FACTOR DATA=oil METHOD=PRIN 
            NFACTORS=2
            ROTATE=VARIMAX
            CORR MSA RESIDUALS
            PLOTS=(LOADINGS);
   VAR palmitic palmitoleic stearic oleic linoleic linolenic arachidic eicosenoic;
   TITLE 'Step 2: PCA m=2, varimax rotation';
RUN;


PROC FACTOR DATA=oil METHOD=PRIN PRIORS=ONE
            NFACTORS=2
            ROTATE=VARIMAX
            OUT=oil_scores
            NOPRINT;
   VAR palmitic palmitoleic stearic oleic linoleic linolenic arachidic eicosenoic;
RUN;


PROC SGPLOT DATA=oil_scores;
   SCATTER X=Factor1 Y=Factor2 / GROUP=region MARKERATTRS=(SYMBOL=CircleFilled);
   TITLE 'PC1 vs PC2 by region';
   XAXIS LABEL='PC1';
   YAXIS LABEL='PC2';
RUN;
