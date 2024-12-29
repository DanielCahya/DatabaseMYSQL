DROP DATABASE IF EXISTS dbNilai;
CREATE DATABASE dbNilai;
USE dbNilai;

CREATE TABLE tblMapel(
    kodemapel ENUM('MAT','ING','IND','MAN','KIM','FIS','BIO') PRIMARY KEY,
    namamapel VARCHAR(20)
);

INSERT INTO tblMapel
VALUES ('MAT','MATEMATIKA'),
('ING','MATEMATIKA'),
('IND','MATEMATIKA'),
('MAN','MANDARIN'),
('KIM','KIMIA'),
('FIS','FISIKA'),
('BIO','BIOLOGI');

SELECT * 
from tblMapel AS mape;

CREATE TABLE tblKomponen(
    kode VARCHAR(5) PRIMARY KEY,
    komponen VARCHAR(15),
    prosentase DECIMAL
);


INSERT INTO tblKomponen
VALUES('TGS','TUGAS',40),
('UTS','UJIAN TENGAH',30),
('UAS','UJIAN AKHIR',30);

SELECT kom.kode,kom.komponen,kom.prosentase
FROM tblKomponen AS kom;

CREATE TABLE tblSiswa(
    nis VARCHAR(5) PRIMARY KEY,
    nama VARCHAR(5)
);

INSERT INTO tblSiswa
VALUES ('SO1','REZA'),
('SO2','JOVITA'),
('SO3','ANDRE'),
('SO4','MARLON');

SELECT sis.nis,sis.nama
FROM tblSiswa AS sis;

CREATE TABLE tblNilai(
    nis VARCHAR(5),
    kode VARCHAR(5),
    kodemapel ENUM('MAT','ING','IND','MAN','KIM','FIS','BIO'),
    nilai INT,
    FOREIGN KEY(nis) REFERENCES tblSiswa(nis),
    FOREIGN KEY(kode) REFERENCES tblKomponen(kode),
    FOREIGN KEY(kodemapel) REFERENCES tblMapel(kodemapel)
);


SELECT dbNilai.tblMapel.kodemapel
FROM dbNilai.tblMapel;

INSERT INTO tblNilai(kodemapel,kode,nis,nilai)
SELECT mape.kodemapel,kom.kode, sis.nis, RAND()*100
FROM tblKomponen AS kom,tblMapel AS mape, tblSiswa AS sis;

DELETE FROM tblNilai
WHERE nilai <= 50;
DELETE FROM tblNilai
WHERE KODE='TGS';
DELETE FROM tblNilai
WHERE KODE='UAS';

SELECT * 
FROM tblNilai;

-- -- JOIN 2 TABLE

-- -- SELECT tblSiswa.nama,tblNilai.nilai
-- -- FROM tblNilai, tblSiswa
-- -- WHERE tblSiswa.nis = tblNilai.nis;

-- -- JOIN 3 TABLE
-- SELECT tblSiswa.nama, tblKomponen.kode,tblNilai.nilai
-- FROM tblSiswa,tblKomponen,tblNilai
-- WHERE tblNilai.nis = tblSiswa.nis AND tblKomponen.kode = tblNilai.kode;

-- -- EQUAL JOIN
-- SELECT tblSiswa.nama, tblKomponen.kode,tblNilai.nilai
-- FROM tblSiswa,tblKomponen,tblNilai
-- WHERE tblNilai.nis = tblSiswa.nis AND tblKomponen.kode = tblNilai.kode;

-- -- NATURAL JOIN
-- SELECT tblNilai.nilai,tblSiswa.nama
-- FROM tblNilai NATURAL JOIN tblSiswa;

-- NATURAL JOIN 3 TABLE
SELECT tblNilai.nilai,tblSiswa.nama,tblKomponen.kode
FROM tblNilai NATURAL JOIN tblSiswa NATURAL JOIN tblKomponen;

-- -- INNER JOIN
-- SELECT tblNilai.nilai,tblSiswa.nama
-- FROM tblNilai INNER JOIN tblSiswa ON (tblSiswa.nis = tblNilai.nis);

-- INNER JOIN 3 TABLE
SELECT tblNilai.nilai,tblSiswa.nama,tblKomponen.kode
FROM tblNilai INNER JOIN tblSiswa INNER JOIN tblKomponen ON (tblSiswa.nis = tblNilai.nis) AND (tblNilai.kode=tblKomponen.kode);

-- -- CROSS JOIN
-- SELECT tblNilai.nilai,tblSiswa.nama
-- FROM tblNilai CROSS JOIN tblSiswa USING (nis);

-- CROSS JOIN 3 TABLE
-- SELECT tblNilai.nilai,tblSiswa.nama,tblKomponen.kode
-- FROM tblNilai CROSS JOIN tblSiswa CROSS JOIN tblKomponen USING (nis) AND (kode);

-- -- OUTER JOIN
-- -- LEFT JOIN
SELECT tblKomponen.kode AS TABLE_KOMPONEN,
tblNilai.kode AS TABLE_NILAI
FROM tblKomponen LEFT JOIN tblNilai ON (tblKomponen.kode = tblNilai.kode)
WHERE tblNilai.kode IS NULL;

-- SELECT tblNilai.kode AS TABLE_NILAI,
-- tblKomponen.kode AS TABLE_KOMPONEN

-- FROM tblNilai RIGHT JOIN tblKomponen ON (tblKomponen.kode = tblNilai.kode)
-- WHERE tblNilai.kode IS NULL;

SELECT tblKomponen.kode
FROM tblKomponen
WHERE kode NOT IN (SELECT kode FROM tblNilai);