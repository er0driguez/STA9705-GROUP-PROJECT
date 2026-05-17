/* Data Import */

PROC IMPORT 
    DATAFILE="/home/u64442666/STA9705/Course Project/Olive Oil Data Set.csv"
    OUT=WORK.olive
    DBMS=CSV
    REPLACE;
    GETNAMES=YES;
RUN;

/* Standardize chemical composition variables to mean=0, SD=1 */

proc standard data=WORK.olive out=WORK.olive mean=0 std=1;
  var palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
run;

proc print data=WORK.olive;
run;


proc princomp data=WORK.oliven out=ProPC noprint; 
  var palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
run;


proc sgplot data=ProPC;
  scatter y=prin2 x=prin1/datalabel=region;
run;


/*  Method 1: K-Means Clustering - Random Initial Seeds */


proc fastclus data=WORK.olive maxc=3 replace=random maxiter=15 radius=1 out=Clus_out;
  var palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
  id region;
run;

proc sort data=Clus_out;
  by cluster distance;
run;

proc print data=Clus_out;
  var region cluster distance;
run;


proc freq data=Clus_out;		/* Method 1 - Validation Matrix */
   tables cluster * region / norow nocol nopercent;
run;

/* Method 2: K-Means Clustering - First 3 Observations */

proc fastclus data=WORK.olive radius=1 maxc=3 replace=none maxiter=20 out=Clus_out_2; 
  var palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
  id region;
run;

proc sort data=Clus_out_2;
  by cluster distance;
run;

proc print data=Clus_out_2;
  var region cluster distance;
run;


proc freq data=Clus_out_2;		/* Method 2 - Validation Matrix */
   tables cluster * region / norow nocol nopercent;
run;


/* Method 3 - Average Linkage Centroids as Seeds */


/* 1. Hierarchical clustering using row_id to avoid errors in SAS */

data WORK.olive;
   set WORK.olive;
   row_id = _N_; 
run;

proc cluster data=WORK.olive method=average outtree=ProTree nonorm; 
   var palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
   id row_id; 
run;

/* 2. Cut the tree into 3 clusters (Outputs only row_id and cluster) */
proc tree data=ProTree nclusters=3 out=Tree_out noprint;
   id row_id;
run;

/* 3. Sort tree output by row_id */
proc sort data=Tree_out; by row_id; run;

/* 4. Sort main data by row_id */
proc sort data=WORK.olive; by row_id; run;

/* 5. Merge assignments back to create newdata_2 safely */
data WORK.newdata_2;
   merge WORK.olive Tree_out;
   by row_id;
run;

/* 6. Sort data by cluster before running proc means */
proc sort data=WORK.newdata_2;
   by cluster;
run;

/* 7. Print to check cluster variables */
proc print data=WORK.newdata_2;
   var region cluster;
run;

/* 8. Calculate centroids and save them to Seeds dataset */
proc means data=WORK.newdata_2 noprint;
   by cluster;
   var palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
   output out=WORK.Seeds mean=palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic; 
run;

/* 9. Use seeds dataset for k-means */
proc fastclus data=WORK.olive maxc=3 maxiter=50 seed=WORK.Seeds out=Clus_out_3; 
   var palmitic palmitoleic stearic oleic linoleic arachidic eicosenoic;
   id row_id;
run;

/* 10. Sort and print final k-means results */
proc sort data=Clus_out_3;
	by cluster distance;
run;

proc print data=Clus_out_3;
   var region cluster distance;
run;

proc freq data=Clus_out_3;		/* Method 3 - Validation Matrix */
   tables cluster * region / norow nocol nopercent;
run;
