DROP DATABASE IF EXISTS ClinicApointmentSystem;
CREATE DATABASE ClinicApointmentSystem;
USE ClinicApointmentSystem;



CREATE TABLE Doctor(Doctor_Id varchar(25) primary key, Doc_Name varchar(25),Doc_Mobile varchar(25),Doc_Email varchar(25),Expirence_Year int);
INSERT INTO Doctor values('11232','Ali Ahmed','030080070060','ali.ahmed@gmail.com',5),
						('32115','Ahmed shah','034784870060','ahmed@gmail.com',2),
                         ('21144','iftikhar thakur','030014785260','iftikhar@gmail.com',4),
                         ('44558','sikandar sadiqe','030014785225','sikandar@gmail.com',8),
                         ('01478','uzair shahid','031848','uzair@gmail.com',15);
SELECT * FROM Doctor;                    

DROP TABLE IF EXISTS Schedules;
create table Schedules(Schedule_Id varchar(25) primary key,Doc_Sche_Date date,Doc_Sche_Time time,Doc_Sche_Desc varchar(25),Doctor_Id varchar(25),
 foreign key (Doctor_Id) references Doctor(Doctor_Id));
insert into Schedules (Schedule_Id,Doc_Sche_Date,Doc_Sche_Time ,Doc_Sche_Desc, Doctor_Id)
						values('032','2022-12-21','5:30','Monthly Checkup', '32115'),
							 ('32115','2022-12-22','5:30','Physiotherapy', '32115'),
							 ('21144','2022-12-23','5:30','Psych Eval', '32115'),
							 ('44558','2022-12-23','6:00','Psych Eval', '32115'),
							 ('01478','2022-12-24','5:30','Chemo Therapy', '32115');
SELECT * FROM Schedules order by Doc_Sche_Date;
 
DROP TABLE IF EXISTS Clinic;
create table Clinic(Clinic_Id varchar(255) primary key,Clinic_Name varchar(255),Clinic_Desc varchar(255),Clinic_Address varchar(255),Clinic_Doc_Name varchar(255),Doctor_Id varchar(255));
Alter table Clinic add CONSTRAINT FK foreign key Clinic(Doctor_id) References Doctor(Doctor_Id);

INSERT INTO Clinic VALUES 
						("C119",  "Hoffman's Care Abuja", "Named after David Huffman in the Capital of Nigeria", "Abuja, Nigeria", "Ahmed shah", "32115"),
						("C120",  "Hoffman's Care Lagos", "Named after David Huffman in the former Capital of Nigeria", "Lagos, Nigeria", "Ali Ahmed", "11232");
SELECT * FROM Schedules;
 
DROP TABLE IF EXISTS Patient;
create table Patient(Patient_Id varchar(25) primary key,Patient_Name varchar(25),Patient_Mobile varchar(25),Patient_Email Text,Patient_Address Text,Doctor_Id varchar(25));
Alter table Patient Add CONSTRAINT FK_Patient foreign key Patient(Doctor_Id) References Doctor(Doctor_Id);
insert into patient
	values('001','Ali','030259845','abc@femail.com','karachi','32115'),
    ('002','Haie','030254545','abc@femail.com','karachi','01478'),
    ('003','Zeerak','032359844','abc@femail.com','karachi','01478'),
    ('005','Ahamd','031259834','abc@femail.com','karachi','32115');

SELECT * FROM Patient;
 
SELECT Doctor.*, Patient.* FROM Doctor JOIN Patient On Doctor.Doctor_Id = Patient.Doctor_Id;
SELECT Doctor.*, Patient.*, Schedules.* FROM Doctor 
JOIN Patient On Doctor.Doctor_Id = Patient.Doctor_Id 
JOIN Schedules ON Schedules.Doctor_Id = Patient.Doctor_Id;
 
