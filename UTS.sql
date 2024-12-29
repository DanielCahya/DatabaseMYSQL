DROP DATABASE IF EXISTS dbUTS;
CREATE DATABASE dbUTS;
USE dbUTS;
CREATE TABLE tblAtlet (
    id INT PRIMARY KEY,
    nama VARCHAR(50),
    jeniskelamin CHAR(1),
    beratbadan INT,
    tinggibadan INT,
    prestasi VARCHAR(20)
);

-- SOAL 1;
INSERT INTO tblAtlet (id,nama, jeniskelamin, beratbadan, tinggibadan, prestasi) VALUES
(0,'Aatrox', 'L', 57, 171, 'NASIONAL'),
(1,'Bella', 'P', 69, 168, 'NASIONAL'),
(2,'Camile', 'P', 74, 178, 'NASIONAL'),
(3,'Daniel', 'L', 68, 174, 'INTERNASIONAL'),
(4,'Ester', 'P', 61, 172, 'LOKAL'),
(5,'Fritz', 'L', 72, 172, 'LOKAL'),
(6,'Gundogan', 'L', 76, 181, 'LOKAL'),
(7,'Halaand', 'L', 66, 172, 'INTERNASIONAL'),
(8,'Indah', 'P', 73, 171, 'NASIONAL'),
(9,'Jhonathan', 'L', 67, 176, 'LOKAL');

DROP VIEW IF EXISTS vwJawaban1;
CREATE VIEW vwJawaban1 AS
    SELECT * FROM tblAtlet;

SELECT * FROM vwJawaban1;

-- SOAL 2;
DROP VIEW IF EXISTS vwJawaban2;
CREATE VIEW vwJawaban2 AS
    SELECT
        atlet1.nama AS NAMA_ATLIT_1,
        atlet1.beratbadan AS BERAT_ATLIT_1,
        atlet2.nama AS NAMA_ATLIT_2,
        atlet2.beratbadan AS BERAT_ATLIT_2,
        CASE
            WHEN atlet2.beratbadan > atlet1.beratbadan THEN CONCAT(atlet2.nama, ' LEBIH BERAT DARI ', atlet1.nama, ' : ', atlet2.beratbadan - atlet1.beratbadan, ' Kg')
            WHEN atlet2.beratbadan < atlet1.beratbadan THEN CONCAT(atlet1.nama, ' LEBIH BERAT DARI ', atlet2.nama, ' : ', atlet1.beratbadan - atlet2.beratbadan, ' Kg')
            ELSE CONCAT(atlet1.nama, ' Dan ', atlet2.nama, ' Berat Sama')
        END AS "PERBANDINGAN BERAT BADAN" 
    FROM tblAtlet atlet1
    JOIN tblAtlet atlet2
    ON atlet1.id = atlet2.id - 1
    ORDER BY atlet1.id;

SELECT * FROM vwJawaban2;

-- SOAL 3;
DROP VIEW IF EXISTS vwJawaban3;
CREATE VIEW vwJawaban3 AS
    SELECT
        atlet1.nama AS NAMA_ATLIT_1,
        atlet1.tinggibadan AS TINGGI_ATLIT_1,
        atlet2.nama AS NAMA_ATLIT_2,
        atlet2.tinggibadan AS TINGGI_ATLIT_2,
        CASE
            WHEN atlet1.tinggibadan > atlet2.tinggibadan THEN CONCAT(atlet1.nama, ' LEBIH TINGGI DARI ', atlet2.nama, ' : ', atlet1.tinggibadan - atlet2.tinggibadan, ' Cm')
            WHEN atlet1.tinggibadan < atlet2.tinggibadan THEN CONCAT(atlet2.nama, ' LEBIH TINGGI DARI ', atlet1.nama, ' : ', atlet2.tinggibadan - atlet1.tinggibadan, ' Cm')
            ELSE CONCAT(atlet1.nama, ' SAMA TINGGI DENGAN ', atlet2.nama)
        END AS "PERBANDINGAN TINGGI BADAN"
    FROM tblAtlet atlet1
    JOIN tblAtlet atlet2
    ON atlet1.id = atlet2.id - 1
    WHERE atlet1.tinggibadan > 170 AND atlet2.tinggibadan > 170
    ORDER BY atlet1.id;

SELECT * FROM vwJawaban3;

-- Soal 4;
DROP VIEW IF EXISTS vwJawaban4;
CREATE VIEW vwJawaban4 AS
    SELECT
        atlet1.nama AS NAMA_ATLIT_1,
        atlet1.prestasi AS PRESTASI_ATLIT_1,
        atlet2.nama AS NAMA_ATLIT_2,
        atlet2.prestasi AS PRESTASI_ATLIT_2,
        CASE
            WHEN atlet1.prestasi = 'INTERNASIONAL' AND atlet2.prestasi = 'NASIONAL' THEN CONCAT(atlet1.nama, ' LEBIH BAIK DARI ', atlet2.nama)
            WHEN atlet1.prestasi = 'INTERNASIONAL' AND atlet2.prestasi = 'LOKAL' THEN CONCAT(atlet1.nama, ' LEBIH BAIK DARI ', atlet2.nama)
            WHEN atlet1.prestasi = 'NASIONAL' AND atlet2.prestasi = 'LOKAL' THEN CONCAT(atlet1.nama, ' LEBIH BAIK DARI ', atlet2.nama)
            WHEN atlet1.prestasi = atlet2.prestasi THEN CONCAT(atlet1.nama, ' SAMA BAGUS DENGAN ', atlet2.nama)
            ELSE CONCAT(atlet1.nama, ' LEBIH BURUK DARI ', atlet2.nama)
        END AS "PERBANDINGAN PRESTASI"
    FROM tblAtlet atlet1
    JOIN tblAtlet atlet2
    ON atlet1.id = atlet2.id - 1
    ORDER BY atlet1.id;

SELECT * FROM vwJawaban4;
