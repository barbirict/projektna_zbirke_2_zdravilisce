-- INSERT
CREATE OR REPLACE FUNCTION insert_postna_stevilka(postna_stevilka VARCHAR(10), kraj_mesto VARCHAR(20)) RETURNS VOID AS $$
BEGIN
    INSERT INTO postne_stevilke(postna_stevilka, kraj_mesto) VALUES (postna_stevilka, kraj_mesto);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_postna_stevilka(postna_stevilka_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM postne_stevilke WHERE id_postna_stevilka = postna_stevilka_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_postna_stevilka(postna_stevilka_id INTEGER, new_postna_stevilka VARCHAR(10), new_kraj_mesto VARCHAR(20)) RETURNS VOID AS $$
BEGIN
    UPDATE postne_stevilke SET postna_stevilka = new_postna_stevilka, kraj_mesto = new_kraj_mesto WHERE id_postna_stevilka = postna_stevilka_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_oseba(ime VARCHAR, priimek VARCHAR, spol CHAR, datum_rojstva DATE) RETURNS VOID AS $$
BEGIN
    INSERT INTO osebe(ime, priimek, spol, datum_rojstva) VALUES (ime, priimek, spol, datum_rojstva);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_oseba(oseba_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM osebe WHERE id_osebe = oseba_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_oseba(oseba_id INTEGER, new_ime VARCHAR, new_priimek VARCHAR, new_spol CHAR, new_datum_rojstva DATE) RETURNS VOID AS $$
BEGIN
    UPDATE osebe SET ime = new_ime, priimek = new_priimek, spol = new_spol, datum_rojstva = new_datum_rojstva WHERE id_osebe = oseba_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_dobavitelj(naziv VARCHAR, davcna_st VARCHAR(8), je_zavezanec_za_ddv BOOLEAN, e_naslov VARCHAR, tel_stevilka VARCHAR) RETURNS VOID AS $$
BEGIN
    INSERT INTO dobavitelji(naziv, davcna_st, je_zavezanec_za_ddv, e_naslov, tel_stevilka) VALUES (naziv, davcna_st, je_zavezanec_za_ddv, e_naslov, tel_stevilka);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_dobavitelj(dobavitelj_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM dobavitelji WHERE id_dobavitelja = dobavitelj_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_dobavitelj(dobavitelj_id INTEGER, new_naziv VARCHAR, new_davcna_st VARCHAR(8), new_je_zavezanec_za_ddv BOOLEAN, new_e_naslov VARCHAR, new_tel_stevilka VARCHAR) RETURNS VOID AS $$
BEGIN
    UPDATE dobavitelji SET naziv = new_naziv, davcna_st = new_davcna_st, je_zavezanec_za_ddv = new_je_zavezanec_za_ddv, e_naslov = new_e_naslov, tel_stevilka = new_tel_stevilka WHERE id_dobavitelja = dobavitelj_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_naslov(ulica VARCHAR, je_stalni BOOLEAN, id_postne_stevilke INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO naslovi(ulica, je_stalni, id_postne_stevilke) VALUES (ulica, je_stalni, id_postne_stevilke);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_naslov(naslov_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM naslovi WHERE id_naslova = naslov_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_naslov(naslov_id INTEGER, new_ulica VARCHAR, new_je_stalni BOOLEAN, new_id_postne_stevilke INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE naslovi SET ulica = new_ulica, je_stalni = new_je_stalni, id_postne_stevilke = new_id_postne_stevilke WHERE id_naslova = naslov_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_naslov_osebe(id_naslov INTEGER, id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO naslovi_osebe(id_naslov, id_osebe) VALUES (id_naslov, id_osebe);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_naslov_osebe(id_naslovV INTEGER, id_osebeE INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM naslovi_osebe WHERE id_naslov = id_naslovV AND id_osebe = id_osebeE;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_naslov_osebe(old_id_naslov INTEGER, old_id_osebe INTEGER, new_id_naslov INTEGER, new_id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE naslovi_osebe SET id_naslov = new_id_naslov, id_osebe = new_id_osebe WHERE id_naslov = old_id_naslov AND id_osebe = old_id_osebe;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_naslovi_dobavitelji(
    _id_naslova INTEGER,
    _id_dobavitelja INTEGER
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO naslovi_dobavitelji (id_naslova, id_dobavitelja)
    VALUES (_id_naslova, _id_dobavitelja);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_naslovi_dobavitelji(
    _id_naslova INTEGER,
    _id_dobavitelja INTEGER
)
RETURNS VOID AS $$
BEGIN
    DELETE FROM naslovi_dobavitelji
    WHERE id_naslova = _id_naslova AND id_dobavitelja = _id_dobavitelja;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_naslovi_dobavitelji(
    _id_naslova INTEGER,
    _id_dobavitelja INTEGER,
    _new_id_naslova INTEGER,
    _new_id_dobavitelja INTEGER
)
RETURNS VOID AS $$
BEGIN
    UPDATE naslovi_dobavitelji
    SET id_naslova = _new_id_naslova, id_dobavitelja = _new_id_dobavitelja
    WHERE id_naslova = _id_naslova AND id_dobavitelja = _id_dobavitelja;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_kontaktni_podatek(e_mail VARCHAR(20), tel_stevilka VARCHAR(12), id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO kontaktni_podatki(e_mail, tel_stevilka, id_osebe) VALUES (e_mail, tel_stevilka, id_osebe);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_kontaktni_podatek(kontaktni_podatek_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM kontaktni_podatki WHERE id_kontaktni = kontaktni_podatek_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_kontaktni_podatek(kontaktni_podatek_id INTEGER, new_e_mail VARCHAR(20), new_tel_stevilka VARCHAR(12), new_id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE kontaktni_podatki SET e_mail = new_e_mail, tel_stevilka = new_tel_stevilka, id_osebe = new_id_osebe WHERE id_kontaktni = kontaktni_podatek_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_delavec_v_kuhiniji(delovno_mesto VARCHAR(20), id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO delavci_v_kuhiniji(delovno_mesto, id_osebe) VALUES (delovno_mesto, id_osebe);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_delavec_v_kuhiniji(delavec_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM delavci_v_kuhiniji WHERE id_delavca = delavec_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_delavec_v_kuhiniji(delavec_id INTEGER, new_delovno_mesto VARCHAR(20), new_id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE delavci_v_kuhiniji SET delovno_mesto = new_delovno_mesto, id_osebe = new_id_osebe WHERE id_delavca = delavec_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_jed(opis VARCHAR(50), cas_priprave TIME) RETURNS VOID AS $$
BEGIN
    INSERT INTO jedi(opis, cas_priprave) VALUES (opis, cas_priprave);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_jed(jed_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM jedi WHERE id_jedi = jed_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_jed(jed_id INTEGER, new_opis VARCHAR(50), new_cas_priprave TIME) RETURNS VOID AS $$
BEGIN
    UPDATE jedi SET opis = new_opis, cas_priprave = new_cas_priprave WHERE id_jedi = jed_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_sestavina(ime VARCHAR, kolicina_zaloge INTEGER, merska_enota VARCHAR(3)) RETURNS VOID AS $$
BEGIN
    INSERT INTO sestavine(ime, kolicina_zaloge, merska_enota) VALUES (ime, kolicina_zaloge, merska_enota);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_sestavina(sestavina_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM sestavine WHERE id_sestavine = sestavina_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_sestavina(sestavina_id INTEGER, new_ime VARCHAR, new_kolicina_zaloge INTEGER, new_merska_enota VARCHAR(3)) RETURNS VOID AS $$
BEGIN
    UPDATE sestavine SET ime = new_ime, kolicina_zaloge = new_kolicina_zaloge, merska_enota = new_merska_enota WHERE id_sestavine = sestavina_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_jed_sestavina(id_jedi INTEGER, id_sestavine INTEGER, kolicina_sestavine_za_jed INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO jedi_sestavine(id_jedi, id_sestavine, kolicina_sestavine_za_jed) VALUES (id_jedi, id_sestavine, kolicina_sestavine_za_jed);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_jed_sestavina(id_jediI INTEGER, id_sestavineE INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM jedi_sestavine WHERE id_jedi = id_jediI AND id_sestavine = id_sestavineE;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_jed_sestavina(old_id_jedi INTEGER, old_id_sestavine INTEGER, new_id_jedi INTEGER, new_id_sestavine INTEGER, new_kolicina_sestavine_za_jed INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE jedi_sestavine SET id_jedi = new_id_jedi, id_sestavine = new_id_sestavine, kolicina_sestavine_za_jed = new_kolicina_sestavine_za_jed WHERE id_jedi = old_id_jedi AND id_sestavine = old_id_sestavine;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_narocilo_sestavin(id_narocila_sestavin INTEGER, datum DATE, id_dobavitelja INTEGER, id_sestavine INTEGER, kolicina INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO narocila_sestavin(id_narocila_sestavin, datum, id_dobavitelja, id_sestavine, kolicina) VALUES (id_narocila_sestavin, datum, id_dobavitelja, id_sestavine, kolicina);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_narocilo_sestavin(narocilo_sestavin_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM narocila_sestavin WHERE id_narocila_sestavin = narocilo_sestavin_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_narocilo_sestavin(narocilo_sestavin_id INTEGER, new_id_narocila_sestavin INTEGER, new_datum DATE, new_id_dobavitelja INTEGER, new_id_sestavine INTEGER, new_kolicina INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE narocila_sestavin SET id_narocila_sestavin = new_id_narocila_sestavin, datum = new_datum, id_dobavitelja = new_id_dobavitelja, id_sestavine = new_id_sestavine, kolicina = new_kolicina WHERE id_narocila_sestavin = narocilo_sestavin_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_zdravnik(specializacija VARCHAR, "zunanji?" BOOLEAN, id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO zdravniki(specializacija, "zunanji?", id_osebe) VALUES (specializacija, "zunanji?", id_osebe);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_zdravnik(zdravnik_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM zdravniki WHERE id_zdravnika = zdravnik_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_zdravnik(zdravnik_id INTEGER, new_specializacija VARCHAR, new_zunanji BOOLEAN, new_id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE zdravniki SET specializacija = new_specializacija, "zunanji?" = new_zunanji, id_osebe = new_id_osebe WHERE id_zdravnika = zdravnik_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_pacient(st_zdr_kartice BIGINT, id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO pacienti(st_zdr_kartice, id_osebe) VALUES (st_zdr_kartice, id_osebe);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_pacient(pacient_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM pacienti WHERE id_pacienta = pacient_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_pacient(pacient_id INTEGER, new_st_zdr_kartice BIGINT, new_id_osebe INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE pacienti SET st_zdr_kartice = new_st_zdr_kartice, id_osebe = new_id_osebe WHERE id_pacienta = pacient_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_terapija(naziv VARCHAR, opis VARCHAR, trajanje TIME) RETURNS VOID AS $$
BEGIN
    INSERT INTO terapije(naziv, opis, trajanje) VALUES (naziv, opis, trajanje);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_terapija(terapija_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM terapije WHERE id_terapija = terapija_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_terapija(terapija_id INTEGER, new_naziv VARCHAR, new_opis VARCHAR, new_trajanje TIME) RETURNS VOID AS $$
BEGIN
    UPDATE terapije SET naziv = new_naziv, opis = new_opis, trajanje = new_trajanje WHERE id_terapija = terapija_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_napotnica(diagnoza VARCHAR, id_zdravnika INTEGER, id_pacienta INTEGER, id_terapija INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO napotnice(diagnoza, id_zdravnika, id_pacienta, id_terapija) VALUES (diagnoza, id_zdravnika, id_pacienta, id_terapija);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_napotnica(napotnica_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM napotnice WHERE id_napotnica = napotnica_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_napotnica(napotnica_id INTEGER, new_diagnoza VARCHAR, new_id_zdravnika INTEGER, new_id_pacienta INTEGER, new_id_terapija INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE napotnice SET diagnoza = new_diagnoza, id_zdravnika = new_id_zdravnika, id_pacienta = new_id_pacienta, id_terapija = new_id_terapija WHERE id_napotnica = napotnica_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_zdravljenje(id_pacienta INTEGER, id_zdravnika INTEGER, id_napotnica INTEGER, zacetek DATE, konec DATE) RETURNS VOID AS $$
BEGIN
    INSERT INTO zdravljenje(id_pacienta, id_zdravnika, id_napotnica, zacetek, konec) VALUES (id_pacienta, id_zdravnika, id_napotnica, zacetek, konec);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_zdravljenje(zdravljenje_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM zdravljenje WHERE id_zdravljenje = zdravljenje_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_zdravljenje(zdravljenje_id INTEGER, new_id_pacienta INTEGER, new_id_zdravnika INTEGER, new_id_napotnica INTEGER, new_zacetek DATE, new_konec DATE) RETURNS VOID AS $$
BEGIN
    UPDATE zdravljenje SET id_pacienta = new_id_pacienta, id_zdravnika = new_id_zdravnika, id_napotnica = new_id_napotnica, zacetek = new_zacetek, konec = new_konec WHERE id_zdravljenje = zdravljenje_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_soba(stevlika_sobe INTEGER, tip_sobe tip_sobe, cena FLOAT) RETURNS VOID AS $$
BEGIN
    INSERT INTO sobe(stevlika_sobe, tip_sobe, cena) VALUES (stevlika_sobe, tip_sobe, cena);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_soba(soba_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM sobe WHERE id_sobe = soba_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_soba(soba_id INTEGER, new_stevlika_sobe INTEGER, new_tip_sobe tip_sobe, new_cena FLOAT) RETURNS VOID AS $$
BEGIN
    UPDATE sobe SET stevlika_sobe = new_stevlika_sobe, tip_sobe = new_tip_sobe, cena = new_cena WHERE id_sobe = soba_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_rezervacija(vrsta_storitve VARCHAR, cena FLOAT, id_pacienta INTEGER, id_sobe INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO rezervacije(vrsta_storitve, cena, id_pacienta, id_sobe) VALUES (vrsta_storitve, cena, id_pacienta, id_sobe);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_rezervacija(rezervacija_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM rezervacije WHERE id_rezervacije = rezervacija_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_rezervacija(rezervacija_id INTEGER, new_vrsta_storitve VARCHAR, new_cena FLOAT, new_id_pacienta INTEGER, new_id_sobe INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE rezervacije SET vrsta_storitve = new_vrsta_storitve, cena = new_cena, id_pacienta = new_id_pacienta, id_sobe = new_id_sobe WHERE id_rezervacije = rezervacija_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_racun(znesek FLOAT, datum DATE, nacin_placila INTEGER, id_rezervacije INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO racuni(znesek, datum, nacin_placila, id_rezervacije) VALUES (znesek, datum, nacin_placila, id_rezervacije);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_racun(racun_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM racuni WHERE id_racuna = racun_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_racun(racun_id INTEGER, new_znesek FLOAT, new_datum DATE, new_nacin_placila INTEGER, new_id_rezervacije INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE racuni SET znesek = new_znesek, datum = new_datum, nacin_placila = new_nacin_placila, id_rezervacije = new_id_rezervacije WHERE id_racuna = racun_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_dieta(naziv VARCHAR) RETURNS VOID AS $$
BEGIN
    INSERT INTO dieta(naziv) VALUES (naziv);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_dieta(dieta_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM dieta WHERE id_dieta = dieta_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_dieta(dieta_id INTEGER, new_naziv VARCHAR) RETURNS VOID AS $$
BEGIN
    UPDATE dieta SET naziv = new_naziv WHERE id_dieta = dieta_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_prehranski_list(alergije VARCHAR, id_pacienta INTEGER, id_dieta INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO prehranski_list(alergije, id_pacienta, id_dieta) VALUES (alergije, id_pacienta, id_dieta);
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_prehranski_list(list_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM prehranski_list WHERE id_preh_lista = list_id;
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_prehranski_list(list_id INTEGER, new_alergije VARCHAR, new_id_pacienta INTEGER, new_id_dieta INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE prehranski_list SET alergije = new_alergije, id_pacienta = new_id_pacienta, id_dieta = new_id_dieta WHERE id_preh_lista = list_id;
END;
$$ LANGUAGE plpgsql;

-- INSERT
CREATE OR REPLACE FUNCTION insert_jedi_diete(jedi_id INTEGER, dieta_id INTEGER) RETURNS VOID AS $$
BEGIN
    INSERT INTO jedi_diete(id_jedi, id_dieta) VALUES (jedi_id, dieta_id);
END;
$$ LANGUAGE plpgsql;

-- UPDATE
CREATE OR REPLACE FUNCTION update_jedi_diete(old_jedi_id INTEGER, old_dieta_id INTEGER, new_jedi_id INTEGER, new_dieta_id INTEGER) RETURNS VOID AS $$
BEGIN
    UPDATE jedi_diete SET id_jedi = new_jedi_id, id_dieta = new_dieta_id WHERE id_jedi = old_jedi_id AND id_dieta = old_dieta_id;
END;
$$ LANGUAGE plpgsql;

-- DELETE
CREATE OR REPLACE FUNCTION delete_jedi_diete(jedi_id INTEGER, dieta_id INTEGER) RETURNS VOID AS $$
BEGIN
    DELETE FROM jedi_diete WHERE id_jedi = jedi_id AND id_dieta = dieta_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION pacienti_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO pacienti_log (pacient_id, sprememba_timestamp, sprememba_opis)
        VALUES (NEW.id_pacienta, current_timestamp, 'Vstavljen nov pacient');
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO pacienti_log (pacient_id, sprememba_timestamp, sprememba_opis)
        VALUES (NEW.id_pacienta, current_timestamp, 'Posodobljen pacient');
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO pacienti_log (pacient_id, sprememba_timestamp, sprememba_opis)
        VALUES (OLD.id_pacienta, current_timestamp, 'Izbrisan pacient');
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER pacienti_trigger
AFTER INSERT OR UPDATE OR DELETE ON pacienti
FOR EACH ROW
EXECUTE FUNCTION pacienti_trigger();

CREATE OR REPLACE FUNCTION sestavine_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO sestavine_log (sestavina_id, sprememba_timestamp, sprememba_opis)
        VALUES (NEW.id_sestavine, current_timestamp, 'Dodana nova sestavina');
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO sestavine_log (sestavina_id, sprememba_timestamp, sprememba_opis)
        VALUES (NEW.id_sestavine, current_timestamp, 'Posodobljen sestavina');
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO sestavine_log (sestavina_id, sprememba_timestamp, sprememba_opis)
        VALUES (OLD.id_sestavine, current_timestamp, 'Izbrisana sestavina');
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER sestavine_trigger
AFTER INSERT OR UPDATE OR DELETE ON sestavine
FOR EACH ROW
EXECUTE FUNCTION sestavine_trigger();

CREATE OR REPLACE FUNCTION narocilo_obroka_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF(TG_OP = 'INSERT') THEN
        INSERT INTO narocila_sestavin (id_sestavine, kolicina, datum, id_dobavitelja)
            SELECT id_sestavine, kolicina_sestavine_za_jed, no.datum, 1
            FROM jedi_sestavine
                     INNER JOIN jedi j on jedi_sestavine.id_jedi = j.id_jedi
                     INNER JOIN narocila_obrokov no on j.id_jedi = no.id_jedi
            WHERE no.id_jedi = NEW.id_jedi;
    end if;
    RETURN NEW;
end; $$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER narocilo_obroka_trigger
AFTER INSERT ON narocila_obrokov
FOR EACH ROW
EXECUTE FUNCTION narocilo_obroka_trigger();

--KREACIJA ROLE-OV IN USERJEVđ
DROP USER IF EXISTS kuhar1, zdravnik1, zdravnik2, pacient1, pacient2;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM kuhar;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM zdravnik;
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM pacient;
REVOKE CONNECT ON DATABASE projektna_zdravilisce FROM kuhar, zdravnik, pacient;
REVOKE USAGE ON SCHEMA public FROM kuhar, zdravnik, pacient;
DROP ROLE IF EXISTS kuhar, zdravnik, pacient;
CREATE ROLE kuhar;
CREATE ROLE zdravnik;
CREATE ROLE pacient;
GRANT CONNECT ON DATABASE projektna_zdravilisce TO kuhar, zdravnik, pacient;
GRANT USAGE ON SCHEMA public TO kuhar, zdravnik, pacient;
GRANT SELECT, INSERT, DELETE, UPDATE ON TABLE sestavine, jedi, jedi_sestavine, narocila_sestavin TO kuhar;
GRANT SELECT ON TABLE  narocila_obrokov, jedi_diete, delavci_v_kuhiniji, osebe TO kuhar;
GRANT SELECT, INSERT, DELETE, UPDATE ON TABLE  terapije, zdravljenje, napotnice, prehranski_list, dieta, jedi_diete TO zdravnik;
GRANT SELECT ON TABLE zdravniki, osebe, pacienti TO zdravnik;
GRANT  SELECT, INSERT ON TABLE narocila_obrokov TO pacient;
GRANT SELECT ON TABLE napotnice, jedi, jedi_diete, dieta, prehranski_list, rezervacije, racuni TO pacient;
CREATE USER kuhar1 WITH  PASSWORD '123455';
GRANT kuhar TO kuhar1;
CREATE USER zdravnik1 WITH  PASSWORD '123455';
GRANT zdravnik TO zdravnik1;
CREATE USER zdravnik2 WITH  PASSWORD '123455';
GRANT zdravnik TO zdravnik2;
CREATE USER pacient1 WITH PASSWORD '123455';
GRANT pacient TO pacient1;
CREATE USER pacient2 WITH PASSWORD '123455';
GRANT pacient TO pacient2;
