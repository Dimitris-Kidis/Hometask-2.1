	--1. CREATE THE TABLE STRUCTURE FOR YOUR DATABASE ✅
	--2. USE PRIMARY KEYS TO ENFORCE UNIQUENESS (AND COMPOSITE PK) ✅
	--3. USE FOREIGN KEYS TO ENFORCE REFERENTIAL INTEGRITY ✅
	--4. USE NOT-NULL, DEFAULT AND UNIQUE CONSTRAINTS WHERE NECESSARY ✅
	--5. PROVIDE A SCRIPT CREATING THE DATABASE ✅
	--6. USE .SQLPROJ FOR CREATING SCRIPTS ✅
	--7. MANY TO MANY, ONE TO MANY, ONE TO ONE (ONE EXAMPLE) ✅


USE master;
GO
ALTER DATABASE SCHEDULE 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE SCHEDULE;



/*----------------------------CREATING A DB---------------------------------------------------*/



IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'SCHEDULE')
CREATE DATABASE SCHEDULE
GO
USE SCHEDULE;
GO

/*----------------------------DROPPING TABLES---------------------------------------------------*/



--DROP TABLE cd_collection
--DROP TABLE cd_disks
--DROP TABLE track_info
--DROP TABLE tracks
--DROP TABLE genre
--DROP TABLE author_info

--DROP TABLE cd_collection
--DROP TABLE cd_disks
--DROP TABLE track_info
--DROP TABLE tracks
--DROP TABLE genre
--DROP TABLE author_info



/*----------------------------CREATING TABLES---------------------------------------------------*/



--Создаем таблицу genre с первичным ключом Genre_code

CREATE TABLE genre(
    Genre_code TINYINT PRIMARY KEY,
    Genre_name NVARCHAR(50) NOT NULL,
    Genre_description NVARCHAR(100) NOT NULL
)



--Создаем таблицу cddisks с первичным ключом ID_disk

CREATE TABLE cd_disks(
    ID_disk INT PRIMARY KEY,
    Disk_name NVARCHAR(50) UNIQUE NOT NULL,
    Amount_of_tracks TINYINT CHECK(Amount_of_tracks > 0) NOT NULL,
    Disk_time NVARCHAR(12) NOT NULL,
    CD_release DATE NOT NULL DEFAULT '2000-07-05',
    Disk_price NUMERIC(10, 2) NOT NULL,
    Quantity_CD_disks BIGINT CHECK(Quantity_CD_disks > 0) NOT NULL
)



--Создаем таблицу author_info с первичным ключом Author_name

CREATE TABLE author_info(
    Author_ID NVARCHAR(50) PRIMARY KEY,
    Author_full_name NVARCHAR(100) NOT NULL,
    Author_info NVARCHAR(100) NOT NULL,
    Author_photo_file NVARCHAR(50) NOT NULL,
    Tracks_names NVARCHAR(100) NOT NULL
)



--Создаем таблицу tracks

CREATE TABLE tracks(
    Track_ID INT PRIMARY KEY,
    Track_name NVARCHAR(50) NOT NULL,
    Genre_code TINYINT FOREIGN KEY REFERENCES genre(Genre_code),
    Author_ID NVARCHAR(50) FOREIGN KEY REFERENCES author_info(Author_ID),
    Track_time NVARCHAR(15) NOT NULL
)



--Создаем таблицу track_info

CREATE TABLE track_info(
    Track_ID INT FOREIGN KEY REFERENCES tracks(Track_ID),
    Lyrics NVARCHAR(100) NOT NULL,
    Date_release DATE DEFAULT '2000-07-05',
    Track_language NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_tracks_and_info PRIMARY KEY(Track_ID)
)



--Создаем таблицу cd_collection с первичными ключами ID_disk, Track_ID и Track_Number

CREATE TABLE cd_collection(
    ID_disk INT FOREIGN KEY REFERENCES cd_disks(ID_disk),
    Track_ID INT FOREIGN KEY REFERENCES tracks(Track_ID),
    Track_number INT NOT NULL UNIQUE,
    CONSTRAINT PK_id_disk_author_name PRIMARY KEY(ID_disk, Track_ID)
)







/*----------------------------INSERTS---------------------------------------------------*/



--Заполняем таблицу genre

INSERT INTO genre
    (Genre_code, Genre_name, Genre_description)
VALUES
	(0,'RocknRoll','For RocknRoll lovers'),
	(1,'Jazz','For Jazz lovers'),
	(2,'R&B','For R&B lovers'),
	(3,'Hip Hop','For Hip Hop lovers'),
	(4,'Pop','For Pop lovers'),
	(5,'Rap','For Rap lovers'),
	(6,'Electronic','For Electronic lovers'),
	(7,'Folk','For Folk lovers'),
	(8,'Country','For Country lovers'),
	(9,'Blues','For Blues lovers')





