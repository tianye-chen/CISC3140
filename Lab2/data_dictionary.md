# Tianye Chen CISC3142 Lab 2 Database
## Cars

|cid |name| type| notnull| dflt_value| pk
|--|--|--|--|--|--|
|0|Timestamp|TIMESTAMP|0||0|
|1|Email|text|0||0|
|2|Name|text|0||0|
|3|Year|int|0||0|
|4|Make|text|0||0|
|5|Model|text|0||0|
|6|Car_ID|int|1||1|
|7|Judge_ids|int|0||0|

## Car_Score

cid|name|type|notnull|dflt_value|pk
|--|--|--|--|--|--|
0|Car_ids|int|1||1
1|Racer_Turbo|int|0||0
2|Racer_Supercharged|int|0||0
3|Racer_Performance|int|0||0
4|Racer_Horsepower|int|0||0
5|Car_Overall|int|0||0
6|Engine_Modifications|int|0||0
7|Engine_Performance|int|0||0
8|Engine_Chrome|int|0||0
9|Engine_Detailing|int|0||0
10|Engine_Cleanliness|int|0||0
11|Body_Frame_Undercarriage|int|0||0
12|Body_Frame_Suspension|int|0||0
13|Body_Frame_Chrome|int|0||0
14|Body_Frame_Detailing|int|0||0
15|Body_Frame_Cleanliness|int|0||0
16|Mods_Paint|int|0||0
17|Mods_Body|int|0||0
18|Mods_Wrap|int|0||0
19|Mods_Rims|int|0||0
20|Mods_Interior|int|0||0
21|Mods_Other|int|0||0
22|Mods_ICE|int|0||0
23|Mods_Aftermarket|int|0||0
24|Mods_WIP|int|0||0
25|Mods_Overall|int|0||0

## Judges

cid|name|type|notnull|dflt_value|pk
|--|--|--|--|--|--|
0|Car_ids|int|1||0
1|Judge_ID|int|0||0
2|Judge_Name|text|0||0
3|Car_Judged|int|0||0
4|Start_Time|TIMESTAMP|0||0
5|End_Time|TIMESTAMP|0||0
6|Mins_Spent|int|0||0
7|Avg_Spd|int|0||0

## Car_Total

cid|name|type|notnull|dflt_value|pk
|--|--|--|--|--|--|
0|Car_ids||0||1
1|Total|int|0||0