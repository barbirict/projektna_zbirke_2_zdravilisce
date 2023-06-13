<template>
  <div>
    <h1>Izberite uporabnika:</h1>
    <button @click="login('kuhar1')">Kuhar</button>
    <button @click="login('zdravnik1')">Zdravnik</button>
    <button @click="login('pacient2')">Pacient</button>
  </div>
</template>

<script>
import axios from 'axios';
import router from "@/router";
export default {
  name: 'HomeE',
  methods: {
    login(user) {
     // alert(user)
      axios
          .post('http://localhost:6969/login', { username: user, password: '123455' })
          .then(response => {
            //alert('tu')
            console.log(response.data);
            localStorage.setItem('token', response.data.token)
            // Preusmeritev na ustrezno funkcijo uporabnika
            switch (user) {
              case 'kuhar1':
                router.push('/kuhar');
                break;
              case 'zdravnik1':
                router.push('/zdravnik');
                break;
              case 'pacient2':
                router.push('/pacient');
                break;
            }
          })
          .catch(error => {
            console.log(error);
          });
    },
  },
};
</script>
