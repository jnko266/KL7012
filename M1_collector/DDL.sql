-- Stores mapping of SQL day number to day name (i.e. 0 = Sunday, 1 = Monday, etc.)
CREATE TABLE day_of_week_mapping (
	day_number INTEGER NOT NULL,
	day_name TEXT NOT NULL,
	CONSTRAINT day_of_week_mapping_pk PRIMARY KEY (day_number)
);
INSERT INTO day_of_week_mapping (day_number,day_name) VALUES
	(0,'Sunday'),
	(1,'Monday'),
	(2,'Tuesday'),
	(3,'Wednesday'),
	(4,'Thursday'),
	(5,'Friday'),
	(6,'Saturday');


-- Stores the order in which junctions are to be displayed in the R analysis
CREATE TABLE junction_order (
	junction_name TEXT NOT NULL,
	junction_order_direction TEXT NOT NULL,
	junction_order INTEGER NOT NULL,
	CONSTRAINT junction_order_pk PRIMARY KEY (junction_name,junction_order_direction)
);
CREATE UNIQUE INDEX junction_order_junction_order_direction_IDX ON junction_order (junction_order_direction,junction_order);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J1','NB',1),
	('J2','NB',2),
	('J4','NB',3),
	('J5','NB',4),
	('J6','NB',5),
	('J6A','NB',6),
	('J7','NB',7),
	('J8','NB',8),
	('J9','NB',9),
	('J10','NB',10);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J11','NB',11),
	('J11A','NB',12),
	('J12','NB',13),
	('J13','NB',14),
	('J14','NB',15),
	('J15','NB',16),
	('J15A','NB',17),
	('J16','NB',18),
	('J17','NB',19),
	('J18','NB',20);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J19','NB',21),
	('J20','NB',22),
	('J21','NB',23),
	('J21A','NB',24),
	('J22','NB',25),
	('J23','NB',26),
	('J23A','NB',27),
	('J24','NB',28),
	('J24A','NB',29),
	('J25','NB',30);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J26','NB',31),
	('J27','NB',32),
	('J28','NB',33),
	('J29','NB',34),
	('J29A','NB',35),
	('J30','NB',36),
	('J31','NB',37),
	('J32','NB',38),
	('J33','NB',39),
	('J34','NB',40);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J35','NB',41),
	('J35A','NB',42),
	('J36','NB',43),
	('J37','NB',44),
	('J38','NB',45),
	('J39','NB',46),
	('J40','NB',47),
	('J41','NB',48),
	('J42','NB',49),
	('J43|44','NB',50);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J45','NB',51),
	('J46','NB',52),
	('J47','NB',53),
	('J48','NB',54),
	('J1','SB',54),
	('J2','SB',53),
	('J4','SB',52),
	('J5','SB',51),
	('J6','SB',50),
	('J6A','SB',49);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J7','SB',48),
	('J8','SB',47),
	('J9','SB',46),
	('J10','SB',45),
	('J11','SB',44),
	('J11A','SB',43),
	('J12','SB',42),
	('J13','SB',41),
	('J14','SB',40),
	('J15','SB',39);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J15A','SB',38),
	('J16','SB',37),
	('J17','SB',36),
	('J18','SB',35),
	('J19','SB',34),
	('J20','SB',33),
	('J21','SB',32),
	('J21A','SB',31),
	('J22','SB',30),
	('J23','SB',29);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J23A','SB',28),
	('J24','SB',27),
	('J24A','SB',26),
	('J25','SB',25),
	('J26','SB',24),
	('J27','SB',23),
	('J28','SB',22),
	('J29','SB',21),
	('J29A','SB',20),
	('J30','SB',19);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J31','SB',18),
	('J32','SB',17),
	('J33','SB',16),
	('J34','SB',15),
	('J35','SB',14),
	('J35A','SB',13),
	('J36','SB',12),
	('J37','SB',11),
	('J38','SB',10),
	('J39','SB',9);
INSERT INTO junction_order (junction_name,junction_order_direction,junction_order) VALUES
	('J40','SB',8),
	('J41','SB',7),
	('J42','SB',6),
	('J43|44','SB',5),
	('J45','SB',4),
	('J46','SB',3),
	('J47','SB',2),
	('J48','SB',1);


-- Stores the configuration of time of day times for each run (i.e. 6:00 - 9:30 -> morning)
CREATE TABLE run_time_config (
	run_time_from INTEGER NOT NULL,
	run_time_to INTEGER NOT NULL,
	run_time_description TEXT NOT NULL, run_time_description_sorting INTEGER,
	CONSTRAINT run_time_config_pk PRIMARY KEY (run_time_from,run_time_to)
);
CREATE INDEX run_time_config_run_time_from_IDX ON run_time_config (run_time_from);
CREATE INDEX run_time_config_run_time_to_IDX ON run_time_config (run_time_to);
CREATE UNIQUE INDEX run_time_config_run_time_description_IDX ON run_time_config (run_time_description);
CREATE UNIQUE INDEX run_time_config_run_time_description_sorting_IDX ON run_time_config (run_time_description_sorting);
INSERT INTO run_time_config (run_time_from,run_time_to,run_time_description,run_time_description_sorting) VALUES
	(60000,93000,'morning',1),
	(110000,123000,'mid-day',2),
	(140000,153000,'afternoon',3),
	(160000,193000,'evening',4),
	(210000,233000,'night',5);


-- Transactional table
-- Stores information about each run (execution of the data collection script)
CREATE TABLE run (
	run_id TEXT NOT NULL,
	run_unix_timestamp NUMERIC NOT NULL, run_date INTEGER NOT NULL, run_time INTEGER NOT NULL,
	CONSTRAINT run_PK PRIMARY KEY (run_id)
);


