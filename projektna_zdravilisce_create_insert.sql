DROP DOMAIN IF EXISTS spol CASCADE ;
DROP DOMAIN IF EXISTS tip_sobe CASCADE ;
DROP TABLE IF EXISTS postne_stevilke, naslovi, osebe, naslovi_osebe, kontaktni_podatki, delavci_v_kuhiniji, dobavitelji, naslovi_dobavitelji, jedi, sestavine, jedi_sestavine,
    narocila_sestavin, zdravniki, pacienti, terapije, napotnice, zdravljenje, sobe, rezervacije, racuni, dieta, prehranski_list, jedi_diete, sestavine_log, pacienti_log, narocila_obrokov CASCADE ;
CREATE TABLE postne_stevilke (
    id_postna_stevilka SERIAL PRIMARY KEY NOT NULL ,
    postna_stevilka VARCHAR(10) NOT NULL ,
    kraj_mesto VARCHAR(20) NOT NULL
);

CREATE TABLE naslovi (
  id_naslova SERIAL PRIMARY KEY NOT NULL,
  ulica VARCHAR NOT NULL,
  je_stalni BOOLEAN NOT NULL,
  id_postne_stevilke INTEGER NOT NULL
);

ALTER TABLE naslovi ADD CONSTRAINT fk_postne_stevilke FOREIGN KEY (id_postne_stevilke) REFERENCES postne_stevilke(id_postna_stevilka)
    ON UPDATE CASCADE ON DELETE RESTRICT;

CREATE DOMAIN spol AS CHAR
    CHECK ( VALUE LIKE 'M' OR VALUE LIKE 'Ž' );

CREATE TABLE osebe (
    id_osebe SERIAL PRIMARY KEY NOT NULL ,
    ime VARCHAR NOT NULL ,
    priimek VARCHAR NOT NULL ,
    spol spol NOT NULL ,
    datum_rojstva DATE NOT NULL
);

CREATE TABLE naslovi_osebe(
    id_naslov INTEGER NOT NULL ,
    id_osebe INTEGER NOT NULL
);

ALTER TABLE naslovi_osebe ADD CONSTRAINT fk_naslovi_osebe_naslovi FOREIGN KEY (id_naslov) REFERENCES naslovi(id_naslova);
ALTER TABLE naslovi_osebe ADD CONSTRAINT fk_naslovi_osebe_osebe FOREIGN KEY (id_osebe) REFERENCES osebe(id_osebe);

CREATE TABLE kontaktni_podatki (
    id_kontaktni SERIAL NOT NULL PRIMARY KEY ,
    e_mail VARCHAR ,
    tel_stevilka VARCHAR(12) ,
    id_osebe INTEGER NOT NULL
);

ALTER TABLE kontaktni_podatki ADD CONSTRAINT fk_kontaktni_podatki_osebe FOREIGN KEY (id_osebe) REFERENCES osebe(id_osebe);

CREATE TABLE delavci_v_kuhiniji (
    id_delavca SERIAL PRIMARY KEY NOT NULL ,
    delovno_mesto VARCHAR(20) NOT NULL ,
    id_osebe INTEGER NOT NULL
);

ALTER TABLE delavci_v_kuhiniji ADD CONSTRAINT fk_delavci_v_kuhinji_osebe FOREIGN KEY (id_osebe) REFERENCES osebe(id_osebe);

CREATE TABLE dobavitelji (
    id_dobavitelja SERIAL PRIMARY KEY NOT NULL ,
    naziv VARCHAR NOT NULL ,
    davcna_st VARCHAR(8) UNIQUE NOT NULL ,
    je_zavezanec_za_ddv BOOLEAN NOT NULL ,
    e_naslov VARCHAR,
    tel_stevilka VARCHAR
);

CREATE TABLE naslovi_dobavitelji (
    id_naslova INTEGER NOT NULL,
    id_dobavitelja INTEGER NOT NULL
);

ALTER TABLE naslovi_dobavitelji ADD CONSTRAINT fk_naslovi_dobavitelji_naslovi FOREIGN KEY (id_naslova) REFERENCES naslovi(id_naslova);
ALTER TABLE naslovi_dobavitelji ADD CONSTRAINT fk_naslovi_dobavitelji_dobavitelji FOREIGN KEY (id_dobavitelja) REFERENCES dobavitelji(id_dobavitelja);

