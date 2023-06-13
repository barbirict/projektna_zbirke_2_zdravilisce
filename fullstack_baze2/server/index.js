const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors')
const { Pool } = require('pg');

const app = express();
app.use(cors())

app.use(bodyParser.json());

const pool = new Pool({
    user: 'admin',
    host: '192.168.100.205',
    database: 'projektna_zdravilisce',
    password: 'nagimali',
    port: 5432,
});

function isAuthenticated(req, res, next) {
    if (
        req.headers.authorization &&
        req.headers.authorization.startsWith('Bearer ')
    ) {
        const token = req.headers.authorization.slice(7);
        const username = token.split(':')[0];

        // Preveri, ali obstaja uporabnik v bazi
        pool.query(
            'SELECT usename FROM pg_user WHERE usename = $1',
            [username],
            (error, results) => {
                if (error) {
                    console.error(error);
                    res.status(500).json({ error: 'Napaka pri preverjanju uporabnika' });
                } else if (results.rows.length === 0) {
                    res.status(401).json({ error: 'Neveljavni uporabniški podatki' });
                } else {
                    // Shranite uporabniške podatke v zahtevo za nadaljnje uporabe
                    req.user = {
                        username,
                    };
                    if(req.originalUrl.includes(username.substring(0, username.length-1))) next();
                    else res.status(401).json({error: 'Not authorized'})
                }
            }
        );
    } else {
        res.status(401).json({ error: 'Manjkajoči uporabniški podatki' });
    }
}

// Endpoint za prijavo
app.post('/login', (req, res) => {
    const { username, password } = req.body;

    // Preveri, ali se uporabniško ime ujema z geslom
    if (username && password && password === '123455') {
        // Preveri, ali obstaja uporabnik v bazi
        pool.query(
            'SELECT usename FROM pg_user WHERE usename = $1',
            [username],
            (error, results) => {
                if (error) {
                    console.error(error);
                    res.status(500).json({ error: 'Napaka pri preverjanju uporabnika' });
                } else if (results.rows.length === 0) {
                    res.status(401).json({ error: 'Neveljavni uporabniški podatki' });
                } else {
                    // Vrnite JWT žeton za nadaljnjo avtentikacijo
                    const token = `Bearer ${username}:your_token`;
                    res.status(200).json({ token });
                }
            }
        );
    } else {
        res.status(401).json({ error: 'Neveljavni uporabniški podatki' });
    }
});

// Endpoint za dodajanje sestavin
app.post('/api/kuhar/sestavine', isAuthenticated, (req, res) => {
    const { ime, kolicina_zaloge, merska_enota } = req.body;

    // Vstavi novo sestavino v tabelo sestavine
    pool.query(
        'INSERT INTO sestavine (ime, kolicina_zaloge, merska_enota) VALUES ($1, $2, $3) RETURNING *',
        [ime, kolicina_zaloge, merska_enota],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri dodajanju sestavine' });
            } else {
                res.status(200).json(results.rows[0]);
            }
        }
    );
});

// Endpoint za pridobivanje vseh sestavin
app.get('/api/kuhar/sestavine', isAuthenticated, (req, res) => {
    // Pridobi vse sestavine iz tabele sestavine
    pool.query(
        'SELECT * FROM sestavine',
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri pridobivanju sestavin' });
            } else {
                res.status(200).json(results.rows);
            }
        }
    );
});

// Endpoint za posodabljanje sestavine
app.put('/api/kuhar/sestavine/:id', isAuthenticated, (req, res) => {
    const { id } = req.params;
    const { ime, kolicina_zaloge, merska_enota } = req.body;

    // Posodobi sestavino z določenim ID-jem
    pool.query(
        'UPDATE sestavine SET ime = $1, kolicina_zaloge = $2, merska_enota = $3 WHERE id_sestavine = $4 RETURNING *',
        [ime, kolicina_zaloge, merska_enota, id],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri posodabljanju sestavine' });
            } else if (results.rows.length === 0) {
                res.status(404).json({ error: 'Sestavina ni najdena' });
            } else {
                res.status(200).json(results.rows[0]);
            }
        }
    );
});

// Endpoint za brisanje sestavine
app.delete('/api/kuhar/sestavine/:id', isAuthenticated, (req, res) => {
    const { id } = req.params;

    // Izbriši sestavino z določenim ID-jem
    pool.query(
        'DELETE FROM sestavine WHERE id_sestavine = $1',
        [id],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri brisanju sestavine' });
            } else if (results.rowCount === 0) {
                res.status(404).json({ error: 'Sestavina ni najdena' });
            } else {
                res.status(204).send();
            }
        }
    );
});

// Endpoint za dodajanje napotnice
app.post('/api/zdravnik/napotnice', isAuthenticated, (req, res) => {
    const { diagnoza, id_zdravnika, id_pacienta, id_terapija } = req.body;

    // Vstavi novo napotnico v tabelo napotnice
    pool.query(
        'INSERT INTO napotnice (diagnoza, id_zdravnika, id_pacienta, id_terapija) VALUES ($1, $2, $3, $4) RETURNING *',
        [diagnoza, id_zdravnika, id_pacienta, id_terapija],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri dodajanju napotnice' });
            } else {
                res.status(200).json(results.rows[0]);
            }
        }
    );
});

// Endpoint za pridobivanje vseh napotnic
app.get('/api/zdravnik/napotnice', isAuthenticated, (req, res) => {
    // Pridobi vse napotnice iz tabele napotnice
    pool.query(
        'SELECT * FROM napotnice',
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri pridobivanju napotnic' });
            } else {
                res.status(200).json(results.rows);
            }
        }
    );
});

