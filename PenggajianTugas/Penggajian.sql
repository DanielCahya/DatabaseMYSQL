    drop database if exists dbPenggajian;
    create database dbPenggajian;
    use dbPenggajian;
    create table tblBuruh
    (
    id int primary key,
    nama varchar(100)
    );
    insert into tblBuruh values
    (1, 'Harno'),
    (2, 'Lena'),
    (3, 'Wartoyo'),
    (4, 'Azis'),
    (5, 'Hendro');
    create table tblPresensi
    (
    id int,
    tanggal date,
    jammasuk time, 
    jamkeluar time,
    gajiharian double,
    lemburmasuk time,
    lemburkeluar time,
    lemburperjam double,
    foreign key(id) references tblBuruh(id)
    );

insert into tblPresensi values
(1, '2022-11-01', '07:30:00', '17:00:00', 80000 , '17:30', '20:10', 20000),
(1, '2022-11-02', '07:28:00', '17:30:00', 75000 , '17:40', '21:13', 20000),
(2, '2022-11-01', '07:40:00', '17:45:00', 82000 , '17:55', '23:50', 20000),
(2, '2022-11-02', '07:50:00', '17:15:00', 77000 , '17:15', '02:10', 20000),
(4, '2022-11-01', '07:35:00', '17:25:00', 67500 , '17:20', '01:15', 20000),
(4, '2022-11-02', '07:38:00', '17:55:00', 55000 , '17:25', '20:40', 20000),
(5, '2022-11-01', '07:39:00', '17:56:00', 76000 , '17:33', '21:17', 20000),
(5, '2022-11-02', '07:41:00', '17:58:00', 78000 , '17:56', '23:40', 20000),
(5, '2022-11-03', '07:50:00', '17:34:00', 65000 , '17:05', '01:50', 20000),
(5, '2022-11-04', '07:36:00', '17:35:00', 77500 , '17:15', '03:10', 20000);

-- SOAL 1;
SELECT * 
FROM tblBuruh;

SELECT * 
FROM tblPresensi;

-- SOAL 2;
SELECT tblBuruh.id,
tblBuruh.nama,
tblPresensi.jammasuk,
tblPresensi.jamkeluar,
IF((tblPresensi.jammasuk) <= '07:30:00', '07:30:00',(tblPresensi.jammasuk)) AS MASUK_VALID,
IF((tblPresensi.jamkeluar) >= '17:30:00', '17:30:00',(tblPresensi.jamkeluar)) AS KELUAR_VALID
FROM tblBuruh INNER JOIN tblPresensi ON (tblBuruh.id = tblPresensi.id);

--SOAL 3;
SELECT tblBuruh.id,
tblBuruh.nama,
tblPresensi.jammasuk,
tblPresensi.jamkeluar,
IF((tblPresensi.jammasuk) <= '07:30:00', '07:30:00',(tblPresensi.jammasuk)) AS MASUK_VALID,
IF((tblPresensi.jamkeluar) >= '17:30:00', '17:30:00',(tblPresensi.jamkeluar)) AS KELUAR_VALID,
tblPresensi.gajiharian,
CAST(TIME_TO_SEC(TIMEDIFF(IF((tblPresensi.jamkeluar) >= '17:30:00', '17:30:00',(tblPresensi.jamkeluar)), IF((tblPresensi.jammasuk) <= '07:30:00', '07:30:00',(tblPresensi.jammasuk)))) / 60 AS UNSIGNED) AS KERJA,
CAST((tblPresensi.gajiharian * TIME_TO_SEC(TIMEDIFF(IF((tblPresensi.jamkeluar) >= '17:30:00', '17:30:00',(tblPresensi.jamkeluar)), IF((tblPresensi.jammasuk) <= '07:30:00', '07:30:00',(tblPresensi.jammasuk)))) / 60)/600 AS UNSIGNED) AS GAJI
FROM tblBuruh INNER JOIN tblPresensi ON (tblBuruh.id = tblPresensi.id);


-- SOAL 4;
SELECT tblBuruh.id,
tblBuruh.nama,
tblPresensi.lemburmasuk,
IF((tblPresensi.lemburmasuk) <='17:30:00', '17:30:00',(tblPresensi.lemburmasuk)) AS LEMBURMASUKVALID,
tblPresensi.lemburkeluar AS LEMBURKELUARVALID,
tblPresensi.lemburperjam
FROM tblBuruh INNER JOIN tblPresensi ON (tblBuruh.id = tblPresensi.id);

-- SOAL 5;
SELECT 
    tblBuruh.id,
    tblBuruh.nama,
    tblPresensi.lemburmasuk,
    IF(tblPresensi.lemburmasuk <= '17:30:00', '17:30:00', tblPresensi.lemburmasuk) AS LEMBURMASUKVALID,
    tblPresensi.lemburkeluar AS LEMBURKELUARVALID,
    CASE
        WHEN tblPresensi.lemburkeluar >= IF(tblPresensi.lemburmasuk <= '17:30:00', '17:30:00', tblPresensi.lemburmasuk) THEN 
            TIMESTAMPDIFF(MINUTE, 
                          CONCAT(tblPresensi.tanggal, ' ', IF(tblPresensi.lemburmasuk <= '17:30:00', '17:30:00', tblPresensi.lemburmasuk)),
                          CONCAT(tblPresensi.tanggal, ' ', tblPresensi.lemburkeluar)) 
        ELSE 
            TIMESTAMPDIFF(MINUTE, 
                          CONCAT(tblPresensi.tanggal, ' ', IF(tblPresensi.lemburmasuk <= '17:30:00', '17:30:00', tblPresensi.lemburmasuk)), 
                          CONCAT(tblPresensi.tanggal + INTERVAL 1 DAY, ' ', tblPresensi.lemburkeluar))
    END * (tblPresensi.lemburperjam) / 60 AS UANGLEMBUR
FROM 
    tblBuruh 
INNER JOIN 
    tblPresensi ON tblBuruh.id = tblPresensi.id;



-- SOAL 6
SELECT 
    tblBuruh.id,
    tblBuruh.nama
FROM 
    tblBuruh 
INNER JOIN 
    tblPresensi ON tblBuruh.id = tblPresensi.id;