# SQL Script for Database `dbFungsi`

This README describes the SQL script for creating, populating, and querying a database named `dbFungsi`. The script demonstrates various SQL operations including table creation, data insertion, and the use of functions for string manipulation, aggregate calculations, date operations, and conditional statements.

## Database Initialization

1. **Drop and Create Database**
   - Drops the database `dbFungsi` if it exists.
   - Creates a new database named `dbFungsi` and sets it as the active database.

   ```sql
   DROP DATABASE IF EXISTS dbFungsi;
   CREATE DATABASE dbFungsi;
   USE dbFungsi;
   ```

2. **Create Table**
   - Creates a table `tblData` with the following columns:
     - `nama`: Stores names as a VARCHAR(20).
     - `tanggallahir`: Stores birthdates as a DATE.
     - `nilaites`: Stores scores as an INT.

   ```sql
   CREATE TABLE tblData(
       nama VARCHAR(20),
       tanggallahir DATE,
       nilaites INT
   );
   ```

3. **Insert Data**
   - Inserts sample data into the `tblData` table.

   ```sql
   INSERT INTO tblData
   VALUES
       ('NATALIA SUWARNO','2001-03-01',80),
       ('DEWI WULANDARI','2002-05-05',60),
       ('MARIA ADRIYANI','2002-04-07',55),
       ('MARKUS HENDRAWAN','2000-09-09',79),
       ('ROBI WILLIAM','1999-03-11',60),
       ('VINCENT HERLAMBANG','1998-04-18',95),
       ('MICHAEL WIRYA','2001-09-03',10);
   ```

## Queries and Operations

### String Operations

1. **Manipulating Strings**
   - Converts names to lowercase and uppercase.
   - Calculates the length of each name.
   - Concatenates strings to form a single sentence.
   - Searches for a substring `"AN"` in the name.
   - Extracts a substring starting at position 3 for 5 characters.

   ```sql
   SELECT nama,
       LOWER(nama) AS huruf_kecil,
       UPPER(nama) AS huruf_besar,
       LENGTH(nama) AS Panjang_karakter,
       CONCAT('nama = ',nama,' Nilai = ',nilaites) AS GABUNG,
       LOCATE ('AN',nama,1) AS CARI_AN,
       SUBSTR(nama,3,5) AS AMBIL
   FROM tblData;
   ```

### Aggregate Functions

2. **Statistical Calculations on Scores**
   - Finds the maximum, minimum, average, count, sum, and standard deviation of scores.

   ```sql
   SELECT nilaites,
       MAX(nilaites) AS NILAI_MAX,
       MIN(nilaites) AS MINIMAL,
       AVG(nilaites) AS RATA_RATA,
       COUNT(nilaites) AS JUMLAH,
       SUM(nilaites) AS TOTAL_NILAI,
       STD(nilaites) AS STANDAR
   FROM tblData;
   ```

### Date Operations

3. **Date Calculations**
   - Extracts the year, month, and day from birthdates.
   - Displays the current date and time.
   - Calculates the number of days between birthdates and the current date.

   ```sql
   SELECT tanggallahir,
       NOW() AS SAAT_INI,
       YEAR(tanggallahir) AS TAHUN_LAHIR,
       MONTH(tanggallahir) AS BULAN_LAHIR,
       DAY(tanggallahir) AS HARI,
       DAYNAME(tanggallahir) AS HARI,
       CURTIME() AS JAM_SAAT_INI,
       CURDATE() AS TANGGAL_SAAT_INI,
       DATEDIFF(NOW(),tanggallahir) AS JARAK
   FROM tblData;
   ```

### Conditional Statements

4. **Conditional Statements Using `IF`**
   - Determines if a person was born before or after the year 2000.

   ```sql
   SELECT nama, tanggallahir,
       YEAR(tanggallahir) AS TAHUN_LAHIR,
       IF(YEAR(tanggallahir) >= 2000, 'LAHIR SETELAH TAHUN 2000', 'LAHIR SEBELUM TAHUN 2000') AS KETERANGAN
   FROM tblData;
   ```

5. **Conditional Statements on Scores**
   - Checks if a score is above 70 and labels it as `LULUS` or `TIDAK LULUS`.

   ```sql
   SELECT nama, nilaites,
       IF(nilaites > 70, 'LULUS', 'TIDAK LULUS') AS STATUS
   FROM tblData;
   ```

6. **Case Statements for Grades**
   - Converts scores into letter grades based on predefined ranges.

   ```sql
   SELECT nama, nilaites,
       CASE
           WHEN nilaites >= 80 THEN 'A'
           WHEN nilaites BETWEEN 60 AND 79 THEN 'B'
           WHEN nilaites BETWEEN 40 AND 59 THEN 'C'
           WHEN nilaites BETWEEN 20 AND 39 THEN 'D'
           ELSE 'BODO'
       END AS NILAI_HURUF
   FROM tblData;
   ```

## Summary

This script demonstrates:
- String manipulations with `LOWER`, `UPPER`, `LENGTH`, `CONCAT`, `LOCATE`, and `SUBSTR`.
- Statistical operations with `MAX`, `MIN`, `AVG`, `COUNT`, `SUM`, and `STD`.
- Date operations using `NOW`, `YEAR`, `MONTH`, `DAY`, `DAYNAME`, and `DATEDIFF`.
- Conditional logic with `IF` and `CASE`.

These operations can be extended or modified to suit additional requirements.