CREATE TABLE jedi (
    id_jedi SERIAL NOT NULL PRIMARY KEY ,
    opis VARCHAR(50) NOT NULL,
    cas_priprave TIME NOT NULL
);

CREATE TABLE sestavine (
    id_sestavine SERIAL NOT NULL PRIMARY KEY ,
    ime VARCHAR NOT NULL ,
    kolicina_zaloge INTEGER NOT NULL ,
    merska_enota VARCHAR(3) NOT NULL
);

CREATE TABLE sestavine_log (
    log_id SERIAL PRIMARY KEY,
    sestavina_id INTEGER NOT NULL,
    sprememba_timestamp TIMESTAMP NOT NULL,
    sprememba_opis TEXT
);

CREATE TABLE jedi_sestavine (
    id_jedi INTEGER not null,
    id_sestavine INTEGER NOT NULL,
    kolicina_sestavine_za_jed INTEGER NOT NULL
    );
ALTER TABLE jedi_sestavine ADD CONSTRAINT fk_jedi_sestavine_jedi FOREIGN KEY (id_jedi) REFERENCES jedi(id_jedi);
ALTER TABLE jedi_sestavine ADD CONSTRAINT fk_jedi_sestavine_sestavine FOREIGN KEY (id_sestavine) REFERENCES sestavine(id_sestavine);

CREATE TABLE narocila_sestavin (
    id_narocila_sestavin SERIAL NOT NULL PRIMARY KEY,
    datum DATE NOT NULL,
    id_dobavitelja INTEGER NOT NULL,
    id_sestavine INTEGER NOT NULL,
    kolicina INTEGER NOT NULL
    );

ALTER TABLE  narocila_sestavin ADD CONSTRAINT fk_narocila_sestavin_dobavitelji FOREIGN KEY (id_dobavitelja) REFERENCES dobavitelji(id_dobavitelja);
ALTER TABLE  narocila_sestavin ADD CONSTRAINT fk_narocila_sestavin_sestavine FOREIGN KEY (id_sestavine) REFERENCES sestavine(id_sestavine);

CREATE TABLE zdravniki (
    id_zdravnika SERIAL NOT NULL PRIMARY KEY ,
    specializacija VARCHAR NOT NULL ,
    "zunanji?" BOOLEAN NOT NULL ,
    id_osebe INTEGER NOT NULL
);

ALTER TABLE zdravniki ADD CONSTRAINT fk_zdravniki_osebe FOREIGN KEY (id_osebe) references osebe(id_osebe);


CREATE TABLE pacienti (
    id_pacienta SERIAL NOT NULL PRIMARY KEY ,
    st_zdr_kartice BIGINT NOT NULL ,
    id_osebe INTEGER NOT NULL
);

CREATE TABLE pacienti_log (
    log_id SERIAL PRIMARY KEY,
    pacient_id INTEGER NOT NULL,
    sprememba_timestamp TIMESTAMP NOT NULL,
    sprememba_opis TEXT
);

ALTER TABLE pacienti ADD CONSTRAINT fk_zdravniki_pacienti FOREIGN KEY (id_osebe) references osebe(id_osebe);

CREATE TABLE terapije (
    id_terapija SERIAL NOT NULL PRIMARY KEY ,
    naziv VARCHAR NOT NULL ,
    opis VARCHAR NOT NULL ,
    trajanje TIME NOT NULL
);

CREATE TABLE napotnice (
    id_napotnica SERIAL NOT NULL PRIMARY KEY ,
    diagnoza VARCHAR NOT NULL,
    id_zdravnika INTEGER NOT NULL,
    id_pacienta INTEGER NOT NULL ,
    id_terapija INTEGER NOT NULL
    );

ALTER TABLE napotnice ADD CONSTRAINT fk_napotnice_zdravniki FOREIGN KEY (id_zdravnika) REFERENCES zdravniki(id_zdravnika);
ALTER TABLE napotnice ADD CONSTRAINT fk_napotnice_pacienti FOREIGN KEY (id_pacienta) REFERENCES pacienti(id_pacienta);
ALTER TABLE napotnice ADD CONSTRAINT fk_napotnice_terapije FOREIGN KEY (id_terapija) REFERENCES terapije(id_terapija);