--Заполняем таблицу cd_disks

INSERT INTO cd_disks
    (ID_disk, Disk_name, Amount_of_tracks, Disk_time, CD_release, Disk_price, Quantity_CD_disks)
VALUES 
	(0,'Album-2000', 10, '1h:26m:15s', '2021-03-01', 135.10, 25345),
	(1,'Album-2001', 17, '2h:13m:01s', '2021-03-02', 216.85, 13525),
	(2,'Album-2002', 12, '1h:45m:28s', '2021-03-03', 178.30, 8563),
	(3,'Album-2003', 8, '0h:47m:23s', '2021-03-04', 362.55, 422431),
	(4,'Album-2004', 23, '3h:02m:58s', '2021-03-05', 187.15, 32445),
	(5,'Album-2005', 14, '1h:56m:12s', '2021-03-06', 242.70, 64352),
	(6,'Album-2006', 5, '0h:20m:30s', '2021-03-07', 260.95, 422244),
	(7,'Album-2007', 25, '3h:17m:57s', '2021-03-08', 234.00, 535422),
	(8,'Album-2008', 13, '1h:58m:00s', '2021-03-09', 110.25, 597643),
	(9,'Album-2009', 18, '2h:36m:46s', '2021-03-10', 211.40, 112342)



  --Заполняем таблицу author_info

INSERT INTO author_info
    (Author_ID, Author_full_name, Author_Info, Author_photo_file, Tracks_names)
VALUES
	(0, 'John Legend', 'Info about John', 'john.png', 'Florida' ),
	(1, 'Michael Kors', 'Info about Michael', 'michael.png', 'Time' ),
	(2, 'Mason Whistley', 'Info about Mason', 'mason.png', 'Flow' ),
	(3, 'Jacob Mandela', 'Info about Jacob', 'jacob.png', 'Respect' ),
	(4, 'William Brown', 'Info about William', 'william.png', 'Ninja' ),
	(5, 'Ethan Sans', 'Info about Ethan', 'ethan.png', 'Cry' ),
	(6, 'Alex Burdou', 'Info about Alex', 'alex.png', 'The End' ),
	(7, 'Nataly Sanders', 'Info about Nataly', 'nataly.png', 'Run' ),
	(8, 'Celeste Birkins', 'Info about Celeste', 'celeste.png', 'Human' ),
	(9, 'Miranda Bella', 'Info about Miranda', 'miranda.png', 'Happy End' )



  --Заполняем таблицу tracks

INSERT INTO tracks
    (Track_ID, Track_name, Genre_code, Author_ID, Track_time)
VALUES
	(0, 'Florida', 0, 0, '03mins:05secs'),
	(1, 'Time', 1, 1, '01mins:25secs'),
	(2, 'Flow', 2, 2, '04mins:55secs'),
	(3, 'Respect', 3, 3, '02mins:30secs'),
	(4, 'Ninja', 4, 4, '02mins:15secs'),
	(5, 'Cry', 5, 5, '03mins:10secs'),
	(6, 'The End', 6, 6, '04mins:25secs'),
	(7, 'Run', 7, 7, '05mins:00secs'),
	(8, 'Human', 8, 8, '01mins:45secs'),
	(9, 'Happy End', 9, 9, '02mins:50secs')







    --Заполняем таблицу track_info

INSERT INTO track_info
    (Track_ID, Lyrics, Date_release, Track_language)
VALUES
	(0,'ht.ps://lyrics.com/0', '2021-01-02', 'English'),
	(1,'ht.ps://lyrics.com/1', '2021-01-03', 'French'),
	(2,'ht.ps://lyrics.com/2', '2021-01-04', 'Russian'),
	(3,'ht.ps://lyrics.com/3', '2021-01-05', 'German'),
	(4,'ht.ps://lyrics.com/4', '2021-01-06', 'Dutch'),
	(5,'ht.ps://lyrics.com/5', '2021-01-07', 'Spanish'),
	(6,'ht.ps://lyrics.com/6', '2021-01-08', 'Chinese'),
	(7,'ht.ps://lyrics.com/7', '2021-01-09', 'Japanese'),
	(8,'ht.ps://lyrics.com/8', '2021-01-10', 'Romanian'),
	(9,'ht.ps://lyrics.com/9', '2021-01-11', 'British')







--Заполняем таблицу cd_collection

INSERT INTO cd_collection
    (ID_disk, Track_ID, Track_number)
VALUES
  (0, 0, 0),
  (1, 1, 1),
  (2, 2, 2),
  (3, 3, 3),
  (4, 4, 4),
  (5, 5, 5),
  (6, 6, 6),
  (7, 7, 7),
  (8, 8, 8),
  (9, 9, 9)



