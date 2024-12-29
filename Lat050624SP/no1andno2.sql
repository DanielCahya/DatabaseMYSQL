DROP DATABASE IF EXISTS dbNo1danNo2;
CREATE DATABASE dbNo1danNo2;
USE dbNo1danNo2;

-- Nomor 1;

DELIMITER $$

CREATE PROCEDURE Huruf_in_Kal(IN pKalimat VARCHAR(255))
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE panjKalimat INT DEFAULT LENGTH(pKalimat);
    DECLARE countKarakter INT;
    DECLARE currentChar CHAR(1);

    SET pKalimat = UPPER(pKalimat);

    SET currentChar = 'A';
    WHILE currentChar <= 'Z' DO
        SET countKarakter = 0;

        SET i = 1;
        
        WHILE i <= panjKalimat DO
            IF SUBSTRING(pKalimat, i, 1) = currentChar THEN
                SET countKarakter = countKarakter + 1;
            END IF;

            SET i = i + 1;
        END WHILE;

        IF countKarakter > 0 THEN
            SELECT currentChar AS Huruf,
            countKarakter AS Jumlah;
        END IF;

        SET currentChar = CHAR(ASCII(currentChar) + 1);
    END WHILE;
END;

$$
DELIMITER ;

CALL Huruf_in_Kal('ular berlari lurus');
CALL Huruf_in_Kal('kuku kaki kakek ku kaku');


-- Nomor 2;

DELIMITER $$

CREATE PROCEDURE OutputBerkurang(IN pKalimat VARCHAR(255))
BEGIN
    DECLARE i INT DEFAULT LENGTH(pKalimat);
    DECLARE temp VARCHAR(255);

    SET temp = pKalimat; 

    WHILE i > 0 DO
        IF SUBSTRING(temp, i, 1) != ' ' THEN
            SELECT LEFT(temp, i) AS OUTPUT;
        END IF;
        SET i = i - 1;
    END WHILE;
END;
$$
DELIMITER ;

CALL OutputBerkurang('IKOMUNIKA');
CALL OutputBerkurang('Unika Soegijapranata Semarang');