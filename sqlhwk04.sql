#HWK4 BY ARMENOUSH ASLANIAN-PERSICO

DROP TABLE IF EXISTS tblEmployeeInfo;
CREATE TABLE tblEmployeeInfo (employeeid INT, supervisorid INT, employeetitle VARCHAR(40), employeename VARCHAR(40));
INSERT INTO tblEmployeeInfo
VALUES 
(01,NULL, "The People", "The People of the City of New York"),
(02,01, "Mayor", "Bill de Blasio"),
(03,01, "Comptroller", "Scott Stringer"),
(04,01, "Public Advocate", "Letitia James"),
(05,02, "First Deputy Mayor", "Anthony Shorris"),
(06,05, "Fire Commissioner", "Daniel Nigro"),
(07,05, "Sanitation Commissioner", "Kathryn Garcia"),
(08,05, "Transportation Commisioner", "Polly Trottenberg"),
(09,05, "Parks Commissioner", "Mitchell Silver"),
(10,05, "Finance Commissioner", "Jacques Jiha"),
(11,05, "Design and Construction Commisisoner", "Feniosky Peña-Mora");

SELECT 
Employee.employeeid AS 'Employee ID', 
Employee.employeename AS 'Employee Name', 
Employee.employeetitle AS 'Employee Title', 
Supervisor.employeename AS 'Supervisor Name', 
Supervisor.employeetitle AS 'Supervisor Title'
FROM tblEmployeeInfo AS Employee
LEFT JOIN tblEmployeeInfo AS Supervisor
ON Employee.supervisorid=Supervisor.employeeid
ORDER BY Employee.employeeid;
