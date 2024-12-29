DROP DATABASE IF EXISTS dblatUas;
CREATE DATABASE dblatUas;
USE dblatUas;

-- Buat tabel untuk menyimpan jadwal ujian
CREATE TABLE JadwalUjian (
    MATA_KULIAH_MKU VARCHAR(50),
    JAM TIME,
    HARI VARCHAR(10)
);

-- Buat stored procedure untuk menjadwalkan ujian secara random
DELIMITER //
CREATE PROCEDURE PenjadwalanUjian()
BEGIN
    DECLARE Vdone INT DEFAULT FALSE;
    DECLARE Vmata_kuliah VARCHAR(50);
    DECLARE Vjumlah INT;
    DECLARE Vhari VARCHAR(10);
    DECLARE Vjam TIME;
    DECLARE Vcounter INT DEFAULT 0;
    
    -- Cursor untuk iterasi mata kuliah
    DECLARE mata_kuliah_cursor CURSOR FOR
        SELECT MATA_KULIAH_MKU, JUMLAH FROM (
            SELECT 'KEWARGANEGARAAN' AS MATA_KULIAH_MKU, 6 AS JUMLAH
            UNION ALL
            SELECT 'PANCASILA', 5
            UNION ALL
            SELECT 'RELIGIUSITAS', 4
        ) AS MKU;
        
    -- Handler untuk end of data
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET Vdone = TRUE;
    
    -- Buka cursor
    OPEN mata_kuliah_cursor;
    
    -- Loop untuk setiap mata kuliah
    read_loop: LOOP
        FETCH mata_kuliah_cursor INTO Vmata_kuliah, Vjumlah;
        IF Vdone THEN
            LEAVE read_loop;
        END IF;
        
        SET Vcounter = 0;
        
        -- Loop untuk jumlah kelas mata kuliah
        WHILE Vcounter < Vjumlah DO
            -- Pilih hari dan jam secara random
            SET Vhari = (SELECT CASE FLOOR(1 + RAND() * 5)
                               WHEN 1 THEN 'SENIN'
                               WHEN 2 THEN 'SELASA'
                               WHEN 3 THEN 'RABU'
                               WHEN 4 THEN 'KAMIS'
                               WHEN 5 THEN 'JUMAT'
                           END);
            SET Vjam = (SELECT CASE FLOOR(1 + RAND() * 5)
                              WHEN 1 THEN '08:00:00-10:00:00'
                              WHEN 2 THEN '10:00:00-12:00:00'
                              WHEN 3 THEN '12:00:00-14:00:00'
                              WHEN 4 THEN '14:00:00-16:00:00'
                              WHEN 5 THEN '16:00:00'
                          END);
                          
            -- Cek apakah jadwal sudah ada untuk mata kuliah yang sama di hari dan jam yang sama
            IF NOT EXISTS (SELECT 1 FROM JadwalUjian WHERE MATA_KULIAH_MKU = Vmata_kuliah AND HARI = Vhari AND JAM = Vjam) THEN
                -- Insert jadwal ujian
                INSERT INTO JadwalUjian (MATA_KULIAH_MKU, JAM, HARI)
                VALUES (Vmata_kuliah, Vjam, Vhari);
                SET Vcounter = Vcounter + 1;
            END IF;
        END WHILE;
    END LOOP;
    
    -- Tutup cursor
    CLOSE mata_kuliah_cursor;
END //
DELIMITER ;

-- Jalankan stored procedure
CALL PenjadwalanUjian();

-- Tampilkan jadwal ujian
SELECT * FROM JadwalUjian;



