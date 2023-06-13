<template>
  <div>
    <h1>Kuhar</h1>

    <!-- Obrazec za dodajanje sestavin -->
    <h2>Dodajanje sestavin</h2>
    <form @submit.prevent="dodajSestavine">
      <label>
        Ime sestavine:
        <input type="text" v-model="novaSestavina.ime" required>
        Količina zaloge:
        <input type="text" v-model="novaSestavina.kolicina_zaloge" required>
        Merska enota:
        <input type="text" v-model="novaSestavina.merska_enota" required>
      </label>
      <button type="submit">Dodaj</button>
    </form>

    <!-- Tabela sestavin -->
    <h2>Sestavine</h2>
    <table style="margin-inline: 35% !important; display: block;">
      <thead>
      <tr>
        <th>Ime sestavine</th>
        <th>Količina</th>
        <th>Merska enota</th>
        <th>Uredi</th>
        <th>Izbriši</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="sestavina in sestavine" :key="sestavina.id">
        <td>{{ sestavina.ime }}</td>
        <td>{{ sestavina.kolicina_zaloge }}</td>
        <td>{{ sestavina.merska_enota }}</td>
        <td>
          <button @click="urediSestavino(sestavina)">Uredi</button>
        </td>
        <td>
          <button @click="izbrisiSestavino(sestavina)">Izbriši</button>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "KuharR",
  data() {
    return {
      novaSestavina: {},
      sestavine: [],
    };
  },
  methods: {
    dodajSestavine() {
      const data = {
        ime: this.novaSestavina.ime,
        kolicina_zaloge: this.novaSestavina.kolicina_zaloge,
        merska_enota: this.novaSestavina.merska_enota
      };
      axios.post('http://localhost:6969/api/kuhar/sestavine', data, {headers: {Authorization: localStorage.getItem('token')}})
          .then(() => {
            this.novaSestavina = "";
            this.pridobiSestavine();
          })
          .catch(error => {
            console.error(error);
          });
    },
    urediSestavino(sestavina) {
      const ime = prompt('Vnesite novo ime sestavine:', sestavina.ime);
      const kolicina_zaloge = prompt('Vnesite novo ime sestavine:', sestavina.kolicina_zaloge);
      const merska_enota = prompt('Vnesite novo ime sestavine:', sestavina.merska_enota);
      if (ime) {
        const data = {
          ime: ime,
          kolicina_zaloge: kolicina_zaloge,
          merska_enota: merska_enota,
        };
        axios.put(`http://localhost:6969/api/kuhar/sestavine/${sestavina.id_sestavine}`, data, { headers: { Authorization: localStorage.getItem('token') } })
            .then(() => {
              this.pridobiSestavine();
            })
            .catch(error => {
              console.error(error);
            });
      }
    },
    izbrisiSestavino(sestavina) {
      if (confirm('Ali ste prepričani, da želite izbrisati sestavino?')) {
        axios.delete(`http://localhost:6969/api/kuhar/sestavine/${sestavina.id_sestavine}`, { headers: { Authorization: localStorage.getItem('token') } })
            .then(() => {
              this.pridobiSestavine();
            })
            .catch(error => {
              console.error(error);
            });
      }
    },
    pridobiSestavine() {
      axios.get('http://localhost:6969/api/kuhar/sestavine', {headers: {Authorization: localStorage.getItem('token')}})
          .then(response => {
            this.sestavine = response.data;
          })
          .catch(error => {
            console.error(error);
          });
    },
  },
  mounted() {
    this.pridobiSestavine();
  },
};
</script>

<style scoped>
/* Stilizacija komponente */
</style>
