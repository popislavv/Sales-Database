Create table Kategorijaa(
    id_kategorije int,
    naziv_kategorije nvarchar(50)
);

Alter table Dobavljač
Add datum_rodjenja date


Drop table Porez


Insert into Dobavljač (prezime, prezime)
Values (Marko, Petrović),
       (Jovan, Stanić),
	 (Siniša, Marić);

Delete from Dobavljač
where id_dobavljaca = 2;



SELECT REPLACE('Jovan', 'J', 'Z')
FROM Dobavljač 
WHERE id_dobavljaca=2

 Select replace ('Zovan',  'v', 'r')
FROM Dobavljač 
WHERE id_dobavljaca=2



SELECT MIN (kolicina_u_skladistu)

AS Najprodavaniji

FROM Artikal



SELECT ime, DATENAME(YEAR, datum_rođenja)

AS Godina_rođenja

FROM Kupac



SELECT naziv_artikla, kolicina_u_skladistu, 
CASE

WHEN kolicina_u_skladistu> 0 THEN 'Ima na stanju' 
WHEN kolicina_u_skladistu= 0 THEN 'Nema na stanju'

END

FROM Artikal;





USE Prodaja_Nikola

GO

CREATE FUNCTION FormirajDatum
(
@datum AS DATETIME
)
RETURNS VARCHAR(MAX)
AS
BEGIN
   RETURN
    DATENAME (DW, @datum) + ','
    + DATENAME (DAY, @datum)+ ' '
	+DATENAME (MONTH, @datum)+ ','
    +DATENAME (YEAR, @datum)
END






USE Prodaja_Nikola

GO

CREATE FUNCTION Punoljetan ( 
    @datum date
)
RETURNS nvarchar(MAX) 
AS
BEGIN

DECLARE @return_value nvarchar (MAX);
SET @return_value = 'nn';

IF DATEDIFF (YEAR, @datum, GETDATE()) <18 SET @return_value = 'Nije';

IF DATEDIFF (YEAR, @datum, GETDATE()) >=18 SET @return_value = 'Jeste';

RETURN @return_value

END;

SELECT ime, prezime, dbo.Punoljetan(datum_rođenja) AS Punoljetan
FROM Kupac



CREATE INDEX idx_PrezimeIme
ON Dobavljač (prezime, ime);




SELECT naziv_artikla, cijena, količina
FROM Artikal a
LEFT JOIN Izlaz
ON Izlaz.id_artikla = a.id_artikla;

SELECT naziv_artikla, cijena, količina, id_kategorije
FROM Artikal a
FULL OUTER JOIN Izlaz i
ON a.id_artikla = i.id_artikla
ORDER BY a.naziv_artikla;


CREATE VIEW Phone_Prodavnica AS
SELECT naziv_artikla, kolicina_u_skladistu
FROM Artikal
WHERE id_nabavnog_mjesta=



CREATE VIEW Lazar_kupovina AS
SELECT ime, naziv_nabavnog_mjesta FROM Dobavljač, Nabavno_mjesto 
WHERE nabavno_mjesto.id_dobavljača=1 AND Dobavljač.id_dobavljaca=Nabavno_mjesto.id_dobavljača;


CREATE PROCEDURE Procedura1
AS
SELECT naziv_artikla, cijena, količina
FROM Artikal a
INNER JOIN Izlaz
ON Izlaz.id_artikla = a.id_artikla
GO

EXEC Procedura1

CREATE PROCEDURE Procedura2
AS
SELECT naziv_artikla, cijena, količina, id_kategorije
FROM Artikal a
FULL OUTER JOIN Izlaz i
ON a.id_artikla = i.id_artikla
ORDER BY a.naziv_artikla
GO

EXEC Procedura2

CREATE TRIGGER Triger1
  ON Izlaz 
  AFTER INSERT
AS 
BEGIN
declare @id_stavke int
set @id_stavke= (select top 1 id_izlaza from Izlaz order by id_izlaza desc)
UPDATE Izlaz set  datum_izlaza = getdate ()
where id_izlaza = id_izlaza
END
GO






CREATE TRIGGER Triger2
  ON Dobavljač
  AFTER INSERT, DELETE,UPDATE
AS 
BEGIN
SET NOCOUNT ON
END
GO