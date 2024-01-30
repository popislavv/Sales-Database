CREATE TABLE Dobavljac (
    id_dobavljaca INT PRIMARY KEY,
    ime VARCHAR(255),
    prezime VARCHAR(255),
    datum_rodjenja DATE
);

CREATE TABLE Kupac (
    id_kupca INT PRIMARY KEY,
    ime VARCHAR(255),
    prezime VARCHAR(255),
    datum_rodjenja DATE
);

CREATE TABLE Kategorija (
    id_kategorije INT PRIMARY KEY,
    naziv_kategorije VARCHAR(255)
);

CREATE TABLE Artikal (
    id_artikla INT PRIMARY KEY,
    id_kategorije INT,
    kolicina_u_skladistu INT,
    naziv_artikla VARCHAR(255),
    FOREIGN KEY (id_kategorije) REFERENCES Kategorija(id_kategorije)
);

CREATE TABLE Porez (
    id_artikla INT PRIMARY KEY,
    porez_artikla DECIMAL(5, 2),
    FOREIGN KEY (id_artikla) REFERENCES Artikal(id_artikla)
);

CREATE TABLE NabavnoMjesto (
    id_nabavnog_mjesta INT PRIMARY KEY,
    id_dobavljaca INT,
    naziv_nabavnog_mjesta VARCHAR(255),
    FOREIGN KEY (id_dobavljaca) REFERENCES Dobavljac(id_dobavljaca)
);

CREATE TABLE Izlaz (
    id_izlaza INT PRIMARY KEY,
    id_nabavnog_mjesta INT,
    kolicina INT,
    datum_izlaza DATE,
    id_artikla INT,
    cijena DECIMAL(10, 2),
    FOREIGN KEY (id_nabavnog_mjesta) REFERENCES NabavnoMjesto(id_nabavnog_mjesta),
    FOREIGN KEY (id_artikla) REFERENCES Artikal(id_artikla)
);

CREATE TABLE Transakcije (
    id_kupca INT,
    id_nabavnog_mjesta INT,
    id_izlaza INT,
    PRIMARY KEY (id_kupca, id_nabavnog_mjesta, id_izlaza),
    FOREIGN KEY (id_kupca) REFERENCES Kupac(id_kupca),
    FOREIGN KEY (id_nabavnog_mjesta) REFERENCES NabavnoMjesto(id_nabavnog_mjesta),
    FOREIGN KEY (id_izlaza) REFERENCES Izlaz(id_izlaza)
);
