--Krystian £ukasiak
--Baza danych dla gabinetu stomatologicznego

SET DATEFORMAT dmy;
GO

CREATE TABLE dane(
	id_dane INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	imie varchar(45) NOT NULL,
	nazwisko varchar(45) NOT NULL,
	ulica varchar(90),
	nr_domu varchar(4) NOT NULL,
	nr_mieszkania varchar(4),
	kod_pocztowy varchar(6) NOT NULL,
	miejscowosc varchar(45) NOT NULL,
	numer_telefonu varchar(12) CHECK (LEN(numer_telefonu) >= 9)
);

CREATE TABLE zabieg(
	id_zabieg INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	rodzaj_zabiegu varchar(45),
	opis varchar(255)
);

CREATE TABLE pantomogram(
	id_pantomogram INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	zdjecie varchar(45) NOT NULL,
	opis varchar(255) NOT NULL
);

CREATE TABLE lek(
	id_lek INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	nazwa varchar(255) CHECK(LEN(nazwa) > 3)
);

CREATE TABLE recepta(
	id_recepta INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	opis varchar(255),
	data_wystawienia DATE NOT NULL CHECK(data_wystawienia <= GETDATE()),
	refundacja BIT NOT NULL
);

CREATE TABLE recepta_has_lek(
	id_recepta INTEGER FOREIGN KEY REFERENCES recepta(id_recepta),
	id_lek INTEGER FOREIGN KEY REFERENCES lek(id_lek)
);

CREATE TABLE dentysta(
	id_dentysta INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_dane INTEGER FOREIGN KEY REFERENCES dane(id_dane)
);

CREATE TABLE pacjent(
	id_pacjent INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_dane INTEGER FOREIGN KEY REFERENCES dane(id_dane),
	pesel varchar(11) NOT NULL CHECK(LEN(pesel) = 11)
);

CREATE TABLE wizyta(
	id_wizyta INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_recepta INTEGER FOREIGN KEY REFERENCES recepta(id_recepta),
	id_pacjent INTEGER FOREIGN KEY REFERENCES pacjent(id_pacjent),
	id_dentysta INTEGER FOREIGN KEY REFERENCES dentysta(id_dentysta),
	data_wizyty DATE NOT NULL,
	data_nastepnego_przegladu DATE NOT NULL,
	cena FLOAT
);

CREATE TABLE historia_leczenia(
	id_historia_leczenia INTEGER NOT NULL PRIMARY KEY IDENTITY(1,1),
	id_zabieg INTEGER FOREIGN KEY REFERENCES zabieg(id_zabieg),
	id_wizyta INTEGER FOREIGN KEY REFERENCES wizyta(id_wizyta),
	id_pantomogram INTEGER FOREIGN KEY REFERENCES pantomogram(id_pantomogram)
);

