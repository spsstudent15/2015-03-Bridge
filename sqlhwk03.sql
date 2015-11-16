#HWK3 BY ARMENOUSH ASLANIAN-PERSICO
DROP TABLE IF EXISTS tblUsers;
DROP TABLE IF EXISTS tblRooms;
DROP TABLE IF EXISTS tblGroups;
DROP TABLE IF EXISTS tblUsersGroups;
DROP TABLE IF EXISTS tblRoomsGroups;


CREATE TABLE tblUsers (userid INT, username VARCHAR(15));
INSERT INTO tblUsers
VALUES (01, "Modesto");
INSERT INTO tblUsers
VALUES (02, "Ayine");
INSERT INTO tblUsers
VALUES (03, "Christopher");
INSERT INTO tblUsers
VALUES (04, "Cheong");
INSERT INTO tblUsers
VALUES (05, "Saulat");
INSERT INTO tblUsers
VALUES (06, "Heidy");

CREATE TABLE tblRooms (roomid INT, roomname VARCHAR(15));
INSERT INTO tblRooms
VALUES (01, "101");
INSERT INTO tblRooms
VALUES (02, "102");
INSERT INTO tblRooms
VALUES (03, "Auditorium A");
INSERT INTO tblRooms
VALUES (04, "Auditorium B");


CREATE TABLE tblGroups (groupid INT, groupname VARCHAR(15));
INSERT INTO tblGroups
VALUES (01, "IT");
INSERT INTO tblGroups
VALUES (02, "Sales");
INSERT INTO tblGroups
VALUES (03, "Administration");
INSERT INTO tblGroups
VALUES (04, "Operations");

CREATE TABLE tblUsersGroups (userid INT, groupid INT);
INSERT INTO tblUsersGroups
VALUES 
(01, 01), 
(02, 01),
(03, 02),
(04, 02),
(05, 03),
(06, NULL);

CREATE TABLE tblRoomsGroups (roomid INT, groupid INT);
INSERT INTO tblRoomsGroups
VALUES 
(01,01),
(02,01),
(02,02),
(03,02),
(04,NULL);

SELECT * FROM tblUsers;
SELECT * FROM tblRooms;
SELECT * FROM tblGroups;
SELECT * FROM tblUsersGroups;
SELECT * FROM tblRoomsGroups;

SELECT 
tblGroups.groupid, 
tblGroups.groupname,
#tblUsersGroups.groupid,
tblUsersGroups.userid,
tblUsers.username
FROM tblGroups
LEFT JOIN tblUsersGroups
ON  tblGroups.groupid=tblUsersGroups.groupid
LEFT JOIN tblUsers
ON tblUsersGroups.userid=tblUsers.userid;

SELECT 
tblRooms.roomid,
tblRooms.roomname,
#tblRoomsGroups.roomid,
tblRoomsGroups.groupid,
tblGroups.groupname
FROM tblRooms
LEFT JOIN tblRoomsGroups
ON  tblRooms.roomid=tblRoomsGroups.roomid
LEFT JOIN tblGroups
ON tblRoomsGroups.groupid=tblGroups.groupid;

SELECT
tblUsers.userid,
tblUsers.username,
tblGroups.groupid, 
tblGroups.groupname,
tblRooms.roomid,
tblRooms.roomname
FROM tblUsers
LEFT JOIN tblUsersGroups
ON tblUsersGroups.userid=tblUsers.userid
LEFT JOIN tblGroups
ON tblUsersGroups.groupid=tblGroups.groupid
LEFT JOIN tblRoomsGroups
ON tblRoomsGroups.groupid=tblGroups.groupid
LEFT JOIN tblRooms
ON tblRooms.roomID=tblRoomsGroups.roomID
ORDER BY tblUsers.username, tblGroups.groupname, tblRooms.roomname;
#if each user belongs to only one group, isn't it unneccessary to sort alphabetically by group name here?