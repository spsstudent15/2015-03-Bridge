#HWK2 BY ARMENOUSH ASLANIAN-PERSICO
DROP TABLE IF EXISTS videos;
DROP TABLE IF EXISTS reviews;

CREATE TABLE videos (viduniqueID INT, vidtitle VARCHAR(100), vidlen INT, vidurl VARCHAR(300));
INSERT	INTO videos 
VALUES (001, "Khan Academy Hour of Databases", 60, "https://www.khanacademy.org/computing/hour-of-code/hour-of-sql");
INSERT	INTO videos 
VALUES (002, "Introduction to MySQL Workbench", 12, "https://www.youtube.com/watch?v=RSHevYMwCVw");
INSERT	INTO videos 
VALUES (003, "Null Values", 6, "https://lagunita.stanford.edu/courses/DB/SQL/SelfPaced/courseware/ch-sql/seq-vid-null_values/");

CREATE TABLE reviews (viduniqueID INT, revuser VARCHAR(20), revrate INT, revcomment VARCHAR (100));
INSERT INTO reviews
VALUES (001, "Amy", 5, "Great intro tutorial.");
INSERT INTO reviews
VALUES (001, "Ben", 4, "Could have used more advanced lessons.");
INSERT INTO reviews
VALUES (002, "Ben", 4, "Good intro to Workbench.");
INSERT INTO reviews
VALUES (002, "Charlie", 4, "This video made me hungry.");
INSERT INTO reviews
VALUES (003, "Amy", 5, "Good intro to null values.");
INSERT INTO reviews
VALUES (003, "Charlie", 3, "This video made me sleepy.");


SELECT viduniqueID as 'Video ID', vidtitle as 'Title', vidlen as 'Minutes', vidurl as 'URL'
FROM videos;

SELECT viduniqueID as 'Video ID', revuser as 'Reviewer', revrate as 'Rating', revcomment as 'Comment'
FROM reviews;

SELECT 
	videos.viduniqueID as 'Video ID', 
	videos.vidtitle as 'Title', 
	videos.vidlen as 'Minutes', 
	videos.vidurl as 'URL', 
	reviews.revuser as 'Reviewer', 
	reviews.revrate as 'Rating', 
	reviews.revcomment as 'Comment'
FROM videos
INNER JOIN reviews
ON videos.viduniqueID=reviews.viduniqueID;