CREATE TABLE zdravljenje (
    id_zdravljenje SERIAL NOT NULL ,
    id_pacienta INTEGER NOT NULL ,
    id_zdravnika INTEGER NOT NULL ,
    id_napotnica INTEGER NOT NULL ,
    zacetek DATE NOT NULL ,
    konec DATE NOT NULL
);

ALTER TABLE zdravljenje ADD CONSTRAINT fk_zdravljenje_zdravniki FOREIGN KEY (id_zdravnika) REFERENCES zdravniki(id_zdravnika);
ALTER TABLE zdravljenje ADD CONSTRAINT fk_zdravljenje_pacienti FOREIGN KEY (id_pacienta) REFERENCES pacienti(id_pacienta);
ALTER TABLE zdravljenje ADD CONSTRAINT fk_zdravljenje_napotnice FOREIGN KEY (id_napotnica) REFERENCES napotnice(id_napotnica);

CREATE DOMAIN tip_sobe AS VARCHAR
    CHECK ( VALUE LIKE 'enoposteljna' OR VALUE LIKE 'dvoposteljna' OR VALUE LIKE 'apartma');

CREATE TABLE sobe (
    id_sobe SERIAL NOT NULL PRIMARY KEY,
    stevlika_sobe INTEGER NOT NULL ,
    tip_sobe tip_sobe NOT NULL ,
    cena FLOAT NOT NULL
);

CREATE TABLE rezervacije (
    id_rezervacije SERIAL NOT NULL PRIMARY KEY,
    vrsta_storitve VARCHAR NOT NULL ,
    cena FLOAT NOT NULL ,
    id_pacienta INTEGER NOT NULL ,
    id_sobe INTEGER NOT NULL
);

ALTER TABLE rezervacije ADD CONSTRAINT fk_rezervacije_pacienti FOREIGN KEY (id_pacienta) REFERENCES pacienti(id_pacienta);
ALTER TABLE rezervacije ADD CONSTRAINT fk_rezervacije_sobe FOREIGN KEY (id_sobe) REFERENCES sobe(id_sobe);

CREATE TABLE racuni (
    id_racuna SERIAL NOT NULL PRIMARY KEY,
    znesek FLOAT NOT NULL,
    datum DATE NOT NULL ,
    nacin_placila INTEGER NOT NULL,
    id_rezervacije INTEGER NOT NULL
);

ALTER TABLE racuni ADD CONSTRAINT fk_racuni_rezervacije FOREIGN KEY (id_rezervacije) REFERENCES rezervacije(id_rezervacije);

CREATE TABLE dieta (
    id_dieta SERIAL NOT NULL PRIMARY KEY ,
    naziv VARCHAR NOT NULL
);

CREATE TABLE prehranski_list (
    id_preh_lista SERIAL NOT NULL PRIMARY KEY ,
    alergije VARCHAR,
    id_pacienta INTEGER NOT NULL ,
    id_dieta INTEGER NOT NULL
);

ALTER TABLE prehranski_list ADD CONSTRAINT fk_prehranski_list_pacient FOREIGN KEY (id_pacienta) REFERENCES pacienti(id_pacienta);
ALTER TABLE prehranski_list ADD CONSTRAINT fk_prehranski_list_dieta FOREIGN KEY (id_dieta) REFERENCES dieta(id_dieta);

CREATE TABLE jedi_diete (
    id_jedi INTEGER NOT NULL,
    id_dieta INTEGER NOT NULL
);

ALTER TABLE jedi_diete ADD CONSTRAINT fk_jedi_diete_jedi FOREIGN KEY (id_jedi) REFERENCES jedi(id_jedi);
ALTER TABLE jedi_diete ADD CONSTRAINT fk_jedi_diete_diete FOREIGN KEY (id_dieta) REFERENCES dieta(id_dieta);

CREATE TABLE narocila_obrokov(
    id_narocila_obr SERIAL PRIMARY KEY NOT NULL,
    id_pacienta INTEGER NOT NULL,
    id_jedi INTEGER NOT NULL,
    datum DATE NOT NULL
);

ALTER TABLE narocila_obrokov ADD CONSTRAINT fk_narocila_obrokov_pacienti FOREIGN KEY (id_pacienta) REFERENCES pacienti(id_pacienta);
ALTER TABLE narocila_obrokov ADD CONSTRAINT fk_narocila_obrokov_jedi FOREIGN KEY (id_jedi) REFERENCES jedi(id_jedi);

