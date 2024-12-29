DROP DATABASE IF EXISTS dbCursor;
CREATE DATABASE dbCursor;
USE dbCursor;

Create Table tblData(
    noid INT PRIMARY KEY ,
    nama VARCHAR(50) NOT NULL,
    alamat VARCHAR(255) NOT NULL
);


/* Surabaya = Seoul
Semarang = Tokyo
Jogja = Berlin
*/

INSERT INTO tblData VALUES 
(1, 'Linda', 'Seoul'),
(2, 'Sakura', 'Tokyo'),
(3, 'Luna', 'Berlin'),
(4, 'Kanata', 'Tokyo'),
(5, 'Hana', 'Seoul'),
(6, 'Darius', 'Tokyo'),
(7, 'Yasuo', 'Seoul'),
(8, 'Yone', 'Tokyo'),
(9, 'Lux', 'Berlin'),
(10, 'Fortune', 'Berlin');

SELECT * FROM tblData;

DELIMITER $$

CREATE PROCEDURE spbacaData()
begin
    declare vjumlahdata int default 0;
    declare vnoid int;
    declare vnama VARCHAR(50);
    declare valamat VARCHAR(255);
    declare i int default 1;
    declare j int default 1;

    declare cData cursor for
        SELECT * FROM tblData;
    SELECT count(*) into vjumlahdata FROM tblData;

    open cData;
    bacadata: while i<= vjumlahdata do
        fetch cData into vnoid,vnama,valamat;
        SELECT vnoid,vnama,valamat;

        set i := i+1;
    end while bacadata;
    close cData;
end;
$$
DELIMITER ;

CALL spbacaData();

Create Table tblAlamat(
    nama VARCHAR(50) NOT NULL,
    alamat VARCHAR(255) NOT NULL
);

DELIMITER $$

CREATE PROCEDURE spbacaAlamat()
BEGIN
    DECLARE valamat VARCHAR(255) DEFAULT '';
    DECLARE vnama VARCHAR(50);
    DECLARE vkota VARCHAR(50);

    DECLARE curAlamat CURSOR FOR
    SELECT 
        alamat AS Kota,
        GROUP_CONCAT(nama) AS Siapa
    FROM 
        tblData
    WHERE alamat IN ('Berlin', 'Tokyo', 'Seoul')
    GROUP BY alamat;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @done = TRUE;

    OPEN curAlamat;

    SET @done = FALSE;
    bacadataAl: LOOP
        FETCH curAlamat INTO vnama, valamat;

        IF @done THEN
            LEAVE bacadataAl;
        END IF;

        SELECT vnama AS nama, valamat AS kota;

    END LOOP bacadataAl;

    CLOSE curAlamat;
END;
$$

DELIMITER ;

CALL spbacaAlamat();