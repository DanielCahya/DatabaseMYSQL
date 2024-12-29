DROP DATABASE IF EXISTS Pesan;
CREATE DATABASE Pesan;
USE Pesan;

CREATE TABLE tblBarang (
    kodebarang INTEGER PRIMARY KEY,
    namabarang VARCHAR(100) NOT NULL,
    stok INTEGER DEFAULT 0,
    foto VARCHAR(255),
    INDEX index_namabarang (namabarang)
);

CREATE TABLE tblCustomer (
    idcustomer INTEGER PRIMARY KEY,
    namacustomer VARCHAR(100) NOT NULL,
    nohp VARCHAR(20),
    email VARCHAR(255),
    alamatkirim VARCHAR(255) NOT NULL
);

CREATE TABLE tblTransaksi (
    kodebarang INTEGER,
    idcustomer INTEGER,
    jumlahbeli INT,
    hargabeli DOUBLE,
    FOREIGN KEY (kodebarang) REFERENCES tblBarang(kodebarang),
    FOREIGN KEY (idcustomer) REFERENCES tblCustomer(idcustomer)
);

ALTER TABLE tblTransaksi
ADD diskon DECIMAL(5,2) DEFAULT 0;

SHOW TABLES;
DESC tblBarang;
DESC tblCustomer;
DESC tblTransaksi;

INSERT INTO tblBarang (kodebarang, namabarang, stok, foto) VALUES
(1, 'Sepatu', 100, 'sepatu.jpg'),
(2, 'Hoodie', 150, 'hoodie.jpg'),
(3, 'Shirt', 80, 'shirt.jpg');
SELECT *
FROM tblBarang;

INSERT INTO tblCustomer (idcustomer, namacustomer, nohp, email, alamatkirim) VALUES
(1, 'Daniel', '081', 'Daniel@example.com', 'Jl. Jawa No. 1'),
(2, 'Hajime', '082', 'Hajime@example.com', 'Jl. Sunda No. 2');
SELECT *
FROM tblCustomer;

INSERT INTO tblTransaksi (kodebarang, idcustomer, jumlahbeli, hargabeli, diskon) VALUES
(1, 1, 5, 50000, 0),
(2, 2, 3, 20000, 0.1),
(3, 1, 2, 75000, 0.25),
(3, 2, 2, 75000, 0.40);
SELECT *
FROM tblTransaksi;