-- Tabela postne_stevilke
SELECT insert_postna_stevilka('1000', 'Ljubljana');
SELECT insert_postna_stevilka('2000', 'Maribor');
SELECT insert_postna_stevilka('3000', 'Celje');
SELECT insert_postna_stevilka('4000', 'Kranj');
SELECT insert_postna_stevilka('5000', 'Nova Gorica');
SELECT insert_postna_stevilka('6000', 'Koper');

-- Tabela naslovi
SELECT insert_naslov('Ulica 1', true, 1);
SELECT insert_naslov('Ulica 2', false, 2);
SELECT insert_naslov('Ulica 3', true, 3);
SELECT insert_naslov('Ulica 4', true, 4);
SELECT insert_naslov('Ulica 5', false, 5);
SELECT insert_naslov('Ulica 6', true, 6);
-- Tabela osebe
INSERT INTO osebe (ime, priimek, spol, datum_rojstva)
VALUES
    ('Janez', 'Novak', 'M', '1990-01-01'),
    ('Ana', 'Kovač', 'Ž', '1995-05-10'),
    ('Marko', 'Horvat', 'M', '1985-12-15'),
    ('Maja', 'Lah', 'Ž', '1992-09-22'),
    ('Andrej', 'Krajnc', 'M', '1988-06-12'),
    ('Sara', 'Zupan', 'Ž', '1998-03-27');

-- Tabela naslovi_osebe
INSERT INTO naslovi_osebe (id_naslov, id_osebe)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6);

-- Tabela kontaktni_podatki
INSERT INTO kontaktni_podatki (e_mail, tel_stevilka, id_osebe)
VALUES
    ('janez.novak@email.com', '123456789', 1),
    ('ana.kovac@email.com', '987654321', 2),
    ('marko.horvat@email.com', '456789123', 3),
    ('maja.lah@email.com', '789123456', 4),
    ('andrej.krajnc@email.com', '321654987', 5),
    ('sara.zupan@email.com', '654789321', 6);

-- Tabela delavci_v_kuhiniji
SELECT insert_delavec_v_kuhiniji('Kuhar', 1);
SELECT insert_delavec_v_kuhiniji('Pomočnik kuharja', 2);

-- Tabela dobavitelji
INSERT INTO dobavitelji (naziv, davcna_st, je_zavezanec_za_ddv, e_naslov, tel_stevilka)
VALUES
    ('Dobavitelj 1', '12345678', true, 'dobavitelj1@email.com', '111111111'),
    ('Dobavitelj 2', '87654321', false, 'dobavitelj2@email.com', '222222222'),
    ('Dobavitelj 3', '98765432', true, 'dobavitelj3@email.com', '333333333'),
    ('Dobavitelj 4', '23456789', true, 'dobavitelj4@email.com', '444444444'),
    ('Dobavitelj 5', '98765421', false, 'dobavitelj5@email.com', '555555555'),
    ('Dobavitelj 6', '87654329', true, 'dobavitelj6@email.com', '666666666');

-- Tabela naslovi_dobavitelji
SELECT insert_naslovi_dobavitelji(1, 1);
SELECT insert_naslovi_dobavitelji(2, 2);
SELECT insert_naslovi_dobavitelji(3, 3);
SELECT insert_naslovi_dobavitelji(4, 4);
SELECT insert_naslovi_dobavitelji(5, 5);
SELECT insert_naslovi_dobavitelji(6, 6);

-- Tabela jedi
SELECT insert_jed('Testna jed 1', '00:30:00');
SELECT insert_jed('Testna jed 2', '01:15:00');
SELECT insert_jed('Testna jed 3', '00:45:00');
SELECT insert_jed('Testna jed 4', '01:00:00');
SELECT insert_jed('Testna jed 5', '00:50:00');
SELECT insert_jed('Testna jed 6', '01:30:00');

-- Tabela sestavine
INSERT INTO sestavine (ime, kolicina_zaloge, merska_enota)
VALUES
    ('Sestavina 1', 100, 'g'),
    ('Sestavina 2', 200, 'g'),
    ('Sestavina 3', 150, 'g'),
    ('Sestavina 4', 250, 'g'),
    ('Sestavina 5', 120, 'g'),
    ('Sestavina 6', 180, 'g');