INSERT INTO dane (imie, nazwisko, ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Jan', 'Kowalski', 'Wojskowa', '14', '2', '01-232', 'Gdynia', '+48595484787');
INSERT INTO dane (imie, nazwisko, ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Tomasz', 'Nowak', 'Daleka', '11', '6', '22-444', 'Sopot', '+48646787787');
INSERT INTO dane (imie, nazwisko, ulica, nr_domu, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Tadeusz', 'Nowy', 'Bliska', '5', '02-454', 'Olsztyn', '+48949787314');
INSERT INTO dane (imie, nazwisko, nr_domu, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Albert', 'Mederski', '22', '91-874', 'Montowo','+48423647831');
INSERT INTO dane (imie, nazwisko, ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Zenon', 'Wojtyla', 'Cyganska', '76', '32', '99-456', 'Przasnysz', '+48434131277');
INSERT INTO dane (imie, nazwisko, ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Kazimierz', 'Normalny', 'Wawelska', '69', '96', '45-554', 'Ilawa', '+48194236478');
INSERT INTO dane (imie, nazwisko, ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Amadeusz', 'Lokietko', 'Menelska', '54', '3', '99-456', 'Przasnysz', '+48123331337');
INSERT INTO dane (imie, nazwisko, ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Aleksander', 'Kwasniewski', 'Menelska', '3', '2', '14-552', 'Krakow', '+48131454123');
INSERT INTO dane (imie, nazwisko, ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Lech', 'Walesa', 'Stoczni', '5', '123', '54-221', 'Gdansk', '+48412974123');
INSERT INTO dane (imie, nazwisko, ulica, nr_domu, nr_mieszkania, kod_pocztowy, miejscowosc, numer_telefonu) VALUES ('Boleslaw', 'Stanislawowski', 'Takasobie', '11', '12', '45-131', 'Wejherowo', '+48499741237');

INSERT INTO zabieg (rodzaj_zabiegu, opis) VALUES ('wyrywanie zeba', 'standardowe wyrywanie zeba');
INSERT INTO zabieg (rodzaj_zabiegu, opis) VALUES ('wyrywanie zeba madrosci', 'standardowe wyrywanie zeba madrosci');
INSERT INTO zabieg (rodzaj_zabiegu) VALUES ('lakowanie');
INSERT INTO zabieg (rodzaj_zabiegu, opis) VALUES ('leczenie', 'leczenie zeba');
INSERT INTO zabieg (rodzaj_zabiegu) VALUES ('leczenie kanalowe');

INSERT INTO pantomogram (zdjecie, opis) VALUES ('001.PNG', 'BRAK ZEBA DRUGIEGO');
INSERT INTO pantomogram (zdjecie, opis) VALUES ('002.PNG', 'BRAK ZEBA TRZECIEGO');
INSERT INTO pantomogram (zdjecie, opis) VALUES ('003.PNG', 'BRAK KOSCI ZUCHWY');
INSERT INTO pantomogram (zdjecie, opis) VALUES ('004.PNG', 'BRAK NIEPRAWIDLOWOSCI');
INSERT INTO pantomogram (zdjecie, opis) VALUES ('005.PNG', 'BRAK ZEBA OSMEGO');

INSERT INTO lek (nazwa) VALUES ('Lekarstwo');
INSERT INTO lek (nazwa) VALUES ('Placebo');
INSERT INTO lek (nazwa) VALUES ('Valium');
INSERT INTO lek (nazwa) VALUES ('Pyralgina');
INSERT INTO lek (nazwa) VALUES ('Ibuprom');

INSERT INTO recepta (opis, data_wystawienia, refundacja) VALUES ('normalna recepta', GETDATE(), 1);
INSERT INTO recepta (opis, data_wystawienia, refundacja) VALUES ('dziwna recepta', GETDATE(), 0);
INSERT INTO recepta (opis, data_wystawienia, refundacja) VALUES ('standardowa recepta', GETDATE(), 1);
INSERT INTO recepta (opis, data_wystawienia, refundacja) VALUES ('normalna recepta', GETDATE(), 0);
INSERT INTO recepta (opis, data_wystawienia, refundacja) VALUES ('zwykla recepta', GETDATE(), 1);

INSERT INTO recepta_has_lek (id_recepta, id_lek) VALUES (1, 1);
INSERT INTO recepta_has_lek (id_recepta, id_lek) VALUES (2, 3);
INSERT INTO recepta_has_lek (id_recepta, id_lek) VALUES (3, 5);
INSERT INTO recepta_has_lek (id_recepta, id_lek) VALUES (4, 2);
INSERT INTO recepta_has_lek (id_recepta, id_lek) VALUES (3, 1);

INSERT INTO dentysta (id_dane) VALUES (1);
INSERT INTO dentysta (id_dane) VALUES (2);
INSERT INTO dentysta (id_dane) VALUES (3);
INSERT INTO dentysta (id_dane) VALUES (4);
INSERT INTO dentysta (id_dane) VALUES (5);

INSERT INTO pacjent (id_dane, pesel) VALUES (6, 28193456142);
INSERT INTO pacjent (id_dane, pesel) VALUES (7, 12312336142);
INSERT INTO pacjent (id_dane, pesel) VALUES (8, 57547452142);
INSERT INTO pacjent (id_dane, pesel) VALUES (9, 34583945823);
INSERT INTO pacjent (id_dane, pesel) VALUES (10, 27879623472);

INSERT INTO wizyta (id_recepta, id_pacjent, id_dentysta, data_wizyty, data_nastepnego_przegladu) VALUES (1, 1, 1, '22/02/1987', '23/03/1988');
INSERT INTO wizyta (id_recepta, id_pacjent, id_dentysta, data_wizyty, data_nastepnego_przegladu) VALUES (2, 2, 2, '14/05/1997', '11/11/1998');
INSERT INTO wizyta (id_recepta, id_pacjent, id_dentysta, data_wizyty, data_nastepnego_przegladu) VALUES (3, 3, 3, '23/09/1998', '16/08/2008');
INSERT INTO wizyta (id_recepta, id_pacjent, id_dentysta, data_wizyty, data_nastepnego_przegladu) VALUES (4, 4, 4, '19/04/1999', '25/09/2006');
INSERT INTO wizyta (id_recepta, id_pacjent, id_dentysta, data_wizyty, data_nastepnego_przegladu) VALUES (5, 5, 5, '17/08/2005', '19/08/2006');

INSERT INTO historia_leczenia (id_zabieg, id_wizyta, id_pantomogram) VALUES (1, 1, 1);
INSERT INTO historia_leczenia (id_zabieg, id_wizyta, id_pantomogram) VALUES (2, 2, 2);
INSERT INTO historia_leczenia (id_zabieg, id_wizyta, id_pantomogram) VALUES (3, 3, 3);
INSERT INTO historia_leczenia (id_zabieg, id_wizyta, id_pantomogram) VALUES (4, 4, 4);
INSERT INTO historia_leczenia (id_zabieg, id_wizyta, id_pantomogram) VALUES (5, 5, 5);
