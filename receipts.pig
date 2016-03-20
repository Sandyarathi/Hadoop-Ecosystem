A = LOAD '/user/user01/pig/receipts.txt' USING PigStorage(' ') AS (year,x,y,delta:int,rest);
B = GROUP A ALL;
mystats = FOREACH B {
   minrecords = ORDER A BY delta;
   minrecord = LIMIT minrecords 1;
   maxrecords = ORDER A BY delta DESC;
   maxrecord = LIMIT maxrecords 1;
   GENERATE FLATTEN(minrecord.year) as minyear,FLATTEN(minrecord.delta) as mindelta, FLATTEN(maxrecord.year) as maxyear, FLATTEN(maxrecord.delta) as maxdelta, FLATTEN(AVG(A.delta)) as avgdelta;
};
DUMP mystats;