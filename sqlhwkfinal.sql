#SQL FINAL PROJECT BY ARMENOUSH ASLANIAN-PERSICO

#PART 1 / CREATE DATABASE
DROP DATABASE IF EXISTS buildingenergy;
CREATE DATABASE `buildingenergy` /*!40100 DEFAULT CHARACTER SET utf8 */;

#PART 2 / CREATE ENERGY TABLES AND POPULATE TABLES
#TABLE 1 / ENERGY CATEGORIES
DROP TABLE IF EXISTS energycategories;
CREATE TABLE energycategories (	energycategoryid INT NOT NULL, energycategory VARCHAR(30));
INSERT INTO energycategories
VALUES
(1, "Fossil"),
(2, "Renewable");
SELECT * FROM energycategories;
#TABLE 2 / ENERGY TYPES
DROP TABLE IF EXISTS energytypes;
CREATE TABLE energytypes (energytypeid INT NOT NULL, energytype VARCHAR(20), energycategoryid INT NOT NULL);
INSERT INTO energytypes
VALUES
(1, "Electricity", 1), #Can't electricity come from renewable and fossil fuel sources?
(2, "Fuel Oil", 1),
(3, "Gas",1),
(4, "Steam", 1),
(5, "Solar", 2),
(6, "Wind", 2);
SELECT * FROM energytypes;

#PART 3 / WRITE JOIN STATEMENT FOR ENERGY TYPES AND ENERGY CATEGORIES
SELECT et.energytype, ec.energycategory
FROM energytypes et
LEFT JOIN energycategories ec
ON et.energycategoryid=ec.energycategoryid;

#PART 4 / CREATE BUILDINGS TABLE
#TABLE 3 / BUILDINGS
DROP TABLE IF EXISTS buildings;
CREATE TABLE buildings (rowid INT NOT NULL, buildingid INT NOT NULL, buildingname VARCHAR (40), energytypeid INT NOT NULL);
INSERT INTO buildings
VALUES
(1, 1, "Borough of Manhattan Community College", 1),
(2, 1, "Borough of Manhattan Community College", 4),
(3, 1, "Borough of Manhattan Community College", 5),
(4, 2, "Chrysler Building", 1),
(5, 2, "Chrysler Building", 4),
(6, 3, "Empire State Building", 1),
(7, 3, "Empire State Building", 3),
(8, 3, "Empire State Building", 4);
SELECT * FROM buildings
ORDER BY buildingid ASC, energytypeid ASC;

#PART 5 / WRITE JOIN STATEMENT FOR BUILDINGS AND ENERGY TYPES
SELECT b.buildingid, b.buildingname, et.energytype
FROM buildings b
LEFT JOIN energytypes et
ON b.energytypeid=et.energytypeid
ORDER BY b.buildingid ASC, et.energytypeid ASC;

#PART 6 / INSERT NEW VALUES INTO TABLES
INSERT INTO energytypes
VALUES
(7, "Geothermal", 2);
SELECT * FROM energytypes; #CHECK TO SEE IF INSERT WAS SUCCESSFUL

INSERT INTO buildings
VALUES
(9, 4, "Bronx Lion House", 7),
(10, 5, "Brooklyn Children's Museum", 1),
(11, 5, "Brooklyn Children's Museum", 7);
SELECT * FROM buildings; #CHECK TO SEE IF INSERT WAS SUCCESSFUL

#PART 7 / SHOW ONLY RENEWABLE ENERGY BUILDINGS
SELECT b.buildingid, b.buildingname, et.energytype, et.energycategoryid, ec.energycategory
FROM buildings b
LEFT JOIN energytypes et
ON b.energytypeid=et.energytypeid
LEFT JOIN energycategories ec
ON et.energycategoryid=ec.energycategoryid
WHERE et.energycategoryid=2
ORDER BY b.buildingid ASC, et.energytypeid ASC;


#PART 8 / SHOW COUNT OF ENERGY TYPES IN BUILDINGS
SELECT et.energytype AS 'Energy Type', COUNT(b.energytypeid) AS 'Frequency of Energy Type'
FROM buildings b
LEFT JOIN energytypes et
ON b.energytypeid=et.energytypeid
GROUP BY b.energytypeid
ORDER BY COUNT(b.energytypeid) DESC;

