CREATE Database SwanseaRenting;

USE SwanseaRenting; 

CREATE TABLE Students (
  Student_ID int NOT NULL,
  First_Name varchar(20) NOT NULL,
  Last_Name varchar(20) NOT NULL,
  Max_Rent int NOT NULL,
  City varchar(20) NOT NULL,
  Req_Accessibility varchar(20) NOT NULL,
  Parking_Required varchar(20) NOT NULL,
  Moving_In_Date date NOT NULL,
  Moving_Out_Date date NOT NULL,
  Started_Viewing date NOT NULL,
  PRIMARY KEY (Student_ID) );
 

USE SwanseaRenting;
INSERT INTO Students (Student_ID, First_Name, Last_Name, Max_Rent, City, Req_Accessibility, Parking_Required, Moving_In_Date, Moving_Out_Date, Started_Viewing)
VALUES 
(908312, 'Olivier', 'Joroud', 325, 'Swansea', 'Yes', 'Yes', 20220820, 20240731, 20220701),
(956306, 'Charlie', 'Kirby', 400, 'Swansea', 'Yes', 'No', 20220901, 20230731, 20220628),
(794201, 'Luke', 'Kirby', 350, 'Swansea', 'No', 'No', 20220901, 20230731, 20220704),
(598123, 'Cahit', 'Poyraz', 375, 'Swansea', 'Yes', 'Yes', 20220820, 20241216, 20220629),
(653112, 'Owen', 'Loughnane', 300, 'Swansea', 'Yes', 'No', 20220901, 20230731, 20220715),
(500214, 'Anthony', 'Achille', 500, 'Swansea', 'No', 'No', 20221201, 20230731, 20220702),
(603946, 'Pavlos', 'Piperedes', 400, 'Swansea', 'Yes', 'Yes', 20220901, 20240731, 20220718),
(679899, 'Kylie', 'Anthoo', 325, 'Swansea', 'Yes', 'Yes', 20220901, 20230831, 20220711),
(345678, 'David', 'Fernandez', 375, 'Swansea', 'Yes', 'No', 20220820, 20241216, 20220701),
(835708, 'Paulina', 'Rice', 350, 'Swansea', 'Yes', 'Yes', 20220901, 20240731, 20220705),
(789345, 'Rishi', 'Thomas', 425, 'Swansea', 'No', 'Yes', 20221201, 20230731, 20220703);

CREATE TABLE Houses (
  House_Address varchar(80) NOT NULL,
  Landlord_Surname varchar(20) NOT NULL,
  Postcode varchar(20) NOT NULL,
  Rent int NOT NULL,
  Accessibility varchar(20) NOT NULL,
  Parking varchar(20) NOT NULL,
  Number_of_Times_Rejected int NOT NULL,
  Tenant_In_Date date NOT NULL,
  Tenant_Out_Date date NOT NULL,
  PRIMARY KEY (House_Address) );

USE SwanseaRenting;
INSERT INTO Houses (House_Address, Landlord_Surname, Postcode, Rent, Accessibility, Parking, Number_of_Times_Rejected, Tenant_In_Date, Tenant_Out_Date)
VALUES 
('151 Pearles Lane', 'Sethia', 'SA5 0AT', 350,'Yes', 'Yes', 0, 20220901, 20240731),
('45 Bryn Road', 'Sethia', 'SA1 L90', 400, 'Yes', 'No', 1, 20220901, 20230731),
('41 Abernethy Street', 'Moe', 'SA1 2JI', 325,'Yes', 'Yes', 0, 20220901, 20240731),
('135 Hanover Street', 'Stephano', 'SA1 6BN', 375,'Yes', 'Yes', 0, 20220901, 20241216),
('12 Trawler Road', 'Stephano', 'SA2 ER9', 375, 'Yes', 'No', 1, 20220901, 20241216),
('17 Rhyddings Park Road', 'Napier', 'SA2 0AL', 300,'Yes', 'No', 0, 20220901, 20230731),
('125 Coors Close', 'Stephano', 'SA1 2LI', 325,'Yes', 'Yes', 0, 20220901, 20230831),
('10 Upping Street', 'Webb', 'SA3 8EP', 400, 'Yes', 'Yes', 3, 20220901, 20240731),
('3 Armarda Close', 'Webb', 'SA5 E32', 350,'No', 'No', 0, 20220901, 20230731),
('178 Apple Lane', 'Morgan', 'SA1 LF7', 500, 'No', 'No', 1, 20220901, 20230731);


