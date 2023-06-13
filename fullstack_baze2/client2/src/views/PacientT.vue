<template>
  <div>
    <h1>Pacient</h1>

    <!-- Tabela jedi za naročanje -->
    <h2>Naročanje jedi za dan {{new Date(jutri()).toISOString().split('T', 1)[0]}}</h2>
    <table style="margin-inline: 37% !important; display: block;">
      <thead>
      <tr>
        <th>Opis</th>
        <th>Čas priprave</th>
        <th>Naroči</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="jed in jedi" :key="jed.id_jedi">
        <td>{{ jed.opis }}</td>
        <td>{{ jed.cas_priprave }}</td>
        <td>
          <button @click="narociJed(jed)">Naroči</button>
        </td>
      </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "PacientT",
  data() {
    return {
      jedi: [],
    };
  },
  methods: {
    jutri(){
      let date = new Date();
      return date.setDate(date.getDate() + 1);

    },
    getToken(){
      return localStorage.getItem('token').match(/\d+/)[0]
    },
    narociJed(jed) {
      if(!localStorage.getItem('pacientNarocilo')) localStorage.setItem('pacientNarocilo', JSON.stringify({pacientId:'-1', datum: '01-01-1970'}));
      if(JSON.parse(localStorage.getItem('pacientNarocilo')).pacientId === this.getToken() && JSON.parse(localStorage.getItem('pacientNarocilo')).datum === new Date(this.jutri()).toISOString().split('T', 1)[0]){
        alert('Si že naročo za jutri!');
        return
      }
      const data = {
        id_pacienta: this.getToken(),
        id_jedi: jed.id_jedi,
        datum: new Date(this.jutri()).toISOString().split('T', 1)[0], // Datum naročila
      };
      axios
          .post('http://localhost:6969/api/pacient/narocila_obrokov', data, {
            headers: { Authorization: localStorage.getItem('token') },
          })
          .then(() => {
            // Uspešno naročilo
            console.log('Jed uspešno naročena');
            localStorage.setItem('pacientNarocilo', JSON.stringify({pacientId: data.id_pacienta, datum: data.datum}));
          })
          .catch((error) => {
            console.error(error);
          });
    },
    pridobiJedi() {
      axios
          .get('http://localhost:6969/api/pacient/jedi/' + this.getToken(), {
            headers: { Authorization: localStorage.getItem('token') },
          })
          .then((response) => {
            this.jedi = response.data;
          })
          .catch((error) => {
            console.error(error);
          });
    },
  },
  mounted() {
    this.pridobiJedi();
  },
};
</script>

<style scoped>
/* Stilizacija komponente */
</style>