#PART 9A / CREATE FOREIGN KEY CONSTRAINTS
ALTER TABLE energycategories
ADD CONSTRAINT pk_energycategoryid PRIMARY KEY (energycategoryid),
ADD CONSTRAINT uc_energycategories UNIQUE (energycategory);

ALTER TABLE energytypes
ADD CONSTRAINT pk_energytypeid PRIMARY KEY (energytypeid),
ADD CONSTRAINT uc_energytypes UNIQUE (energytype);
/*
ALTER TABLE energytypes
ADD CONSTRAINT fk_energytypes #ERROR MESSAGE: COULD NOT INSERT FOREIGN KEY.
FOREIGN KEY (energycategoryid)
REFERENCES energycategories(energycateogryid);

ALTER TABLE buildings
ADD CONSTRAINT fk_buildings #ERROR MESSAGE: COULD NOT INSERT FOREIGN KEY.
FOREIGN KEY (energytypeid)
REFERENCES energytypes(energytypeid);
*/

#PART 9D / TRACK ENERGY CHANGES OVER TIME
#NOTE: SEPARATE CALCULATIONS MUST BE DONE TO DETERMINE PERCENT OF TOTAL BUILDING BTUS DRAWN FROM EACH ENERGY SOURCE
#ALL UNITS OF ENERGY MUST BE CONVERTED TO BTUS TO EQUALIZE ACROSS ENERGY TYPES
#ALL ENERGY TYPE BTU AMOUNTS MUST BE CONVERTED TO A PERCENTAGE OF EACH BUILDING'S TOTAL ENERGY CONSUMPTION
DROP TABLE IF EXISTS tbuildingenergy;
CREATE TABLE tbuildingenergy
(trowid INT NOT NULL, 
tbuildingid INT NOT NULL, 
tenergytypeid INT NOT NULL,
tbillyear YEAR,
tpercentBTUsfromsource INT); 

INSERT INTO tbuildingenergy
VALUES
(1,1,1,2014,60),
(2,1,2,2014,30),
(3,1,3,2014,10),
(4,1,1,2015,60),
(5,1,2,2015,25),
(6,1,3,2015,15),
(7,2,1,2014,90),
(8,2,2,2014,5),
(9,2,3,2014,5),
(10,2,1,2015,80),
(11,2,2,2015,10),
(12,2,3,2015,10),
(13,3,1,2014,90),
(14,3,2,2014,5),
(15,3,3,2014,5),
(16,3,1,2015,80),
(17,3,2,2015,10),
(18,3,3,2015,10);

DROP TABLE IF EXISTS tbuildingnames;
CREATE TABLE tbuildingnames (tbuildingid INT NOT NULL, tbuildingname VARCHAR(40));
INSERT INTO tbuildingnames
VALUES
(1,"David Dinkins Municipal Building"),
(2,"City Hall"),
(3,"Brooklyn Borough Hall");

DROP TABLE IF EXISTS tenergytypes;
CREATE TABLE tenergytypes (tenergytypeid INT NOT NULL, tenergytype VARCHAR(30));
INSERT INTO tenergytypes
VALUES
(1,"Electricity, Non-Renewable"),
(2, "Fuel"),
(3, "Solar");

SELECT tbe.*, tet.*, tbn.* 
FROM tbuildingenergy tbe
LEFT JOIN tenergytypes tet
ON tbe.tenergytypeid=tet.tenergytypeid
LEFT JOIN tbuildingnames tbn
ON tbe.tbuildingid=tbn.tbuildingid
ORDER BY tbe.tbillyear ASC, tbe.tbuildingid ASC, tbe.tpercentBTUsfromsource DESC;

#SHOW CHANGES IN ENERGY TYPE OVER TIME
SELECT tbe.tbillyear as 'Year', tbe.tenergytypeid AS 'Energy Type ID',tet.tenergytype AS 'Energy Type', ROUND(AVG(tbe.tpercentBTUsfromsource),2) AS 'Average Percent BTUs from source'
FROM tbuildingenergy tbe
LEFT JOIN tenergytypes tet
ON tbe.tenergytypeid=tet.tenergytypeid
GROUP BY tbe.tbillyear, tbe.tenergytypeid
ORDER BY tbe.tbillyear, tbe.tenergytypeid;