-- Transactional table
-- Stores the actual speed readings on a junction-to-junction basis
CREATE TABLE speed_reading (
	speed_reading_run_id TEXT(36) NOT NULL,
	speed_reading_junction_from TEXT(5) NOT NULL,
	speed_reading_junction_to TEXT(5) NOT NULL,
	speed_reading_direction TEXT(20) NOT NULL,
	speed_reading NUMERIC NOT NULL,
	CONSTRAINT speed_reading_PK PRIMARY KEY (speed_reading_run_id,speed_reading_junction_from,speed_reading_junction_to),
	CONSTRAINT speed_reading_FK FOREIGN KEY (speed_reading_run_id) REFERENCES run(run_id)
);


-- Creates a view with formatted date and time fields of the "run" transactional table
CREATE VIEW v_run_fmt AS
SELECT
	r.run_id,
	r.run_unix_timestamp,
	r.run_date,
	strftime('%Y-%m-%d', substr(r.run_date, 1, 4) || '-' || substr(r.run_date, 5, 2) || '-' || substr(r.run_date, 7, 2)) run_date_fmt,
	dowm.day_number,
	dowm.day_name,
	r.run_time,
	substr(printf("%06d", r.run_time), 1, 2) || ':' ||
	substr(printf("%06d", r.run_time), 3, 2) || ':' ||
	substr(printf("%06d", r.run_time), 5, 2) run_time_fmt
FROM 
	run r
	JOIN day_of_week_mapping dowm ON strftime('%w', substr(r.run_date, 1, 4) || '-' || substr(r.run_date, 5, 2) || '-' || substr(r.run_date, 7, 2)) = dowm.day_number;


-- Creates a view with the time of day classification for each run
-- This is where exclusion occurs for runs that do not belong to any time of day classification
CREATE VIEW v_run_with_time_of_day AS
SELECT 
	r.*,
	rtc.run_time_description,
	rtc.run_time_description_sorting
FROM 
	v_run_fmt r
	JOIN run_time_config rtc ON r.run_time BETWEEN rtc.run_time_from AND rtc.run_time_to;


-- Creates a view showing average speed readings for each junction-to-junction section PER DAY
CREATE VIEW v_avg_speed_per_day AS
SELECT
	v_rwtod.run_date_fmt reading_date,
	v_rwtod.day_name day_of_week,
	sr.speed_reading_junction_from starting_junction,
	sr.speed_reading_junction_to finishing_junction,
	sr.speed_reading_direction direction,
	AVG(sr.speed_reading) average_speed,
	COUNT(*) reading_count
FROM 
	speed_reading sr
	JOIN v_run_with_time_of_day v_rwtod ON sr.speed_reading_run_id = v_rwtod.run_id
	LEFT JOIN junction_order jo ON sr.speed_reading_junction_from = jo.junction_name AND sr.speed_reading_direction = jo.junction_order_direction 
GROUP BY 
	v_rwtod.run_date,
	sr.speed_reading_junction_from,
	sr.speed_reading_junction_to,
	sr.speed_reading_direction
ORDER BY
	v_rwtod.run_date,
	sr.speed_reading_direction,
	jo.junction_order;


-- Creates a view showing average speed readings for each junction-to-junction section PER TIME OF DAY
CREATE VIEW v_avg_speed_per_time_of_day AS
SELECT
	v_rwtod.run_time_description time_of_day,
	sr.speed_reading_junction_from starting_junction,
	sr.speed_reading_junction_to finishing_junction,
	sr.speed_reading_direction direction,
	AVG(sr.speed_reading) average_speed,
	COUNT(*) reading_count
FROM 
	speed_reading sr
	JOIN v_run_with_time_of_day v_rwtod ON sr.speed_reading_run_id = v_rwtod.run_id
	LEFT JOIN junction_order jo ON sr.speed_reading_junction_from = jo.junction_name AND sr.speed_reading_direction = jo.junction_order_direction 
GROUP BY
	v_rwtod.run_time_description,
	sr.speed_reading_junction_from,
	sr.speed_reading_junction_to,
	sr.speed_reading_direction
ORDER BY
	sr.speed_reading_direction,
	v_rwtod.run_time_description_sorting,
	jo.junction_order;


-- Creates a view showing average speed readings for each junction-to-junction section PER DAY AND TIME OF DAY
CREATE VIEW v_avg_speed_per_day_and_time_of_day AS
SELECT
	v_rwtod.run_date_fmt reading_date,
	v_rwtod.day_name day_of_week,
	v_rwtod.run_time_description time_of_day,
	sr.speed_reading_junction_from starting_junction,
	sr.speed_reading_junction_to finishing_junction,
	sr.speed_reading_direction direction,
	AVG(sr.speed_reading) average_speed,
	COUNT(*) reading_count
FROM 
	speed_reading sr
	JOIN v_run_with_time_of_day v_rwtod ON sr.speed_reading_run_id = v_rwtod.run_id
	LEFT JOIN junction_order jo ON sr.speed_reading_junction_from = jo.junction_name AND sr.speed_reading_direction = jo.junction_order_direction 
GROUP BY 
	v_rwtod.run_date,
	v_rwtod.run_time_description,
	sr.speed_reading_junction_from,
	sr.speed_reading_junction_to,
	sr.speed_reading_direction
ORDER BY
	v_rwtod.run_date,
	sr.speed_reading_direction,
	v_rwtod.run_time_description_sorting,
	jo.junction_order;