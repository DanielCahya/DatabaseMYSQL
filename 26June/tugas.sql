DROP DATABASE IF EXISTS tugasSF;
CREATE DATABASE tugasSF;
USE tugasSF;

DROP TABLE IF EXISTS tblAlfabet;
CREATE TABLE tblAlfabet (
  id INT,
  huruf VARCHAR(1)
);

INSERT INTO tblAlfabet VALUES
  (1, 'A'), (2, 'B'), (3, 'C'), (4, 'D'), (5, 'E'), (6, 'F'), (7, 'G'), (8, 'H'), (9, 'I'), (10, 'J'),
  (11, 'K'), (12, 'L'), (13, 'M'), (14, 'N'), (15, 'O'), (16, 'P'), (17, 'Q'), (18, 'R'), (19, 'S'), (20, 'T'),
  (21, 'U'), (22, 'V'), (23, 'W'), (24, 'X'), (25, 'Y'), (26, 'Z');

DELIMITER $$
DROP FUNCTION IF EXISTS sfEncrypt;
CREATE FUNCTION sfEncrypt(text VARCHAR(50), kunci INT) RETURNS VARCHAR(50)
BEGIN
  DECLARE hasil VARCHAR(50) DEFAULT '';
  DECLARE i INT DEFAULT 1;
  DECLARE vHuruf_char VARCHAR(1);
  DECLARE vHuruf_id INT;
  DECLARE vGeser_id INT;

  WHILE i <= LENGTH(text) DO
    SET vHuruf_char = UPPER(SUBSTR(text, i, 1));

    IF vHuruf_char REGEXP '[A-Z]' THEN
      SET vHuruf_id = (SELECT id FROM tblAlfabet WHERE huruf = vHuruf_char);

      SET vGeser_id = ((vHuruf_id - kunci - 1 + 26) % 26) + 1;

      SET hasil = CONCAT(hasil, (SELECT huruf FROM tblAlfabet WHERE id = vGeser_id));
    ELSE
      SET hasil = CONCAT(hasil, vHuruf_char);
    END IF;

    SET i = i + 1;
  END WHILE;

  RETURN hasil;
END;
$$
DELIMITER ;

SELECT sfEncrypt('IKOM', 7) AS hasil;
SELECT sfEncrypt('IKOM', 5) AS hasil;
SELECT sfEncrypt('SAYA', 7) AS hasil;
SELECT sfEncrypt('DANIEL', 7) AS hasil;