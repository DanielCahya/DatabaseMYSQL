DROP DATABASE IF EXISTS dbNo3;
CREATE DATABASE dbNo3;
USE dbNo3;

DELIMITER $$

CREATE FUNCTION GETsatuan(angka INT) RETURNS VARCHAR(20)
BEGIN
  DECLARE hasil VARCHAR(20);

  CASE angka
    WHEN 1 THEN SET hasil = 'SATU';
    WHEN 2 THEN SET hasil = 'DUA';
    WHEN 3 THEN SET hasil = 'TIGA';
    WHEN 4 THEN SET hasil = 'EMPAT';
    WHEN 5 THEN SET hasil = 'LIMA';
    WHEN 6 THEN SET hasil = 'ENAM';
    WHEN 7 THEN SET hasil = 'TUJUH';
    WHEN 8 THEN SET hasil = 'DELAPAN';
    WHEN 9 THEN SET hasil = 'SEMBILAN';
    ELSE SET hasil = '';
  END CASE;

  RETURN hasil;
END; $$

CREATE FUNCTION GETPULUHAN(angka INT) RETURNS VARCHAR(20)
BEGIN
  DECLARE hasil VARCHAR(20);

  CASE angka
    WHEN 20 THEN SET hasil = 'DUA PULUH';
    WHEN 30 THEN SET hasil = 'TIGA PULUH';
    WHEN 40 THEN SET hasil = 'EMPAT PULUH';
    WHEN 50 THEN SET hasil = 'LIMA PULUH';
    WHEN 60 THEN SET hasil = 'ENAM PULUH';
    WHEN 70 THEN SET hasil = 'TUJUH PULUH';
    WHEN 80 THEN SET hasil = 'DELAPAN PULUH';
    WHEN 90 THEN SET hasil = 'SEMBILAN PULUH';
    ELSE
      SET hasil = CONCAT(GETsatuan(angka DIV 10), ' PULUH ');
      IF angka MOD 10 > 0 THEN
        SET hasil = CONCAT(hasil, GETsatuan(angka MOD 10));
      END IF;
  END CASE;

  RETURN hasil;
END; $$

CREATE FUNCTION GETkata(angka INT, satuan VARCHAR(20)) RETURNS VARCHAR(20)
BEGIN
  DECLARE hasil VARCHAR(20);

  IF angka > 1 THEN
    SET hasil = CONCAT(GETsatuan(angka), ' ', satuan);
  ELSE
    SET hasil = CONCAT('SATU ', satuan);
  END IF;

  RETURN hasil;
END;

CREATE FUNCTION AngkaToKata(angka INT) RETURNS VARCHAR(255)
BEGIN
  DECLARE hasil VARCHAR(255);
  DECLARE satuan VARCHAR(20);
  DECLARE puluhan VARCHAR(20);
  DECLARE ratusan VARCHAR(20);
  DECLARE ribuan VARCHAR(20);
  DECLARE jutaan VARCHAR(20);
  DECLARE milyar VARCHAR(20);

  SET hasil = '';

  IF angka >= 1000000000 THEN
    SET milyar = GETkata(angka DIV 1000000000, 'MILYAR');
    SET angka = angka MOD 1000000000;
  ELSE
    SET milyar = '';
  END IF;

  IF angka >= 1000000 THEN
    SET jutaan = GETkata(angka DIV 1000000, 'JUTA');
    SET angka = angka MOD 1000000;
  ELSE
    SET jutaan = '';
  END IF;

  IF angka >= 1000 THEN
    SET ribuan = GETkata(angka DIV 1000, 'RIBU');
    SET angka = angka MOD 1000;
  ELSE
    SET ribuan = '';
  END IF;

  IF angka >= 100 THEN
    SET ratusan = GETkata(angka DIV 100, 'RATUS');
    SET angka = angka MOD 100;
  ELSE
    SET ratusan = '';
  END IF;

  IF angka >= 20 THEN
    SET puluhan = GETPULUHAN(angka);
    SET angka = angka MOD 10;
  ELSE
    SET puluhan = '';
  END IF;

  IF angka > 0 THEN
    SET satuan = GETsatuan(angka);
  ELSE
    SET satuan = '';
  END IF;

  SET hasil = CONCAT_WS(' ', milyar, jutaan, ribuan, ratusan, puluhan, satuan);

  RETURN TRIM(hasil);
END; $$



$$
DELIMITER ;

SELECT AngkaToKata(59980000);