CREATE TABLE Appointments (
  Appointment_ID varchar(20) NOT NULL,
  Student_ID int NOT NULL,
  House_Address varchar(80) NOT NULL,
  Viewing_Date date NOT NULL,
  Decision varchar(20) NOT NULL,
  PRIMARY KEY (Appointment_ID), 
  FOREIGN KEY (Student_ID) REFERENCES Students (Student_ID),
  FOREIGN KEY (House_Address) REFERENCES Houses(House_Address)
  );


USE SwanseaRenting;
INSERT INTO Appointments (Appointment_ID, Student_ID, House_Address, Viewing_Date, Decision)
VALUES 
(1, 908312, '41 Abernethy Street', 20220712, 'Yes'),
(2, 956306, '45 Bryn Road', 20220701, 'Yes'),
(3, 794201, '3 Armarda Close', 20220708, 'Yes'),
(4, 598123, '135 Hanover Street', 20220702, 'No'),
(5, 653112, '17 Rhyddings Park Road', 20220801, 'No'),
(6, 500214, '178 Apple Lane', 20220728, 'Yes'),
(7, 603946, '10 Upping Street', 20220721, 'No'),
(8, 679899, '125 Coors Close', 20220714, 'Yes'),
(9, 345678, '12 Trawler Road', 20220720, 'No'),
(10, 835708, '151 Pearles Lane', 20220708, 'No');



--A)
USE SwanseaRenting,
CREATE VIEW Rental_Demand AS
Select Student_ID, First_Name, Started_Viewing
FROM Students
ORDER BY Started_Viewing ASC;

SELECT *
FROM Rental_Demand;

--B)
USE SwanseaRenting,
CREATE VIEW MatchAndRent AS
SELECT Student_ID, Postcode, House_Address
FROM Students
JOIN Houses
ON Accessibility = Req_Accessibility
AND Parking = Parking_Required
AND Rent <= Max_Rent
AND Tenant_In_Date <= Moving_In_Date
AND Tenant_Out_Date >= Moving_Out_Date
ORDER BY Started_Viewing ASC
LIMIT 5;

SELECT *
FROM MatchAndRent; 

--C)
USE SwanseaRenting
CREATE VIEW RentalTracker AS
SELECT Appointments.Student_ID, Appointments.Decision, Appointments.Viewing_Date, Houses.House_Address
FROM Appointments, Houses
WHERE Appointments.House_Address = Houses.House_Address;

USE SwanseaRenting
SELECT * 
FROM RentalTracker
WHERE Student_ID = [Example of student ID would be '956306'];

USE SwanseaRenting
SELECT * 
FROM RentalTracker
WHERE House_Address = [Example of House Address would be '41 Abernethy Street']
AND Decision IS NULL;


--D)
USE SwanseaRenting
CREATE VIEW SystemEfficacy AS
SELECT First_Name, Students.Last_Name, Appointments.Decision
FROM Students, Appointments
WHERE Students.Student_ID = Appointments.Student_ID;

USE SwanseaRenting
CREATE VIEW SystemEfficacy2 AS
SELECT Left(First_Name, 1), MAX(Last_Name) AS Last_Name, COUNT(*) AS total
FROM SystemEfficacy
WHERE Decision = 'No'
GROUP BY Left(First_Name, 1)
ORDER BY First_Name;

SELECT * 
FROM SystemEfficacy2;


--E)
USE SwanseaRenting
CREATE VIEW RenterReport AS
Select Houses.Postcode, Houses.Landlord_Surname, Appointments.Decision
FROM Houses, Appointments
WHERE Appointments.House_Address = Houses.House_Address;

USE SwanseaRenting
CREATE VIEW RenterReport2 AS
SELECT Postcode, Landlord_Surname, COUNT(*) AS total
FROM RenterReport
WHERE Decision = 'No'
GROUP BY Postcode, Landlord_Surname;

SELECT * 
FROM RenterReport2;
