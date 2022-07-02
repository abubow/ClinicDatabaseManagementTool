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
create table Clinic(Clinic_Id varchar(25) primary key,Clinic_Name varchar(25),Clinic_Desc varchar(25),Clinic_Address varchar(25),Clinic_Doc_Name varchar(25),Doctor_Id varchar(25));
Alter table Clinic add foreign key Clinic(Doctor_id) References Doctor(Doctor_Id);
SELECT * FROM Schedules;
 
DROP TABLE IF EXISTS Patient;
create table Patient(Patient_Id varchar(25) primary key,Patient_Name varchar(25),Patient_Mobile varchar(25),Patient_Email Text,Patient_Address Text,Doctor_Id varchar(25));
Alter table Patient Add foreign key Patient(Doctor_Id) References Doctor(Doctor_Id);
insert into patient

	values('001','Ali','030259845','abc@femail.com','karachi','32115'),
    ('002','Haie','030254545','abc@femail.com','karachi','01478'),
    ('003','Zeerak','032359844','abc@femail.com','karachi',')1478'),
    ('005','Ahamd','031259834','abc@femail.com','karachi','32115');

SELECT * FROM Patient;
 
 SELECT Doctor.*, Patient.* FROM Doctor JOIN Patient On Doctor.Doctor_Id = Patient.Doctor_Id;
 
DROP TABLE IF EXISTS Booking;
create table Booking(Booking_Id varchar(25),Booking_Date date,Booking Time,Booking_Desc Text,Doctor_id varchar(25),Patient_Id varchar(25));
Alter table Booking add foreign key Booking(Doctor_Id) References Doctor(Doctor_Id);
Alter table Booking add foreign key Booking(Patient_Id) References Patient(Patient_Id);
SELECT * FROM Booking;
 
DROP TABLE IF EXISTS Doc_Qualification;
create table Doc_Qualification(Qualification_Id varchar(25) primary key, Qualification_Name varchar(25),Qualification_Country varchar(25),Institute_Name Text,Procurement_Year int,Doctor_Id varchar(25));
Alter table Doc_Qualification add foreign key Doc_Qualification(Doctor_Id) References Doctor(Doctor_Id);
SELECT * FROM Doc_Qualification;
 
DROP TABLE IF EXISTS Fees;
create table Fees(Doc_Fee_Id varchar(25), Doc_Fee_Amount varchar(25), Doc_Fee_Type varchar(25),Doc_Fee_Status varchar(25),Doctor_id varchar(25));
Alter table Fees add foreign key Fees(Doctor_Id) References Doctor(Doctor_Id);
SELECT * FROM Fee;
 