DROP DATABASE IF EXISTS dblatUas;
CREATE DATABASE dblatUas;
USE dblatUas;

CREATE TABLE IF NOT EXISTS JadwalUjian (
    MATA_KULIAH_MKU VARCHAR(100),
    JAM VARCHAR(20),
    HARI VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS WaktuTersedia (
    JAM VARCHAR(20),
    HARI VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS PenjadwalanMataKuliahUmum (
    KODE_MKU VARCHAR(10),
    MATA_KULIAH_MKU VARCHAR(100),
    JUMLAH INT
);

INSERT INTO PenjadwalanMataKuliahUmum (KODE_MKU, MATA_KULIAH_MKU, JUMLAH)
VALUES
('K', 'KEWARGANEGARAAN', 6),
('P', 'PANCASILA', 5),
('R', 'RELIGIUSITAS', 4);

INSERT INTO WaktuTersedia (JAM, HARI)
VALUES
('08.00-10.00', 'SENIN'), ('10.00-12.00', 'SENIN'),
('12.00-14.00', 'SENIN'), ('14.00-16.00', 'SENIN'),
('08.00-10.00', 'SELASA'), ('10.00-12.00', 'SELASA'),
('12.00-14.00', 'SELASA'), ('14.00-16.00', 'SELASA'),
('08.00-10.00', 'RABU'), ('10.00-12.00', 'RABU'),
('12.00-14.00', 'RABU'), ('14.00-16.00', 'RABU'),
('08.00-10.00', 'KAMIS'), ('10.00-12.00', 'KAMIS'),
('12.00-14.00', 'KAMIS'), ('14.00-16.00', 'KAMIS'),
('08.00-10.00', 'JUMAT'), ('10.00-12.00', 'JUMAT'),
('12.00-14.00', 'JUMAT'), ('14.00-16.00', 'JUMAT');

DELIMITER //

CREATE PROCEDURE GenerateExamSchedule1()
BEGIN
    DECLARE v_mata_kuliah VARCHAR(100);
    DECLARE v_jumlah_kelas INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE kelas INT;

    DECLARE cur_course CURSOR FOR 
        SELECT MATA_KULIAH_MKU, JUMLAH
        FROM PenjadwalanMataKuliahUmum;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur_course;

    course_loop: LOOP
        FETCH cur_course INTO v_mata_kuliah, v_jumlah_kelas;
        IF done THEN
            LEAVE course_loop;
        END IF;

        SET kelas = 1;

        WHILE kelas <= v_jumlah_kelas DO

            SET @selected_time := (SELECT JAM FROM WaktuTersedia ORDER BY RAND() LIMIT 1);
            SET @selected_day := (SELECT HARI FROM WaktuTersedia ORDER BY RAND() LIMIT 1);


            IF NOT EXISTS (
                SELECT 1 FROM JadwalUjian
                WHERE JAM = @selected_time AND HARI = @selected_day
            ) THEN
                INSERT INTO JadwalUjian (MATA_KULIAH_MKU, JAM, HARI)
                VALUES (v_mata_kuliah, @selected_time, @selected_day);
                
                DELETE FROM WaktuTersedia
                WHERE JAM = @selected_time AND HARI = @selected_day;

                SET kelas = kelas + 1;
            END IF;
        END WHILE;
    END LOOP;

    CLOSE cur_course;
END //
DELIMITER ;

CALL GenerateExamSchedule1();

SELECT * FROM JadwalUjian;
