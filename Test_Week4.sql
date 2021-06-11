CREATE DATABASE NegozioDischi

CREATE TABLE Band (
ID INT IDENTITY (1,1) NOT NULL,
Nome VARCHAR(30) NOT NULL,
NumeroComponenti INT NOT NULL,
PRIMARY KEY (ID),
UNIQUE (Nome),
CHECK (NumeroComponenti > 0)
)

CREATE TABLE Album(
ID INT IDENTITY (1,1) NOT NULL,
Titolo VARCHAR(30) NOT NULL,
AnnoNascita INT NOT NULL,
CasaDiscografica VARCHAR(30) NOT NULL,
Genere VARCHAR(30) NOT NULL,
SupportoDistribuzione VARCHAR(30) NOT NULL,
BandID INT NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY (BandID) REFERENCES Band(ID),
UNIQUE(Titolo, AnnoNascita, CasaDiscografica, Genere, SupportoDistribuzione),
CHECK (Genere IN ('Classico', 'Jazz', 'Pop', 'Rock', 'Metal')),
CHECK(SupportoDistribuzione IN ('CD', 'Vinile', 'Streaming'))
)

CREATE TABLE Brano(
ID INT IDENTITY (1,1) NOT NULL,
Titolo VARCHAR (30) NOT NULL,
Durata INT NOT NULL,
PRIMARY KEY(ID),
CHECK(Durata > 0)
)

CREATE TABLE BranoBand (
BranoID INT NOT NULL,
BandID INT NOT NULL,
FOREIGN KEY (BranoID) REFERENCES Brano(ID),
FOREIGN KEY (BandID) REFERENCES Band(ID)
)

CREATE TABLE AlbumBrano(
AlbumID INT NOT NULL,
BranoID INT NOT NULL,
FOREIGN KEY (AlbumID) REFERENCES Album(ID),
FOREIGN KEY (BranoID) REFERENCES Brano(ID)
)


INSERT INTO Band VALUES ('883', '2')
INSERT INTO Band VALUES ('Maneskin', '4')
INSERT INTO Band VALUES ('The Giornalisti', '2')
INSERT INTO Band VALUES ('John Cover', '3')

SELECT * FROM Band

INSERT INTO Album VALUES ('Primo', '2013', 'Sugar', 'Pop', 'Vinile', 1)
INSERT INTO Album VALUES ('Secondo', '2014', 'Sony', 'Jazz', 'CD', 1)
INSERT INTO Album VALUES ('Teatro Ira', '2020', 'Sony', 'Rock', 'Streaming', 2)
INSERT INTO Album VALUES('Sono', '2017', 'Epson', 'Metal', 'CD', 2)
INSERT INTO Album VALUES ('Vita', '2016', 'Sony', 'Pop', 'Vinile', 3)
INSERT INTO Album VALUES('Sarai', '2000', 'You', 'Rock', 'CD', 3)
INSERT INTO Album VALUES ('Cover1', '1900', 'One', 'Classico', 'Vinile', 4)

SELECT * FROM Album

INSERT INTO Brano VALUES ('Come mai', '3')
INSERT INTO Brano VALUES ('Gli anni', '4')
INSERT INTO Brano VALUES ('Zitti e buoni', '4')
INSERT INTO Brano VALUES ('VentAnni', '2')
INSERT INTO Brano VALUES ('Completamente', '5')
INSERT INTO Brano VALUES ('Riccione', '2')
INSERT INTO Brano VALUES ('Imagine', '3')

SELECT * FROM Brano

INSERT INTO BranoBand VALUES(1,1)
INSERT INTO BranoBand VALUES (2,1)
INSERT INTO BranoBand VALUES (3,2)
INSERT INTO BranoBand VALUES (4,2)
INSERT INTO BranoBand VALUES (5,3)
INSERT INTO BranoBand VALUES (6,3)
INSERT INTO BranoBand VALUES (7,4)

INSERT INTO AlbumBrano VALUES (1,1)
INSERT INTO AlbumBrano VALUES (2,2)
INSERT INTO AlbumBrano VALUES (3,3)
INSERT INTO AlbumBrano VALUES (4,4)
INSERT INTO AlbumBrano VALUES (5,5)
INSERT INTO AlbumBrano VALUES (6,6)
INSERT INTO AlbumBrano VALUES (7,7)

SELECT * FROM BranoBand
SELECT * FROM AlbumBrano

--Scrivere una query che restituisca i titoli degli album degli “883”

SELECT Album.Titolo
FROM Band 
INNER JOIN Album
ON BandID = Band.ID
WHERE Band.Nome = '883'

--Selezionare tutti gli album editi dalla casa editrice nell’anno specificato

SELECT a.Titolo
FROM Album a
WHERE a.CasaDiscografica = 'Sony' AND a.AnnoNascita = '2020'

--Scrivere una query che restituisca tutti i titoli delle canzoni dei “Maneskin” appartenenti ad album pubblicati prima del 2019
SELECT br.Titolo
FROM Album a
JOIN Band b
ON a.BandID = b.ID
JOIN Brano br
ON br.ID = b.ID
WHERE b.Nome = 'Maneskin' AND (a.AnnoNascita < '2019')


--Individuare tutti gli album in cui è contenuta la canzone “Imagine”
SELECT Album.Titolo
FROM Album 
JOIN AlbumBrano
ON Album.ID = AlbumID
JOIN Brano
ON BranoID = Brano.ID
WHERE Brano.Titolo = 'Imagine'

-- Restituire il numero totale di canzoni eseguite dalla band “The Giornalisti”
SELECT Band.Nome, COUNT(*) AS 'Totale canzoni'
FROM Band
JOIN Album
ON BandID = Band.ID
JOIN AlbumBrano
ON AlbumID = Album.ID
JOIN Brano
ON BranoID = Brano.ID
WHERE Band.Nome = 'The Giornalisti'
GROUP by Band.Nome

--Contare per ogni album, la somma dei minuti dei brani contenuti
SELECT SUM (Brano.Durata) AS 'Durata', Album.Titolo, COUNT (*) AS 'Somma Minuti'
FROM Album
JOIN AlbumBrano
ON Album.ID = AlbumID
JOIN Brano
ON Brano.ID = BranoID
GROUP BY Brano.Durata, Album.Titolo --da completare/rivedere tutto 

--Creare una view che mostri i dati completi dell’album, dell’artista e dei brani contenuti in essa
SELECT CONCAT (a.Titolo, ' ', a.AnnoNascita, ' ', a.CasaDiscografica, ' ', a.Genere, ' ', a.SupportoDistribuzione, ' ', Band.Nome, ' ',
Band.NumeroComponenti, ' ', Brano.Durata, ' ', Brano.Titolo, ' ') AS 'Dati completi'
FROM 

--Scrivere una funzione utente che calcoli per ogni genere musicale quanti album sono inseriti in catalogo;