DROP TABLE IF EXISTS Booking;
create table Booking(Booking_Id varchar(25),Booking_Date date,Booking Time,Booking_Desc Text,Doctor_id varchar(25),Patient_Id varchar(25));
Alter table Booking add CONSTRAINT FK_Booking foreign key Booking(Doctor_Id) References Doctor(Doctor_Id);
Alter table Booking ADD CONSTRAINT FK_Booking_1 foreign key Booking(Patient_Id) References Patient(Patient_Id);
SELECT * FROM Booking;
INSERT INTO Booking VALUES
							("B483", "2022-12-21", "5:30", "Urgent Appointment", "32115", "002"),
							("B484", "2022-12-21", "5:30", "Regular Appointment", "32115", "001"),
							("B485", "2022-12-22", "6:00", "Regular Appointment", "32115", "001"),
							("B486", "2022-12-23", "5:30", "Urgent Appointment", "32115", "001"),
							("B487", "2022-12-24", "5:30", "Urgent Appointment", "32115", "005");
 
DROP TABLE IF EXISTS Doc_Qualification;
create table Doc_Qualification(Qualification_Id varchar(25) primary key, Qualification_Name varchar(25),Qualification_Country varchar(25),Institute_Name Text,Doctor_Id varchar(25));
Alter table Doc_Qualification add CONSTRAINT FK_Doc_Qual foreign key Doc_Qualification(Doctor_Id) References Doctor(Doctor_Id);
SELECT * FROM Doc_Qualification;
INSERT INTO Doc_Qualification VALUES
									('9984', 'MBBS', 'Iran', 'Tehran University of Medical Sciences', '32115'),
                                    ('9985', 'Master of Surgery', 'Iraq', 'University of Baghdad', '32115'),
                                    ('9986', 'MBBS', 'United States of America', 'Stanford University School of Medicine', '44558'),
                                    ('9987', 'Doctor of Medicine', 'United States of America', 'Stanford University School of Medicine', '44558'),
                                    ('9988', 'MBBS', 'North Korea', 'University of Medicine', '21144');
SELECT Doctor.*, Doc_Qualification.* FROM Doctor 
	JOIN Doc_Qualification On Doctor.Doctor_Id = Doc_Qualification.Doctor_Id 
		where Doc_Qualification.Qualification_name = 'MBBS';
 
SELECT Doctor.Doc_Name, Doc_Qualification.Qualification_Name, Patient.Patient_Name, CONCAT(Schedules.Doc_Sche_Date," ", Schedules.Doc_Sche_Time) as `Schedule`
	FROM Doctor 
	JOIN Doc_Qualification On Doctor.Doctor_Id = Doc_Qualification.Doctor_Id
		JOIN Patient on Patient.Doctor_Id = Doctor.Doctor_Id
			JOIN Schedules on Schedules.Doctor_id = Patient.Doctor_Id
				where Doctor.Doc_Name = 'Ahmed shah' and Schedules.Doc_Sche_Date like'%24%';

DROP TABLE IF EXISTS Fees;
create table Fees(Doc_Fee_Id varchar(255), Doc_Fee_Amount INT, Doc_Fee_Type varchar(255),Doc_Fee_Status varchar(255),Doctor_id varchar(25));
Alter table Fees add CONSTRAINT FK_DOC_FEES foreign key Fees(Doctor_Id) References Doctor(Doctor_Id);
SELECT * FROM Fees;
INSERT INTO Fees VALUES
						("DF-009", 9000, "Cash", "Non-Refundable", "32115"),
						("DF-010", 8500, "Cash", "Non-Refundable", "11232"),
						("DF-011", 15500, "Cash & Online", "Non-Refundable", "21144"),
						("DF-012", 10000, "Cash & Online", "Non-Refundable", "44558"),
						("DF-013", 8000, "Cash", "Refundable", "01478");
                        
                        
                        
/* STORED PROCEDURES */
DELIMITER  ??
CREATE PROCEDURE sp_GetDoctorsInRange(IN max INT)
BEGIN 
	SELECT * FROM Fees WHERE Fees.Doc_Fee_Amount <= max;
END ??
DELIMITER  ;

CALL sp_GetDoctorsInRange("9000NGN");