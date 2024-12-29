DROP DATABASE IF EXISTS PusatPsikologi;
CREATE DATABASE PusatPsikologi;
USE PusatPsikologi;

CREATE TABLE tblKlien
(
    kodeklien INT PRIMARY KEY,
    namaklien VARCHAR(50),
    alamat VARCHAR(50),
    nokontak VARCHAR(20),
    email VARCHAR(25)
);

LOAD DATA LOCAL INFILE 'F:\\NoDoubt\\DatabaseProgramming\\Tugas2\\tblKlien.csv'
INTO TABLE tblKlien
FIELDS TERMINATED BY ';'
ENCLOSED BY ''''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * 
FROM tblKlien;

CREATE TABLE tblTarif(
    kodetes INT PRIMARY KEY,
    namates VARCHAR(30),
    tarifdasar DOUBLE
);

LOAD DATA LOCAL INFILE 'F:\\NoDoubt\\DatabaseProgramming\\Tugas2\\tblTarif.csv'
INTO TABLE tblTarif
FIELDS TERMINATED BY ';'
ENCLOSED BY ''''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * 
FROM tblTarif;

CREATE TABLE tblTransaksi(
    notransaksi INT PRIMARY KEY,
    tanggaltransaksi DATETIME,
    kodeklien INT,
    FOREIGN KEY(kodeklien) REFERENCES tblKlien(kodeklien)
);

LOAD DATA LOCAL INFILE 'F:\\NoDoubt\\DatabaseProgramming\\Tugas2\\tblTransaksi.csv'
INTO TABLE tblTransaksi
FIELDS TERMINATED BY ';'
ENCLOSED BY ''''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * 
FROM tblTransaksi;

CREATE TABLE tblDetilInformasi(
    notransaksi INT,
    kodetes INT,
    harga DOUBLE,
    FOREIGN KEY(notransaksi) REFERENCES tblTransaksi(notransaksi),
    FOREIGN KEY(kodetes) REFERENCES tblTarif(kodetes)
);

LOAD DATA LOCAL INFILE 'F:\\NoDoubt\\DatabaseProgramming\\Tugas2\\tblDetilInformasi.csv'
INTO TABLE tblDetilInformasi
FIELDS TERMINATED BY ';'
ENCLOSED BY ''''
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SELECT * 
FROM tblDetilInformasi;