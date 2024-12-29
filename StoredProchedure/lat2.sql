DROP DATABASE IF EXISTS dbSF1;
CREATE DATABASE dbSF1;
USE dbSF1;
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

SELECT sfRomawi(2023) AS ROMAWI;

CREATE TABLE tblPecahanUang(

    nomor INT,
    angka INT,
    jumlah INT
);

INSERT INTO tblPecahanUang VALUES
(1,100000,'0'),
(2,50000,'0'),
(3,20000,'0'),
(4,10000,'0'),
(5,5000,'0'),
(6,2000,'0'),
(7,1000,'0'),
(8,500,'0'),
(9,200,'0'),
(10,100,'0');

DROP FUNCTION IF EXISTS sfPecahanUang;
DELIMITER $$
CREATE FUNCTION sfPecahanUang (pJumUang INTEGER)
RETURNS VARCHAR(100)
BEGIN
    DECLARE vAngka INT;
    DECLARE vJumlah INT;
    DECLARE vHasilAkhir VARCHAR(100) DEFAULT '';
    DECLARE vJum INT;

    loopromawi: LOOP
        SELECT COUNT(*) INTO vJum 
        FROM tblRomawi
        WHERE angka <= pJumUang;

        IF vJum = 0 THEN 
            LEAVE loopromawi;
        END IF;

        SELECT angka, romawi INTO vAngka, vJumlah
        FROM tblRomawi
        WHERE angka <= pJumUang
        ORDER BY nomor DESC
        LIMIT 1;

        SET vHasilAkhir = CONCAT(vHasilAkhir, vJumlah);

        SET pJumUang = pJumUang - vAngka;
    END LOOP loopromawi;

    RETURN vHasilAkhir;
END
$$
DELIMITER ;

SELECT sfPecahanUang(100000) AS Jumlah;