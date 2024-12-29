-- COMMENT 'C:\Users\informatika\Documents\dbApotik.sql';

-- COMMENT 'menghapus database menggunakan perintah DROP';
DROP DATABASE IF EXISTS dbApotik;

--IF EXISTS hapus database kalau database nya itu ada 

-- COMMENT 'buat database baru dengan nama dbApotik';
CREATE DATABASE dbApotik;

--melihat daftar database nya apakah sudah ada atau belum
SHOW DATABASES;

--mengaktifkan database
USE dbApotik;

-- LANGKAH-LANGKAH:
-- 1. membuat tabel, tulis duluan perintah CREATE TABLE
-- 2. lanjut dengan menulis seluruh kolom dari tabel tersebut
-- 3. tentukan tipe data (INT DOUBLE VARCHAR CHAR DATETIME TIMESTAMP)
-- INT >> semua data yang dihitung, tipe nya integer
-- UANG >> di MySQL tidak ada tipe data CURRENCY, jadi pakai nya DOUBLE
-- DATETIME >> tahun/bulan/tanggal 2024-03-13
-- TIMESTAMP >> HH:MM:SS
-- 4. tentukan kunci PK, FK, UNIQUE 
-- 5. tentukan CONSTRAINT atau aturan (NULL, DEFAULT)
-- 6. Cek konsistensi data jkelamin LAKI LAKI/PEREMPUAN, PRIA/WANITA (ENUM)
-- enumeration > pilihan hanya boleh 1. SET adalah pilihan dengan banyak
-- INDEX digunakan untuk mempercepat proses pencarian data
CREATE TABLE tblPasien
(
kodepasien INT PRIMARY KEY,
namapasien VARCHAR(100) NOT NULL,
tempatlahir VARCHAR(100) DEFAULT 'SEMARANG',
tanggallahir DATETIME,
jkelamin ENUM('L', 'P'),
goldarah ENUM('A', 'B', 'AB','O'),
alamat VARCHAR(100) NOT NULL,
nohp VARCHAR(20) UNIQUE,
warna SET('BIRU', 'KUNING', 'MERAH', 'HIJAU', 'JINGGA', 'PUTIH'),
INDEX(namapasien)
);

SHOW TABLES;

--deskripsikan tblPasien
DESC tblPasien;

--menambahkan kolom baru ke tabel yang sudah ada
-- alter itu untuk menambah, drop untuk menghapus
ALTER TABLE tblPasien
ADD email VARCHAR(255);

ALTER TABLE tblPasien
DROP COLUMN warna;

DESC tblPasien;

DROP TABLE IF EXISTS tblObat;
CREATE TABLE tblObat
(
kodeobat CHAR(2) PRIMARY KEY,
namaobat VARCHAR(10) NOT NULL,
tglproduksi DATETIME DEFAULT NOW(),
exdate DATETIME
);

ALTER TABLE tblObat
ADD kemasan VARCHAR(20);

ALTER TABLE tblObat
ADD petunjuk VARCHAR(100);

SHOW TABLES;

-- LEVEL 2: yang punya PK juga FK
CREATE TABLE tblAntrian
(
noantrian INT PRIMARY KEY,
tanggal DATETIME DEFAULT NOW(),
kodepasien INT,
FOREIGN KEY(kodepasien) REFERENCES tblPasien(kodepasien)
);

-- LEVEL 3 : yang punya FK saja
CREATE TABLE tblBeli
(
noantrian INT,
kodeobat CHAR(2),
harga DOUBLE,
dosis INT,
INDEX(noantrian),
FOREIGN KEY(noantrian) REFERENCES tblAntrian(noantrian),
FOREIGN KEY(kodeobat) REFERENCES tblObat(kodeobat)
);

SHOW TABLES;
DESC tblBeli;


INSERT INTO tblObat (tglproduksi, exdate,kodeobat,namaobat,kemasan,petunjuk) 
VALUES ('2024-01-01','2029-01-01','05','INSULIN F','-','-');


INSERT INTO tblObat (kodeobat,tglproduksi, exdate,namaobat,kemasan,petunjuk) 
VALUES ('00','2024-01-01','2029-01-01','INSULIN A','-','-');



INSERT INTO tblObat
VALUES ('01','INSULIN B','2024-01-01','2029-01-01','-','-'),
('02','INSULIN C','2024-01-01','2029-01-01','-','-'),
('03','INSULIN D','2024-01-01','2029-01-01','-','-'),
('04','INSULIN E','2024-01-01','2029-01-01','-','-');

