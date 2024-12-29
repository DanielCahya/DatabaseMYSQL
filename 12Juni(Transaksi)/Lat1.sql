DROP DATABASE IF EXISTS dbTransaksi;
CREATE DATABASE dbTransaksi;
USE dbTransaksi;

CREATE TABLE tblListToDo (
    nourut INT,
    jam TIMESTAMP,
    kegiatan VARCHAR(255)
) ENGINE = InnoDB;

/*

Transaksi hanya mengenal 2 kondisi/situasi :

1. Commit = data disetujui dan diproses ke dalam database2
2. Rollback = data dikembalikan ke posisi tertentu

*/

SET autocommit = FALSE;
-- SET autocommit = 0;

-- TANPA TRANSACTION
INSERT INTO tblListToDo VALUES
(1,'2024-06-12 10:00:00','Diskusi Kelompok');

Select * FROM tblListToDo;

-- DENGAN TRANSACTION

START TRANSACTION;
INSERT INTO tblListToDo VALUES
(2,'2024-06-12 12:00:00','Kuliah Gay');

INSERT INTO tblListToDo VALUES
(3,'2024-06-12 16:00:00','KKN');
COMMIT;

SELECT * FROM tblListToDo;


-- RollBack;(kembali ke posisi tertentu)

START TRANSACTION;
INSERT INTO tblListToDo VALUES
(4,'2024-06-13 12:00:00','Anime Rapat');

INSERT INTO tblListToDo VALUES
(5,'2024-06-13 18:00:00','PADUS');
SAVEPOINT svp130624;

INSERT INTO tblListToDo VALUES
(6,'2024-06-14 10:00:00','Rapat Part2');

INSERT INTO tblListToDo VALUES
(7,'2024-06-14 12:00:00','ISOMA');
ROLLBACK TO SAVEPOINT svp130624;

SELECT * FROM tblListToDo;