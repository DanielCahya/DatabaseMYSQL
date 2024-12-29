DROP DATABASE IF EXISTS dbSF;
CREATE DATABASE dbSF;
USE dbSF;

CREATE TABLE tblSF (
    nomor INTEGER,
    nama VARCHAR(50)
);

-- SF untuk memasukkan nilai

DROP FUNCTION IF EXISTS sfInputData;

DELIMITER $$

CREATE FUNCTION sfInputData (pNomor INTEGER , pNama VARCHAR(50))
RETURNS VARCHAR(200)

BEGIN
    DECLARE vJumlah INTEGER;
    DECLARE vPesan VARCHAR(200);

    SELECT COUNT(*) INTO vJumlah
    FROM tblSF
    WHERE nama = pNama;

    IF vJumlah = 0 THEN
        INSERT INTO tblSF (nomor, nama) VALUES 
        (pNomor, pNama);
        
        SET vPesan = CONCAT('DATA ', pNama, ' BELUM ADA, DATA DISIMPAN');
    ELSE
        SET vPesan = CONCAT('DATA ', pNama, ' SUDAH ADA');
    END IF;

    RETURN vPesan;
END;    
$$
DELIMITER ;

-- KALO SP MENGGUNAKAN CALL, KALO SF SEPERTI INI MENGGUNAKAN SELECT
SELECT sfInputData(1, 'KAT') AS PESAN;
SELECT sfInputData(2, 'ARINA') AS PESAN;
SELECT sfInputData(3, 'KAT') AS PESAN;

SELECT * FROM tblSF;

CREATE TABLE tblNomor7(
    urut INTEGER,
    angka INTEGER,
    huruf VARCHAR(2)
);

INSERT INTO tblNomor7 VALUES
(1,80,'A'),
(2,75,'AB'),
(3,70,'B'),
(4,65,'BC'),
(5,60,'C'),
(6,55,'CD'),
(7,50,'D'),
(8,0,'E');

DROP FUNCTION IF EXISTS sfNomor7;
DELIMITER $$
CREATE FUNCTION sfNomor7 (pNilai INTEGER)
RETURNS VARCHAR(100)
BEGIN
    DECLARE i INTEGER;
    DECLARE vCek INTEGER;
    DECLARE vAmbilHuruf VARCHAR(2);

    SET i := 1;
    loophuruf: WHILE i <= 8 DO
        SELECT angka INTO vCek
        FROM tblNomor7
        WHERE urut = i;

        IF pNilai >= vCek THEN
            SELECT huruf INTO vAmbilHuruf
            FROM tblNomor7
            WHERE urut = i;

            LEAVE loophuruf;
        END IF;
        
        SET i = i + 1;
    END WHILE loophuruf;

    RETURN vAmbilHuruf;
END;


$$

DELIMITER ;

SELECT sfNomor7(73) AS Huruf;
SELECT sfNomor7(83) AS Huruf;
SELECT sfNomor7(57) AS Huruf;
SELECT sfNomor7(40) AS Huruf;



CREATE TABLE tblRomawi(

    nomor INT,
    angka INT,
    romawi VARCHAR(5)
);

INSERT INTO tblRomawi VALUES
(1,1,'I'),
(2,4,'IV'),
(3,5,'V'),
(4,9,'IX'),
(5,10,'X'),
(6,40,'XL'),
(7,50,'L'),
(8,90,'XC'),
(9,100,'C'),
(10,400,'CD'),
(11,500,'D'),
(12,900,'CM'),
(13,1000,'M');

DROP FUNCTION IF EXISTS sfRomawi;
DELIMITER $$
CREATE FUNCTION sfRomawi (pAngka INTEGER)
RETURNS VARCHAR(100)
BEGIN
    DECLARE vAngka INT;
    DECLARE vRomawi VARCHAR(2);
    DECLARE vHasilAkhir VARCHAR(100) DEFAULT '';
    DECLARE vJum INT;

    loopromawi: LOOP
        SELECT COUNT(*) INTO vJum 
        FROM tblRomawi
        WHERE angka <= pAngka;

        IF vJum = 0 THEN 
            LEAVE loopromawi;
        END IF;

        SELECT angka, romawi INTO vAngka, vRomawi
        FROM tblRomawi
        WHERE angka <= pAngka
        ORDER BY nomor DESC
        LIMIT 1;

        SET vHasilAkhir = CONCAT(vHasilAkhir, vRomawi);

        SET pAngka = pAngka - vAngka;
    END LOOP loopromawi;

    RETURN vHasilAkhir;
END
$$
DELIMITER ;

SELECT sfRomawi(2024) AS ROMAWI;