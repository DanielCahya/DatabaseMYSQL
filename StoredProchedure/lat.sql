/* 
STORED PROCEDURE
- bahasa prosedural
- ada variabel dan tipe DATABASE
- Cek kondisi IF THEN atau CASE WHEN
- Perulangan / LOOPINIG
- CURSOR
- parameter
*/

DROP DATABASE IF EXISTS dbSP;
CREATE DATABASE dbSP;
USE dbSP;

CREATE TABLE tblSP
(
nourut INT PRIMARY KEY,
keterangan VARCHAR(100) NOT NULL
);

/*
karena di dalam SP banyak perintah yang dapat dijalankan secara berurutan, maka delimiter ; harus dimatikan terlebih dahulu, ganti dengan delimiter lain

CREATE PROCEDURE nama(parameter)
BEGIN
	DECLARE variabel tipedata
	tulis perintah untuk procedure nya
END
*/
DROP PROCEDURE IF EXISTS spHello;

DELIMITER  $$

CREATE PROCEDURE spHello(pNama VARCHAR(100))
BEGIN
	SELECT CONCAT('Hello World, this is ', pNama);
END;

$$
DELIMITER ;

CALL spHello('Marlon');

/*source C:\Users\hero\Documents\Database Programming\dbSP.sql*/


/*declare untuk deklarasi variabel
set untuk memasukan nilai ke variabel*/
DROP PROCEDURE IF EXISTS spMenyapa;
DELIMITER $$

CREATE PROCEDURE spMenyapa(pNama VARCHAR(100))
BEGIN
	DECLARE vSapa VARCHAR(255);
	SET vSapa:= 'Hallo, apakabar ';
	
	SELECT CONCAT(vSapa, pNama);
END;
$$
DELIMITER ;

CALL spMenyapa('Linda');





/*menggunakan IF THEN untuk Cek
apakah sebuah bilangan ganjil atau genap*/
DROP PROCEDURE IF EXISTS spCek;

DELIMITER $$

CREATE PROCEDURE spCek(pAngka INT)
BEGIN
	DECLARE vPesan VARCHAR(30);
	IF mod(pAngka, 2) = 0 THEN
		SET vPesan := 'Bilangan Genap';
	ELSE
		SET vPesan := 'Bilangan Ganjil';
	END IF;
	
	SELECT CONCAT(pAngka, ' adalah ', vPesan) AS HASIL;
END;

$$
DELIMITER ;

CALL spCek(16);
CALL spCek(13);
CALL spCek(100);
CALL spCek(39);


/*cek apakah sebuah bilang >0, <0 atau =0*/
DROP PROCEDURE IF EXISTS spCekNol;
DELIMITER $$
CREATE PROCEDURE spCekNol(pAngka INT)
BEGIN
	DECLARE vPesan VARCHAR(100);
	
	IF pAngka = 0 THEN
		SET vPesan := 'Input angka sama dengan 0';
	ELSEIF (pAngka > 0) THEN
		SET vPesan := 'Input angka lebih besar dari 0';
	ELSE
		SET vPesan := 'Input angka lebih kecil dari 0';
	END IF;
	
	SELECT vPesan AS Pesan;
END;
$$
DELIMITER ;

CALL spCekNol(4);
CALL spCekNol(-5);
CALL spCekNol(0);



/*
parameter untuk sp bisa banyak
cek selain if bisa menggunakan case when

Contoh : melakukan operasi matematika untuk 2 bilangan
*/

DROP PROCEDURE IF EXISTS spMatematika;
DELIMITER $$
CREATE PROCEDURE spMatematika
(pA INT, pB INT, pOperasi VARCHAR(20))
BEGIN
	DECLARE vHasil INT;
	DECLARE vPesan VARCHAR(100);
	
	CASE 
		WHEN pOperasi = 'JUMLAH' THEN
			SET vHasil:= pA+pB;
			SET vPesan:= CONCAT(pA, '+', pB, '=', vHasil);
		WHEN pOperasi = 'KURANG' THEN
			SET vHasil:= pA-pB;
			SET vPesan:= CONCAT(pA, '-', pB, '=', vHasil);
		WHEN pOperasi = 'KALI' THEN
			SET vHasil:= pA*pB;
			SET vPesan:= CONCAT(pA, '*', pB, '=', vHasil);
		WHEN pOperasi = 'BAGI' THEN
			SET vHasil:= pA/pB;
			SET vPesan:= CONCAT(pA, '/', pB, '=', vHasil);
	END CASE;
	
	SELECT vPesan AS HASIL;
END; 
$$
DELIMITER ;

CALL spMatematika(9, 5, 'JUMLAH');
CALL spMatematika(75, 25, 'KURANG');
CALL spMatematika(10, 10, 'KALI');
CALL spMatematika(1000, 10, 'BAGI');

/*looping atau Perulangan
1. menggunakan LOOP - END LOOP
2. menggunakan WHILE - END WHILE
3. menggunakan REPEAT UNTIL 

biasanya menggunakan per LABEL an untuk Perulangan
BREAK (java/C/php) = LEAVE (SQL)

lakukan perulangan untuk cetak angka dari a sd sampai b
*/

DROP PROCEDURE IF EXISTS spCetakAngka;
DELIMITER $$
CREATE PROCEDURE spCetakAngka(pDari INT, pSampai INT)
BEGIN
	DECLARE kounter INT;
	
	SET kounter := pDari;
	carasatu: LOOP
		SELECT kounter AS LOOPENDLOOP;
		SET kounter := kounter+1;
		
		IF kounter > pSampai THEN
			LEAVE carasatu;
		END IF;
	END LOOP carasatu;
	
	SET kounter := pDari;
	caradua: WHILE kounter <= pSampai DO 		
		SELECT kounter AS WHILENEDWHILE;
		SET kounter = kounter + 1;
	END WHILE caradua;
	
	SET kounter := pDari;
	REPEAT
			SELECT kounter AS REPEATUNTIL;
			SET kounter := kounter + 1;
		UNTIL kounter > pSampai	
	END REPEAT;
END ;
$$
DELIMITER ;

CALL spCetakAngka(10, 30);