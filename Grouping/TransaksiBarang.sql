DROP DATABASE IF EXISTS dbGrouping;
CREATE DATABASE dbGrouping;
USE dbGrouping;

CREATE TABLE tblTransaksi(
    notransaksi VARCHAR(2),
    tanggaltransaksi DATE

);

INSERT INTO tblTransaksi
VALUES('T1','2024-4-1'),
('T2','2024-4-1'),
('T3','2023-12-10'),
('T4','2023-10-10'),
('T5','2022-11-5');

CREATE TABLE tblBarang(
    kodebarang VARCHAR(2),
    namabarang VARCHAR(30)
);

INSERT INTO tblBarang
VALUES ('B1','BARANG 1'),
('B2','BARANG 2'),
('B3','BARANG 3'),
('B4','BARANG 4'),
('B5','BARANG 5'),
('B6','BARANG 6'),
('B7','BARANG 7');

CREATE TABLE tblDetilTransaksi(
    notransaksi VARCHAR(2),
    kodebarang VARCHAR(2),
    jumlah DOUBLE,
    harga VARCHAR(5)
);

INSERT INTO tblDetilTransaksi
VALUES('T1','B1',1,'5000'),
('T1','B3',2,'7000'),
('T1','B5',3,'9000'),
('T2','B7',5,'6000'),
('T2','B2',1,'7500'),
('T3','B4',4,'8000'),
('T3','B6',7,'11000'),
('T3','B1',8,'5000'),
('T4','B2',9,'7500'),
('T5','B4',1,'8000');

SELECT * FROM tblTransaksi;
SELECT * FROM tblBarang;
SELECT * FROM tblDetilTransaksi;

SELECT notransaksi,
COUNT(notransaksi) AS JUMLAH
FROM tblDetilTransaksi
GROUP BY notransaksi;

SELECT notransaksi AS NO_TRANSAKSI,
SUM(jumlah) AS JUMLAHBARANG,
SUM(jumlah*harga) AS TOTAL_HARGA
FROM tblDetilTransaksi
GROUP BY notransaksi;

SELECT tblBarang.kodebarang,
tblBarang.namabarang,
tblDetilTransaksi.jumlah AS JUMLAH
FROM tblBarang CROSS JOIN tblDetilTransaksi USING(kodebarang)
GROUP BY tblBarang.kodebarang;

SELECT tblTransaksi.tanggaltransaksi,
tblDetilTransaksi.jumlah,
SUM(tblDetilTransaksi.jumlah),
SUM(tblDetilTransaksi.JUMLAH*harga)
FROM tblDetilTransaksi INNER JOIN tblTransaksi ON (tblTransaksi.kodebarang = tblDetilTransaksi.kodebarang)
GROUP BY tblTransaksi.tanggaltransaksi;

-- SELECT tblBarang.kodebarang,
-- tblBarang.namabarang,
-- tblTransaksi.tanggaltransaksi
-- FROM

SELECT notransaksi AS NO_TRANSAKSI,
SUM(jumlah) AS JUMLAHBARANG,
SUM(jumlah*harga) AS TOTAL_HARGA
FROM tblDetilTransaksi
GROUP BY notransaksi
HAVING SUM(jumlah) >= 7;

SELECT notransaksi,
COUNT(notransaksi) AS JUMLAH
FROM tblDetilTransaksi
GROUP BY notransaksi
HAVING COUNT(notransaksi) >=2;
-- KODE BARANG DAN TANGGAL