INSERT INTO sestavine (ime, kolicina_zaloge, merska_enota)
VALUES
    ('sd sa', 2, 'g');
-- Tabela jedi_sestavine
INSERT INTO jedi_sestavine (id_jedi, id_sestavine, kolicina_sestavine_za_jed)
VALUES
    (1, 1, 50),
    (1, 2, 75),
    (2, 3, 100),
    (2, 4, 125),
    (3, 5, 80),
    (3, 6, 95),
    (4, 1, 999);

-- Tabela narocila_sestavin
INSERT INTO narocila_sestavin (datum, id_dobavitelja, id_sestavine, kolicina)
VALUES
    ('2023-01-01', 1, 1, 100),
    ('2023-02-01', 2, 2, 150),
    ('2023-03-01', 3, 3, 200),
    ('2023-04-01', 4, 4, 250),
    ('2023-05-01', 5, 5, 300),
    ('2023-06-01', 6, 6, 350);

-- Tabela zdravniki
SELECT insert_zdravnik('Ortoped', false, 3);
SELECT insert_zdravnik('Kardiolog', false, 4);

-- Tabela pacienti
SELECT insert_pacient(901234567, 5);
SELECT insert_pacient(345678901, 6);

-- Tabela terapije
INSERT INTO terapije (naziv, opis, trajanje)
VALUES
    ('Terapija 1', 'Opis terapije 1', '01:00:00'),
    ('Terapija 2', 'Opis terapije 2', '01:30:00'),
    ('Terapija 3', 'Opis terapije 3', '01:15:00'),
    ('Terapija 4', 'Opis terapije 4', '02:00:00'),
    ('Terapija 5', 'Opis terapije 5', '00:45:00'),
    ('Terapija 6', 'Opis terapije 6', '01:45:00');

-- Tabela napotnice
INSERT INTO napotnice (diagnoza, id_zdravnika, id_pacienta, id_terapija)
VALUES
    ('Diagnoza 1', 1, 1, 1),
    ('Diagnoza 2', 2, 2, 2),
    ('Diagnoza 3', 1, 1, 3),
    ('Diagnoza 4', 2, 2, 4);

-- Tabela zdravljenje
INSERT INTO zdravljenje (id_pacienta, id_zdravnika, id_napotnica, zacetek, konec)
VALUES
    (1, 1, 1, '2023-01-01', '2023-01-15'),
    (2, 2, 2, '2023-02-01', '2023-02-15'),
    (2, 2, 3, '2023-03-01', '2023-03-15'),
    (1, 2, 4, '2023-04-01', '2023-04-15');

-- Tabela sobe
INSERT INTO sobe (stevlika_sobe, tip_sobe, cena)
VALUES
    (101, 'enoposteljna', 50.00),
    (102, 'enoposteljna', 50.00),
    (201, 'enoposteljna', 70.00),
    (202, 'enoposteljna', 70.00),
    (301, 'apartma', 100.00),
    (302, 'apartma', 100.00);

-- Tabela rezervacije
SELECT insert_rezervacija('Apartma', 10.00, 1, 1);
SELECT insert_rezervacija('enpposteljna', 10.00, 2, 2);

-- Tabela racuni
SELECT insert_racun(60.00, '2023-01-15', 1, 1);
SELECT insert_racun(20.00, '2023-02-15', 2, 2);

-- Tabela dieta
INSERT INTO dieta (naziv)
VALUES
    ('Dieta 1'),
    ('Dieta 2'),
    ('Dieta 3'),
    ('Dieta 4'),
    ('Dieta 5'),
    ('Dieta 6');

-- Tabela prehranski_list
SELECT insert_prehranski_list('', 1, 1);
SELECT insert_prehranski_list('Alergija 2', 2, 2);


-- Tabela jedi_diete
INSERT INTO jedi_diete (id_jedi, id_dieta)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 3),
    (6, 4);

INSERT INTO narocila_obrokov (id_pacienta, id_jedi, datum)
VALUES
    (1, 2, '2023-06-13'),
    (2, 4, '2023-06-14');
INSERT INTO narocila_obrokov (id_pacienta, id_jedi, datum)
VALUES
    (1, 2, '2023-06-17'),
    (2, 4, '2023-06-17');