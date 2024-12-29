DROP DATABASE IF EXISTS lat1;
CREATE DATABASE lat1;
USE lat1;

-- Nomer 1;

DROP PROCEDURE IF EXISTS spConvertSeconds;
DELIMITER $$

CREATE PROCEDURE spConvertSeconds(IN pSeconds INT)
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE seconds INT;

    SET days = pSeconds DIV 86400;

    SET hours = (pSeconds MOD 86400) DIV 3600;

    SET minutes = (pSeconds MOD 3600) DIV 60;

    SET seconds = pSeconds MOD 60;

    SELECT days AS "Hari", hours AS "Jam", minutes AS "Menit", seconds AS "Detik";
END;
$$
DELIMITER ;

CALL spConvertSeconds(10000);

-- Nomor 2;
DROP PROCEDURE IF EXISTS spBmi;
DELIMITER $$
CREATE PROCEDURE spBmi(pTinggi INT, pBerat double)
BEGIN 
    DECLARE hasil double;
    DECLARE notice VARCHAR(50); 

    SET hasil := pBerat / ((pTinggi/100)*(pTinggi/100));

    CASE
        WHEN hasil < 18.5 THEN
            SET notice := 'Kekurangan berat Badan';
        WHEN hasil >= 18.5 AND hasil <= 24.9 THEN
            SET notice := 'Normal(ideal)';
        WHEN hasil >= 25.0 AND hasil <= 29.9 THEN
            SET notice := 'Kelebihan berat Badan';
        WHEN hasil >= 30.0 THEN
            SET notice := 'Kegemukan(Obesitas)';
    END CASE;
    SELECT hasil AS Bmi, notice AS "Status Berat Badan";
END;
$$
DELIMITER ;
CALL spBmi(160,70);

-- Nomor 3;
DROP PROCEDURE IF EXISTS spKabisat;
DELIMITER $$
CREATE PROCEDURE spKabisat(pTahun INT)
BEGIN 
    DECLARE notice VARCHAR(50);
    CASE
        WHEN (mod(pTahun,400))= 0 THEN
            SET notice := 'Kabisat';
        WHEN (mod(pTahun,400) != 0 AND mod(pTahun,100) = 0 ) THEN
            SET notice := 'Not';
        WHEN (mod(pTahun,400) != 0 AND mod(pTahun,100) != 0 AND mod(pTahun,4) = 0 ) THEN
            SET notice := 'Kabisat';
        ELSE
            SET notice := 'Not';
    END CASE;
    SELECT pTahun AS Tahun, notice AS "Kabisat or Not";
END;
$$
DELIMITER ;
CALL spKabisat(2796);

-- 4;

DROP PROCEDURE IF EXISTS spMultiplyDigit;
DELIMITER $$
CREATE PROCEDURE spMultiplyDigit(IN pAngka BIGINT)
BEGIN
    DECLARE currentNumber BIGINT;
    DECLARE digit INT;
    DECLARE hasil BIGINT;
    
    SET currentNumber = pAngka;
    
    WHILE currentNumber >= 10 DO
        SET hasil = 1;
        
        WHILE currentNumber > 0 DO
            SET digit = currentNumber % 10;
            SET hasil = hasil * digit;
            SET currentNumber = currentNumber DIV 10;
        END WHILE;
        
        SET currentNumber = hasil;
    END WHILE;
    
    SELECT currentNumber AS FinalResult;
END;
$$
DELIMITER ;

CALL spMultiplyDigit(12346);


-- Nomor 6;
DROP PROCEDURE IF EXISTS spCountCharacters;
DELIMITER $$

CREATE PROCEDURE spCountCharacters(IN pInputString VARCHAR(255))
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE len INT;
    DECLARE currentChar CHAR(1);
    DECLARE vokalCount INT DEFAULT 0;
    DECLARE konsonanCount INT DEFAULT 0;
    DECLARE otherCount INT DEFAULT 0;

    SET len = CHAR_LENGTH(pInputString);

    WHILE i <= len DO
        SET currentChar = SUBSTRING(pInputString, i, 1);

        IF currentChar IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u') THEN
            SET vokalCount = vokalCount + 1;

        ELSEIF currentChar REGEXP '[a-zA-Z]' THEN
            SET konsonanCount = konsonanCount + 1;
        
        ELSE
            SET otherCount = otherCount + 1;
        END IF;

        SET i = i + 1;
    END WHILE;

    SELECT vokalCount AS "Huruf Vokal", konsonanCount AS "Konsonan", otherCount AS "Karakter Lain";
END;
$$
DELIMITER ;

CALL spCountCharacters('FAKULTAS ILMU KOMPUTER');


-- Nomer 7;

DROP PROCEDURE IF EXISTS spGrade;
DELIMITER $$

CREATE PROCEDURE spGrade(IN pGrade INT)
BEGIN
    DECLARE nilaiHuruf CHAR(2);

    IF pGrade > 80 THEN
        SET nilaiHuruf = 'A';
    ELSEIF pGrade BETWEEN 75 AND 79 THEN
        SET nilaiHuruf = 'AB';
    ELSEIF pGrade BETWEEN 70 AND 74 THEN
        SET nilaiHuruf = 'B';
    ELSEIF pGrade BETWEEN 65 AND 69 THEN
        SET nilaiHuruf = 'BC';
    ELSEIF pGrade BETWEEN 60 AND 64 THEN
        SET nilaiHuruf = 'C';
    ELSEIF pGrade BETWEEN 55 AND 59 THEN
        SET nilaiHuruf = 'CD';
    ELSEIF pGrade BETWEEN 50 AND 54 THEN
        SET nilaiHuruf = 'D';
    ELSE
        SET nilaiHuruf = 'E';
    END IF;

    SELECT pGrade AS 'Numeric Grade', nilaiHuruf AS 'Letter Grade';
END;
$$
DELIMITER ;

CALL spGrade(85);