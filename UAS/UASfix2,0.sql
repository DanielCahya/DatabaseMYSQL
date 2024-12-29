DROP DATABASE IF EXISTS dbUAS;
CREATE DATABASE dbUAS;
USE dbUAS;

CREATE TABLE tblMKU (
  kodeMku CHAR(1) PRIMARY KEY,
  matkulMKU VARCHAR(50),
  jumlah INT
);

CREATE TABLE tblDosen (
  kodeDosen CHAR(1) PRIMARY KEY,
  namaDosen VARCHAR(45)
);

CREATE TABLE tblJadwal (
  kodeJadwal INT PRIMARY KEY,
  hari VARCHAR(12),
  jam VARCHAR(20)
);

CREATE TABLE tblRandomJadwal (
  kodeMku CHAR(1),
  kodeJadwal INT,
  kodeDosen CHAR(1),
  FOREIGN KEY (kodeMku) REFERENCES tblMKU(kodeMku),
  FOREIGN KEY (kodeJadwal) REFERENCES tblJadwal(kodeJadwal),
  FOREIGN KEY (kodeDosen) REFERENCES tblDosen(kodeDosen)
);

INSERT INTO tblMKU VALUES 
('K', 'Kewarganegaraan', 8),
('P', 'Pancasila', 5),
('R', 'Religiusitas', 9);

INSERT INTO tblDosen VALUES 
('A', 'Ali'),
('B', 'Beni'),
('R', 'Romi'),
('S', 'Sugeng');

INSERT INTO tblJadwal VALUES
(1,'SENIN', '08.00-10.00'),
(2,'SENIN', '10.00-12.00'),
(3,'SENIN', '12.00-14.00'),
(4,'SENIN', '14.00-16.00'),
(5,'SELASA', '08.00-10.00'),
(6,'SELASA', '10.00-12.00'),
(7,'SELASA', '12.00-14.00'),
(8,'SELASA', '14.00-16.00'),
(9,'RABU', '08.00-10.00'),
(10,'RABU', '10.00-12.00'),
(11,'RABU', '12.00-14.00'),
(12,'RABU', '14.00-16.00'),
(13,'KAMIS', '08.00-10.00'),
(14,'KAMIS', '10.00-12.00'),
(15,'KAMIS', '12.00-14.00'),
(16,'KAMIS', '14.00-16.00'),
(17,'JUMAT', '08.00-10.00'),
(18,'JUMAT', '10.00-12.00'),
(19,'JUMAT', '12.00-14.00'),
(20,'JUMAT', '14.00-16.00');


DELIMITER $$
CREATE PROCEDURE spRandomJadwal()
BEGIN
  DECLARE vKodeMKU CHAR(1);
  DECLARE vJumlah INT;
  DECLARE vJumData INT;
  DECLARE i INT DEFAULT 1;
  DECLARE j INT DEFAULT 1;
  DECLARE vKodeJadwal INT;
  DECLARE vKodeDosen CHAR(1);
  DECLARE vMin INT;
  DECLARE vMax INT;
  DECLARE vCekAda INT;
  
  DECLARE cMKU CURSOR FOR
    SELECT kodeMku, jumlah FROM tblMKU;
  
  SELECT COUNT(*) INTO vJumData
  FROM tblMKU;
  
  SELECT MIN(kodeJadwal) INTO vMin
  FROM tblJadwal;
  
  SELECT MAX(kodeJadwal) INTO vMax
  FROM tblJadwal;
  
  OPEN cMKU;
  SET i:=1;
  loop_i: WHILE i <= vJumData DO
    FETCH cMKU INTO vKodeMKU, vJumlah;    
    SET j:=vMin;
    loopj: WHILE j <= vJumlah DO      
      IF vKodeMKU = 'K' THEN
        
        IF RAND() < 0.5 THEN
          SET vKodeDosen = 'A';
        ELSE
          SET vKodeDosen = 'B';
        END IF;
      ELSEIF vKodeMKU = 'P' THEN

        IF RAND() < 0.5 THEN
          SET vKodeDosen = 'A';
        ELSE
          SET vKodeDosen = 'B';
        END IF;
      ELSEIF vKodeMKU = 'R' THEN

        IF RAND() < 0.5 THEN
          SET vKodeDosen = 'R';
        ELSE
          SET vKodeDosen = 'S';
        END IF;
      END IF;
      
      SELECT FLOOR(RAND()*(vMax-vMin)+vMin) INTO vKodeJadwal;
      
      SELECT COUNT(*) INTO vCekAda
      FROM tblRandomJadwal
      WHERE kodeDosen = vKodeDosen AND kodeJadwal = vKodeJadwal;
      
      IF vCekAda = 0 THEN
        INSERT INTO tblRandomJadwal 
        VALUES(vKodeMKU, vKodeJadwal, vKodeDosen);
        
        SET j:=j+1;
      END IF;
    END WHILE loopj;
    
    SET i=i+1;
  END WHILE loop_i;
  CLOSE cMKU; 
END;
$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trgPreventDuplicateJadwal
BEFORE INSERT ON tblRandomJadwal
FOR EACH ROW
BEGIN
  IF EXISTS (
    SELECT 1
    FROM tblRandomJadwal
    WHERE kodeDosen = NEW.kodeDosen AND kodeJadwal = NEW.kodeJadwal
  ) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Dosen already has a jadwal at this time';
  END IF;
END;
$$
DELIMITER ;

CALL spRandomJadwal();

SELECT 
  tblMKU.matkulMKU AS MATKUL_MKU,
  tblJadwal.jam AS JAM,
  tblJadwal.hari AS HARI,
  tblDosen.namaDosen AS DOSEN
FROM 
  tblMKU 
  INNER JOIN tblRandomJadwal ON (tblMKU.kodeMku = tblRandomJadwal.kodeMku)
  INNER JOIN tblJadwal ON (tblJadwal.kodeJadwal = tblRandomJadwal.kodeJadwal)
  INNER JOIN tblDosen ON (tblDosen.kodeDosen = tblRandomJadwal.kodeDosen);