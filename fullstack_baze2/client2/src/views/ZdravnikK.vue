<template>
  <div>
    <h1>Zdravnik</h1>

    <!-- Obrazec za dodajanje napotnic -->
    <h2>Dodajanje napotnic</h2>
    <form @submit.prevent="dodajNapotnico">
      <label>
        Diagnoza:
        <input type="text" v-model="novaDiagnoza" required>
      </label>
      <label>
        Zdravnik:
        <select v-model="izbranZdravnik" required>
          <option v-for="zdravnik in zdravniki" :key="zdravnik.id" :value="zdravnik.id_zdravnika">{{ zdravnik.specializacija }}</option>
        </select>
      </label>
      <label>
        Pacient:
        <select v-model="izbranPacient" required>
          <option v-for="pacient in pacienti" :key="pacient.id_pacienta" :value="pacient.id_pacienta">{{ pacient.st_zdr_kartice }}</option>
        </select>
      </label>
      <label>
        Terapija:
        <select v-model="izbranaTerapija" required>
          <option v-for="terapija in terapije" :key="terapija.id_terapija" :value="terapija.id_terapija">{{ terapija.naziv }}</option>
        </select>
      </label>
      <button type="submit">Dodaj</button>
    </form>

    <!-- Tabela napotnic -->
    <h2>Napotnice</h2>
    <table style="margin-inline: 35% !important; display: block;">
      <thead>
      <tr>
        <th>Diagnoza</th>
        <th>Zdravnik</th>
        <th>Pacient</th>
        <th>Terapija</th>
        <th>Izbriši</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="napotnica in napotnice" :key="napotnica.id_napotnica">
        <td>{{ napotnica.diagnoza }}</td>
        <td>{{ zdravniki.find(zdravnik => zdravnik.id_zdravnika === napotnica.id_zdravnika)?.specializacija }}</td>
        <td>{{ pacienti.find(pacient => pacient.id_pacienta === napotnica.id_pacienta)?.st_zdr_kartice }}</td>
        <td>{{ terapije.find(terapija => terapija.id_terapija === napotnica.id_terapija)?.naziv }}</td>
        <td>
          <button @click="izbrisiNapotnico(napotnica)">Izbriši</button>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "ZdravnikR",
  data() {
    return {
      novaDiagnoza: "",
      izbranZdravnik: null,
      izbranPacient: null,
      izbranaTerapija: null,
      napotnice: [],
      zdravniki: [],
      pacienti: [],
      terapije: [],
    };
  },
  methods: {
    dodajNapotnico() {
      const data = {
        diagnoza: this.novaDiagnoza,
        id_zdravnika: this.izbranZdravnik,
        id_pacienta: this.izbranPacient,
        id_terapija: this.izbranaTerapija,
      };
      axios.post('http://localhost:6969/api/zdravnik/napotnice', data, {headers: {Authorization: localStorage.getItem('token')}})
          .then(() => {
            this.novaDiagnoza = "";
            this.izbranZdravnik = null;
            this.izbranPacient = null;
            this.izbranaTerapija = null;
            this.pridobiNapotnice();
          })
          .catch(error => {
            console.error(error);
          });
    },
    izbrisiNapotnico(napotnica) {
      if (confirm('Ali ste prepričani, da želite izbrisati napotnico?')) {
        axios.delete(`http://localhost:6969/api/zdravnik/napotnice/${napotnica.id_napotnica}`, { headers: { Authorization: localStorage.getItem('token') } })
            .then(() => {
              this.pridobiNapotnice();
            })
            .catch(error => {
              console.error(error);
            });
      }
    },
    pridobiNapotnice() {
      axios.get('http://localhost:6969/api/zdravnik/napotnice', { headers: { Authorization: localStorage.getItem('token') } })
          .then(response => {
            this.napotnice = response.data;
          })
          .catch(error => {
            console.error(error);
          });
    },
    pridobiZdravnike() {
      axios.get('http://localhost:6969/api/zdravnik/zdravniki', { headers: { Authorization: localStorage.getItem('token') } })
          .then(response => {
            this.zdravniki = response.data;
          })
          .catch(error => {
            console.error(error);
          });
    },
    pridobiPaciente() {
      axios.get('http://localhost:6969/api/zdravnik/pacienti', { headers: { Authorization: localStorage.getItem('token') } })
          .then(response => {
            this.pacienti = response.data;
          })
          .catch(error => {
            console.error(error);
          });
    },
    pridobiTerapije() {
      axios.get('http://localhost:6969/api/zdravnik/terapije', { headers: { Authorization: localStorage.getItem('token') } })
          .then(response => {
            this.terapije = response.data;
          })
          .catch(error => {
            console.error(error);
          });
    },
  },
  mounted() {
    this.pridobiNapotnice();
    this.pridobiZdravnike();
    this.pridobiPaciente();
    this.pridobiTerapije();
  },
};
</script>

<style scoped>
/* Stilizacija komponente */
</style>
