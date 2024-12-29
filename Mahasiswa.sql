DROP DATABASE IF EXISTS Krs;
CREATE DATABASE Krs;
USE Krs;

CREATE TABLE tblMahasiswa (
    nim VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    nohp VARCHAR(20) NOT NULL,
    INDEX index_nim (nim)
);

CREATE TABLE tblMataKuliah (
    kodematakuliah VARCHAR(5) PRIMARY KEY,
    namamatakuliah VARCHAR(30),
    sks INTEGER DEFAULT 0,
    INDEX index_kodematakuliah (kodematakuliah)
);

CREATE TABLE tblKRS (
    nim VARCHAR(10),
    kodematakuliah VARCHAR(5),
    FOREIGN KEY (nim) REFERENCES tblMahasiswa(nim),
    FOREIGN KEY (kodematakuliah) REFERENCES tblMataKuliah(kodematakuliah)
);

ALTER TABLE tblKRS
ADD hari ENUM('Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu') DEFAULT NULL,
ADD jam TIME;

SHOW TABLES;
DESC tblMahasiswa;
DESC tblMataKuliah;
DESC tblKRS;



INSERT INTO tblMahasiswa 
VALUES('1','Daniel','Swiss','daniel@gmail.com','081'),
('2','Hajiime','Jawa','jawa@gmail.com','082');
SELECT * FROM tblMahasiswa;

INSERT INTO tblMataKuliah
VALUES('IT1','NETWORK',4),
('IT2','FINTECH','4'),
('IT3','DATABASE',4);
SELECT * FROM tblMataKuliah;

INSERT INTO tblKRS
VALUES ('1','IT1','Selasa','08:00:00'),
('1','IT2','Selasa','08:00:00'),
('1','IT3','Rabu','08:00:00');
SELECT * FROM tblKRS;