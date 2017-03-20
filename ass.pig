sensor = LOAD 'cliu9/IWZ_Sensor_List_sample.csv' USING PigStorage(',') AS (direction:int,sensorname:chararray,group:chararray);

speed = LOAD 'cliu9/20161231.csv' USING PigStorage(',') AS (sensorname:chararray,date:chararray,hour:int,minute:int,speed:float,count:int,occupancy:float);

speednew = JOIN speed BY sensorname, sensor BY sensorname;

speednew1 = FOREACH speednew GENERATE speed::sensorname, speed::date, speed::hour, speed::minute, speed::speed, speed::count, sensor::direction, sensor::group;

--- extact sensors of direction 1 and group 1t

speed1t1 = FILTER speednew1 BY (direction==1 and group=='1t');

-- save the result
STORE speed1t1 INTO 'cliu9/ass3' USING PigStorage(',');