// Endpoint za brisanje napotnice
app.delete('/api/zdravnik/napotnice/:id', isAuthenticated, (req, res) => {
    const { id } = req.params;
    console.log('id napotnice ', {id})

    // Izbriši napotnico z določenim ID-jem
    pool.query(
        'DELETE FROM napotnice WHERE id_napotnica = $1',
        [id],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri brisanju napotnice' });
            } else if (results.rowCount === 0) {
                res.status(404).json({ error: 'Napotnica ni najdena' });
            } else {
                res.status(204).send();
            }
        }
    );
});

// Endpoint za pridobivanje vseh zdravnikov
app.get('/api/zdravnik/zdravniki', isAuthenticated, (req, res) => {
    // Pridobi vse zdravnike iz tabele zdravniki
    pool.query(
        'SELECT * FROM zdravniki',
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri pridobivanju zdravnikov' });
            } else {
                res.status(200).json(results.rows);
            }
        }
    );
});

// Endpoint za pridobivanje vseh pacientov
app.get('/api/zdravnik/pacienti', isAuthenticated, (req, res) => {
    // Pridobi vse paciente iz tabele pacienti
    pool.query(
        'SELECT * FROM pacienti',
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri pridobivanju pacientov' });
            } else {
                res.status(200).json(results.rows);
            }
        }
    );
});

// Endpoint za pridobivanje vseh terapij
app.get('/api/zdravnik/terapije', isAuthenticated, (req, res) => {
    // Pridobi vse terapije iz tabele terapije
    pool.query(
        'SELECT * FROM terapije',
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri pridobivanju terapij' });
            } else {
                res.status(200).json(results.rows);
            }
        }
    );
});

// Endpoint za dodajanje terapije
app.post('/api/zdravnik/terapije', isAuthenticated, (req, res) => {
    const { naziv, opis, trajanje } = req.body;

    // Vstavi novo terapijo v tabelo terapije
    pool.query(
        'INSERT INTO terapije (naziv, opis, trajanje) VALUES ($1, $2, $3) RETURNING *',
        [naziv, opis, trajanje],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri dodajanju terapije' });
            } else {
                res.status(200).json(results.rows[0]);
            }
        }
    );
});

// Endpoint za dodajanje pacienta
app.post('/api/zdravnik/pacienti', isAuthenticated, (req, res) => {
    const { st_zdr_kartice, id_osebe } = req.body;

    // Vstavi novega pacienta v tabelo pacienti
    pool.query(
        'INSERT INTO pacienti (st_zdr_kartice, id_osebe) VALUES ($1, $2) RETURNING *',
        [st_zdr_kartice, id_osebe],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri dodajanju pacienta' });
            } else {
                res.status(200).json(results.rows[0]);
            }
        }
    );
});

// Endpoint za pridobivanje jedi, ki ustrezajo pacientovi dieti
app.get('/api/pacient/jedi/:id', isAuthenticated, (req, res) => {
    const pacientId = req.params.id

    // Pridobi podatke o prehranskem listu pacienta
    pool.query(
        'SELECT id_dieta FROM prehranski_list WHERE id_pacienta = $1',
        [pacientId],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri pridobivanju prehranskega lista pacienta' });
            } else if (results.rows.length === 0) {
                res.status(200).json([]); // Pacient nima prehranskega lista, vrne prazno polje jedi
            } else {
                const dietaId = results.rows[0].id_dieta;

                // Pridobi jedi, ki ustrezajo pacientovi dieti
                pool.query(
                    'SELECT j.id_jedi, j.opis, j.cas_priprave FROM jedi j INNER JOIN jedi_diete jd ON j.id_jedi = jd.id_jedi WHERE jd.id_dieta = $1',
                    [dietaId],
                    (error, results) => {
                        if (error) {
                            console.error(error);
                            res.status(500).json({ error: 'Napaka pri pridobivanju jedi' });
                        } else {
                            res.status(200).json(results.rows);
                        }
                    }
                );
            }
        }
    );
});

// Endpoint za naročanje jedi
app.post('/api/pacient/narocila_obrokov', isAuthenticated, (req, res) => {
    const { id_pacienta, id_jedi, datum } = req.body;
    const id_pacient = parseInt(id_pacienta)
    // Preveri, ali jed ustrezaja pacientovi dieti
    pool.query(
        'SELECT jd.id_jedi FROM jedi_diete jd INNER JOIN prehranski_list pl ON jd.id_dieta = pl.id_dieta WHERE pl.id_pacienta = $1 AND jd.id_jedi = $2',
        [id_pacient, id_jedi],
        (error, results) => {
            if (error) {
                console.error(error);
                res.status(500).json({ error: 'Napaka pri preverjanju diete' });
            } else if (results.rows.length === 0) {
                res.status(400).json({ error: 'Jed ne ustreza pacientovi dieti' });
            } else {
                pool.query(
                    'INSERT INTO narocila_obrokov (id_pacienta, id_jedi, datum) VALUES ($1, $2, $3) RETURNING *',
                    [id_pacienta, id_jedi, datum],
                    (error, results) => {
                        if (error) {
                            console.error(error);
                            res.status(500).json({ error: 'Napaka pri naročanju jedi' });
                        } else {
                            res.status(200).json(results.rows[0]);
                        }
                    }
                );
            }
        }
    );
});


// Zagon strežnika
app.listen(6969, () => {
    console.log('Server listening on port 6969');
});
