.mode csv
.headers ON

CREATE TABLE Cars(Timestamp TIMESTAMP, Email text, Name text, Year int, Make text, Model text, Car_ID int not null primary key, Judge_ids int);

CREATE TABLE Judges (Car_ids int not null, Judge_ID int , Judge_Name text);

CREATE TABLE Car_Score(Car_ids int not null primary key, Racer_Turbo int, Racer_Supercharged int, Racer_Performance int, Racer_Horsepower int, Car_Overall int, Engine_Modifications int, Engine_Performance int, Engine_Chrome int, Engine_Detailing int, Engine_Cleanliness int, Body_Frame_Undercarriage int, Body_Frame_Suspension int, Body_Frame_Chrome int, Body_Frame_Detailing int, Body_Frame_Cleanliness int, Mods_Paint int, Mods_Body int, Mods_Wrap int, Mods_Rims int, Mods_Interior int, Mods_Other int, Mods_ICE int, Mods_Aftermarket int, Mods_WIP int, Mods_Overall int);

CREATE TABLE Car_Total (Car_ids primary key, Total int);

.import --skip 1 ./cars.csv Cars
.import --skip 1 ./judges.csv Judges
.import --skip 1 ./car_score.csv Car_Score

INSERT INTO Car_Total (Car_ids, Total)
    select Car_ids, (Racer_Turbo + Racer_Supercharged + Racer_Performance + Racer_Horsepower + Car_Overall + Engine_Modifications + Engine_Performance + Engine_Chrome + Engine_Detailing + Engine_Cleanliness + Body_Frame_Undercarriage + Body_Frame_Suspension + Body_Frame_Chrome + Body_Frame_Detailing + Body_Frame_Cleanliness + Mods_Paint + Mods_Body + Mods_Wrap + Mods_Rims + Mods_Interior + Mods_Other + Mods_ICE + Mods_Aftermarket + Mods_WIP + Mods_Overall) as Total from Car_Score;

.output extract1.csv
SELECT 
    Timestamp,Email,Name,Year,Make,Model,Car_ID,Judge_ID,Judge_Name,Racer_Turbo,Racer_Supercharged,Racer_Performance,Racer_Horsepower,Car_Overall,Engine_Modifications,Engine_Performance,Engine_Chrome,Engine_Detailing,Engine_Cleanliness,Body_Frame_Undercarriage,Body_Frame_Suspension,Body_Frame_Chrome,Body_Frame_Detailing,Body_Frame_Cleanliness,Mods_Paint,Mods_Body,Mods_Wrap,Mods_Rims,Mods_Interior,Mods_Other,Mods_ICE,Mods_Aftermarket,Mods_WIP,Mods_Overall, Total,
    DENSE_RANK () OVER (
        ORDER BY Total DESC
    ) Ranks
    FROM Cars 
        INNER JOIN Judges ON Judges.Car_ids = Cars.Car_ID 
        INNER JOIN Car_Score ON Car_Score.Car_ids = Cars.Car_ID 
        INNER JOIN Car_Total ON Car_Total.Car_ids = Cars.Car_ID;

.output extract2.csv
SELECT * FROM ( 
    SELECT 
        Email, Name, Year, Make, Model, Car_ID, Total, 
        row_number() OVER(PARTITION BY Make ORDER BY Total DESC ) AS Ranking FROM Cars
    INNER JOIN Car_Total ON Car_Total.Car_ids = Cars.Car_ID ) ranks 
    WHERE Ranking <= 3;

.output extract3.csv

ALTER TABLE Judges
    ADD COLUMN Car_Judged int;

ALTER TABLE Judges
    ADD COLUMN Start_Time TIMESTAMP;

ALTER TABLE Judges
    ADD COLUMN End_Time TIMESTAMP;

ALTER TABLE Judges
    ADD COLUMN Mins_Spent int;

ALTER TABLE Judges
    ADD COLUMN Avg_Spd int;

UPDATE Judges SET Car_Judged = ( 
    SELECT
        B.Car_Judged
    FROM 
        Judges A,
        (SELECT Judge_Name, count(*) AS Car_Judged FROM Judges GROUP BY Judge_Name) B
        WHERE A.Judge_Name = B.Judge_Name
        AND A.Judge_Name = Judges.Judge_Name
);

UPDATE Judges SET Start_Time = (
    SELECT
        ranks.Timestamp FROM Cars A,(
            SELECT
                *, 
                row_number()OVER(PARTITION BY Timestamp ORDER BY Timestamp) AS Ranking FROM Cars 
        ) ranks 
        WHERE Ranking = 1 
        AND A.Judge_ids = ranks.Judge_ids 
        AND A.Judge_ids = Judges.Judge_ID
);

UPDATE Judges SET End_Time = (
    SELECT
        ranks.Timestamp FROM Cars A,(
            SELECT
                *, 
                row_number()OVER(PARTITION BY Timestamp ORDER BY Timestamp) AS Ranking FROM Cars
        ) ranks 
        WHERE Ranking = 1
        AND A.Judge_ids = ranks.Judge_ids 
        AND A.Judge_ids = Judges.Judge_ID
        ORDER BY ranks.Timestamp DESC
);

Update Judges SET Mins_Spent = (
    SELECT CAST((JULIANDAY(End_Time) - JULIANDAY(Start_Time)) * 24 * 60 AS INTEGER) FROM Judges A
    WHERE A.Judge_ID = Judges.Judge_ID
);

Update Judges SET Avg_Spd = (
    SELECT ROUND(((Mins_Spent * 1.0) / Car_Judged),2) FROM Judges A
    WHERE A.Judge_ID = Judges.Judge_ID
);

SELECT * FROM Judges;