SELECT kodeobat AS "KODE OBAT",
tglproduksi AS TGL_PRO,
exdate AS EXPIRED,
namaobat AS NAMA,
kemasan,petunjuk
FROM tblObat;

SELECT * 
FROM tblObat;



INSERT INTO tblPasien (kodepasien,namapasien,tempatlahir,tanggallahir,
jkelamin,goldarah,alamat,nohp,email)
VALUES (1,'SAYAAKA','SEMRAANG','2000-08-01','L','A','BSB','085','SAYAAKA@GMAIL.COM'),
(2,'DANIEL','SEMARANG','2001-08-01','L','B','BSBB','082','DANIEL@GMAIL.COM');

INSERT INTO tblPasien (email,namapasien,tempatlahir,tanggallahir,
jkelamin,goldarah,alamat,nohp,kodepasien)
VALUES ('SAYAYA@GMAIL.COM','SAYAYA','JOGJA','2000-08-02','P','B','UNGARAN','081',3);

INSERT INTO tblPasien 
VALUES (4,'BARON','SEMRAANG','2000-08-01','L','A','BSB','084','SAYAAKA@GMAIL.COM'),
(5,'DARIUS',DEFAULT,'2000-04-01','L','B','BSB','083','DARIUS@GMAIL.COM'),
(6,'ASHE',DEFAULT,'2000-05-02','P','AB','BSB','-','ASHE@GMAIL.COM'),
(7,'TRYN',DEFAULT,'2000-06-03','L','O','BSB','088','TRYN@GMAIL.COM'),
(8,'HAJIME',DEFAULT,'2000-07-04','P','B','BSB','087','HAJIME@GMAIL.COM'),
(9,'YASUO',DEFAULT,'2000-08-05','L','AB','BSB','089','YASUO@GMAIL.COM'),
(10,'YONE',DEFAULT,'2000-09-06','L','O','BSB','080','YONE@GMAIL.COM');

SELECT kodepasien AS Kode_Pasien,
namapasien AS Nama_Pasien,
tempatlahir AS Tempat_Lahir,
tanggallahir AS Tanggal_Lahir,
jkelamin AS Jenis_Kel,
goldarah AS GolDarah,
alamat,
nohp,
email
FROM tblPasien;

INSERT INTO tblAntrian
VALUES
(1,'2023-12-01',2),
(2,'2023-03-29',10),
(3,'2023-01-27',5),
(4,'2023-08-30',6),
(5,'2023-03-10',5),
(6,'2023-12-16',2),
(7,'2023-03-29',1),
(8,'2023-01-06',8),
(9,'2023-09-13',2),
(10,'2023-01-11',8),
(11,'2023-01-12',6),
(12,'2023-12-30',5),
(13,'2023-04-17',9),
(14,'2023-09-15',9),
(15,'2023-03-26',6),
(16,'2023-02-05',8),
(17,'2023-10-19',1),
(18,'2023-03-04',3),
(19,'2023-03-23',3),
(20,'2023-10-25',2),
(21,'2023-12-17',8),
(22,'2023-11-17',8),
(23,'2023-09-25',7),
(24,'2023-09-26',3),
(25,'2023-02-01',2),
(26,'2023-06-29',4),
(27,'2023-11-21',1),
(28,'2023-05-11',10),
(29,'2023-11-05',5),
(30,'2023-04-02',1);

-- DELETE FROM tblAntrian;

-- LOAD DATA LOCAL INFILE 'C:\\NoDoubt\\Database Programming\\tblAntrian.csv'
-- INTO TABLE tblAntrian
-- FIELDS TERMINATED BY ';'
-- ENCLOSED BY ''''
-- LINES TERMINATED BY '\r\n'
-- IGNORE 1 LINES;

SELECT *
FROM tblAntrian;

DELETE FROM tblAntrian;

UPDATE tblObat
SET kodeobat = RIGHT(kodeobat,1);
SELECT * 
FROM tblObat;

LOAD DATA LOCAL INFILE 'C:\\NoDoubt\\DatabaseProgramming\\tblBeli.csv'
INTO TABLE tblBeli
FIELDS TERMINATED BY ';'
ENCLOSED BY ''''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT *
FROM tblBeli;