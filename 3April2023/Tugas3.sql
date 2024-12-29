DROP DATABASE IF EXISTS dbCatatanSipil;
CREATE DATABASE dbCatatanSipil;
USE dbCatatanSipil;

CREATE TABLE tblInfo (
    noid INT PRIMARY KEY,
    nama VARCHAR(20),
    jkelamin ENUM('P','W'),
    tgllahir DATETIME,
    kotaasal VARCHAR(10),
    pasangan INT NULL,
    tglnikah DATETIME
);



INSERT INTO tblInfo
VALUES
(1,'YUNITA TRIRATNADI A','W','1981-11-29 23:11:10','YOGYAKARTA',6,'2008-09-11 12:09:41'),
(2,'YULIA','W','1976-12-05 19:12:21','SEMARANG',7,'2011-10-23 05:10:45'),
(3,'YOLA AZERTI SARI','W','1983-06-01 03:06:40','MAGELANG',8,'2011-06-08 17:06:28'),
(4,'YETI SULIANA','W','1986-04-18 04:04:50','YOGYAKARTA',9,'2005-01-14 21:01:04'),
(5,'YETI KURNIATI P','W','1976-02-18 21:02:18','MUNTILAN',10,'2008-11-19 23:11:50'),
(6,'ZIAD','P','1981-07-08 17:07:06','YOGYAKARTA',1,'2008-09-11 12:09:41'),
(7,'TUNJUNG ARIWIBOWO','P','1978-10-25 07:10:39','YOGYAKARTA',2,'2011-10-23 05:10:45'),
(8,'SUGIMAN','P','1976-09-28 01:09:38','MUNTILAN',3,'2011-06-08 17:06:28'),
(9,' SIGIT SUTOPO','P','1976-06-22 00:06:50','YOGYAKARTA',4,'2005-01-14 21:01:04'),
(10,'RICKY PERMANADJAYA','P','1989-06-09 07:06:23','MAGELANG',5,'2008-11-19 23:11:50');

ALTER TABLE tblInfo
ADD CONSTRAINT foreignpasangan FOREIGN KEY (pasangan)
REFERENCES tblInfo(noid);


-- SOAL 2;
SELECT pria.nama AS PRIA,
wanita.nama AS WANITA,
pria.tglnikah AS TANGGAL_NIKAH,
IF(YEAR(NOW()) - YEAR(pria.tglnikah) >= 15,'SUDAH MENIKAH >= 15 TAHUN','BELUM MENIKAH 15 TAHUN') AS KETERANGAN

FROM tblInfo AS pria
INNER JOIN
tblInfo AS wanita ON pria.pasangan = wanita.noid
WHERE pria.jkelamin = 'P' AND wanita.jkelamin = 'W';


-- SOAL 3;
SELECT pria.nama AS PRIA,
pria.kotaasal AS ASAL_PRIA,
wanita.nama AS WANITA,
wanita.kotaasal AS ASAL_WANITA,
IF(pria.kotaasal = wanita.kotaasal, 'Sekota','Bseda kota') AS Kota_Asal
FROM tblInfo AS pria
INNER JOIN
tblInfo AS wanita ON pria.pasangan = wanita.noid
WHERE pria.jkelamin = 'P' AND wanita.jkelamin = 'W' AND YEAR(pria.tgllahir) < 1990;

-- SOAL 4;
SELECT pria.nama AS PRIA,
(YEAR(NOW())-YEAR(pria.tgllahir)) AS UMUR_PRIA,
wanita.nama AS WANITA,
(YEAR(NOW())-YEAR(wanita.tgllahir)) AS UMUR_WANITA,
   CASE
        WHEN pria.tgllahir < wanita.tgllahir THEN YEAR(wanita.tgllahir) - YEAR(pria.tgllahir)
        WHEN pria.tgllahir > wanita.tgllahir THEN YEAR(pria.tgllahir) - YEAR(wanita.tgllahir)
        ELSE 'SAMA'
    END AS KETERANGAN
FROM tblInfo AS pria
INNER JOIN
tblInfo AS wanita ON pria.pasangan = wanita.noid
WHERE pria.jkelamin = 'P' AND wanita.jkelamin = 'W';