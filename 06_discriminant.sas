TITLE 'Group Project: Discriminant Analysis on Olive Oil';

PROC IMPORT DATAFILE='/home/u64436333/olive.csv' OUT=oil DBMS=CSV REPLACE;
   GETNAMES=YES;
   GUESSINGROWS=MAX;
RUN;


PROC DISCRIM DATA=oil POOL=TEST CROSSVALIDATE;
   CLASS region;
   VAR palmitic palmitoleic stearic oleic linoleic linolenic arachidic eicosenoic;
   TITLE 'Discriminant Analysis';
RUN;


PROC DISCRIM DATA=oil POOL=TEST CROSSVALIDATE;
   CLASS area;
   VAR palmitic palmitoleic stearic oleic linoleic linolenic arachidic eicosenoic;
   TITLE 'Discriminant analysis — nine-area classification';
RUN;
