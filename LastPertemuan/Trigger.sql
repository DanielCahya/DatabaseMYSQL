/*
- Automatisasi data di Database
- Automatisasi -> Insert,Update,Delete
- Yang perlu diperhatikan sebelum menggunakan Trigger :
    a. Menentukan apakah trigger di eksekusi sebelum (Before) atau setelah (after) data diproses

    b. Menentukan Nilai dari trigger yang akan dimanfaatkan, nilai yang lama (OLD) atau nilai yang baru (NEW)

Studi Kasus :
- membuat automatisasi rekapitulasi data untuk pendaftaran kegiatan seminar di IKOM

*/

DROP DATABASE IF EXISTS dbSeminar;
CREATE DATABASE dbSeminar;
USE dbSeminar;

CREATE TABLE tblPendaftaran(
    nim VARCHAR(10) PRIMARY KEY,
    nama VARCHAR (100) NOT NULL
);



SELECT * FROM tblPendaftaran;

CREATE TABLE tblRekapitulasi(
    angkatan VARCHAR(2),
    jumlah INT
);

-- INSERT INTO tblPendaftaran VALUES;



DELIMITER $$

CREATE TRIGGER trgRekapNambah
AFTER INSERT ON tblPendaftaran

FOR EACH ROW
BEGIN
    DECLARE vAngkatan VARCHAR(2);
    DECLARE vJumlah INT;

    SET vAngkatan:=LEFT(NEW.nim, 2);

    SELECT COUNT(*) INTO vJumlah
    FROM tblRekapitulasi
    WHERE angkatan = vAngkatan;

    IF vJumlah = 0 THEN
        INSERT INTO tblRekapitulasi VALUES
        (vAngkatan, 1);
    ELSE
        UPDATE tblRekapitulasi
        SET jumlah= jumlah + 1
        WHERE angkatan = vAngkatan;
    END IF;
END $$
DELIMITER ;

INSERT INTO tblPendaftaran VALUES
('22.K1.0039','DANIEL'),
('20.K1.0038','DARIUS'),
('21.K1.0037','YONE'),
('20.K1.0036','YASUO'),
('20.K1.0035','LUX');

SELECT * FROM tblRekapitulasi;


DELIMITER $$
CREATE TRIGGER trgRekapKurang
AFTER DELETE ON tblPendaftaran

FOR EACH ROW
BEGIN
    DECLARE vAngkatan VARCHAR(2);
    DECLARE vJumlah INT;

    SET vAngkatan:=LEFT(OLD.nim, 2);

    UPDATE tblRekapitulasi
    SET jumlah= jumlah - 1
    WHERE angkatan = vAngkatan;
END $$
DELIMITER ;


/* Secara Umum 
Insert -> NEW
update & delete -> OLD

*/