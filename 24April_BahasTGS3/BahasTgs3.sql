DROP DATABASE IF EXISTS dbCatatanSipil;
CREATE DATABASE dbCatatanSipil;
USE dbCatatanSipil;

DROP TABLE IF EXISTS tblPernikahan;
CREATE TABLE tblPernikahan (
    noid INT PRIMARY KEY,
    nama VARCHAR(20),
    jkelamin CHAR(1),
    tgllahir DATETIME,
    kotaasal VARCHAR(10) default 'Semarang',
    pasangan INT NULL,
    tglnikah DATETIME
);



INSERT INTO tblPernikahan
VALUES
(1,'YUNITA TRIRATNADI A','W','1981-11-29 23:11:10','YOGYAKARTA',6,'2008-09-11 12:09:41'),
(2,'YULIA','W','1976-12-05 19:12:21','SEMARANG',7,'2011-10-23 05:10:45'),
(3,'YOLA AZERTI SARI','W','1983-06-01 03:06:40','MAGELANG',8,'2011-06-08 17:06:28'),
(4,'YETI SULIANA','W','1986-04-18 04:04:50','YOGYAKARTA',9,'2005-01-14 21:01:04'),
(5,'YETI KURNIATI P','W','1976-02-18 21:02:18','MUNTILAN',10,'2008-11-19 23:11:50'),
(6,'ZIAD','P','1981-07-08 17:07:06','YOGYAKARTA',1,'2008-09-11 12:09:41'),
(7,'TUNJUNG ARIWIBOWO','P','1978-10-25 07:10:39','YOGYAKARTA',2,'2011-10-23 05:10:45'),
(8,'SUGIMAN','P','1976-09-28 01:09:38','MUNTILAN',3,'2011-06-08 17:06:28'),
(9,'SIGIT SUTOPO','P','1976-06-22 00:06:50','YOGYAKARTA',4,'2005-01-14 21:01:04'),
(10,'RICKY PERMANADJAYA','P','1989-06-09 07:06:23','MAGELANG',5,'2008-11-19 23:11:50');


ALTER TABLE tblPernikahan
ADD CONSTRAINT foreignpasangan FOREIGN KEY (pasangan)
REFERENCES tblPernikahan(noid);

-- SOAL 1;
DROP VIEW IF EXISTS vwJawaban1;
CREATE VIEW vwJawaban1 AS
    SELECT *
    FROM tblPernikahan;

-- SOAL 2;
DROP VIEW IF EXISTS vwJawaban2;
CREATE VIEW vwJawaban2 AS
    SELECT pria.nama AS PRIA,
    wanita.nama AS WANITA,
    pria.tglnikah AS 'TANGGAL MENIKAH',
    IF(YEAR(NOW()) - YEAR(pria.tglnikah) >= 15, 'SUDAH MENIKAH >= 15 TAHUN','BELUM MENIKAH > 15 TAHUN') AS KETERANGAN

    FROM tblPernikahan AS PRIA,
    tblPernikahan AS WANITA
    WHERE PRIA.jkelamin = 'P' AND WANITA.jkelamin = 'W'
    AND PRIA.noid = WANITA.pasangan;

-- SOAL 3;
DROP VIEW IF EXISTS vwJawaban3;
CREATE VIEW vwJawaban3 AS
    SELECT pria.nama AS 'PRIA(LAHIR SEBELUM 1980)',
    pria.kotaasal AS 'KOTA ASAL PRIA',
    wanita.nama as WANITA,
    wanita.kotaasal AS 'KOTA ASAL WANITA',
    IF(pria.kotaasal = wanita.kotaasal, 'NIKAH SEKOTA', 'NIKAH BEDA KOTA') AS KETERANGAN

    FROM tblPernikahan AS PRIA,
    tblPernikahan AS WANITA
    WHERE PRIA.jkelamin = 'P' AND WANITA.jkelamin = 'W'
    AND PRIA.noid = WANITA.pasangan AND YEAR(pria.tgllahir) < 1980;

SELECT *
FROM vwJawaban3;

-- SOAL 4;
DROP VIEW IF EXISTS vwJawaban4;
CREATE VIEW vwJawaban4 AS 
    SELECT pria.nama AS PRIA,
    (YEAR(NOW())-YEAR(pria.tgllahir)) AS UMUR_PRIA,
    wanita.nama AS WANITA,
    (YEAR(NOW())-YEAR(wanita.tgllahir)) AS UMUR_WANITA,
    CASE
        WHEN YEAR(pria.tgllahir) > YEAR(wanita.tgllahir) THEN CONCAT('UMUR PRIA LEBIH TUA ',YEAR(pria.tgllahir) - YEAR(wanita.tgllahir),' TAHUN') 
        WHEN YEAR(wanita.tgllahir) > YEAR(pria.tgllahir) THEN CONCAT('UMUR WANITA LEBIH TUA ',YEAR(wanita.tgllahir) - YEAR(pria.tgllahir),' TAHUN')
        ELSE 'UMUR PRIA SAMA DENGAN UMUR WANITA'
    END AS KETERANGAN


    FROM tblPernikahan AS pria,
    tblPernikahan AS wanita
    WHERE pria.jkelamin = 'P' AND wanita.jkelamin = 'W'
    AND PRIA.noid = WANITA.pasangan;

SELECT *
FROM vwJawaban4;

-- SOAL 5;
DROP VIEW IF EXISTS vwJawaban5;
CREATE VIEW vwJawaban5 AS 
    SELECT nama AS 'NAMA LENGKAP',
    INSTR(nama,' ') AS SPASI,
    IF(INSTR(nama,' ') = 0 , nama, LEFT(nama, INSTR(nama, ' '))) AS 'NAMA DEPAN',

    -- INSTR(nama,' ') + 1 AS CEKbELAKANG,
    -- LENGTH(nama) AS PANJANG,
    -- LENGTH(nama) - (INSTR(nama, ' ') + 1 ) AS SISANYA,

    -- DIATAS CUMA BANTUAN

    MID(nama, INSTR(nama, ' ') + 1, LENGTH(nama) - INSTR(nama,' ')) AS 'NAMA BELAKANG'

    FROM tblPernikahan;

SELECT *
FROM vwJawaban5;
