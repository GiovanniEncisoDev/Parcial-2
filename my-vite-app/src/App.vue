<template>
  <!-- Este es el bloque del template donde definimos el HTML de nuestro componente -->
  <div id="app">
    <h1>{{ message }}</h1> <!-- Mostramos un mensaje desde el estado de Vue -->
    <button @click="changeMessage">Cambiar Mensaje</button> <!-- Botón que llama a la función changeMessage -->
  </div>
</template>

<script>
// Aquí definimos el código JavaScript y las funcionalidades del componente
export default {
  name: 'App',
  data() {
    return {
      message: 'Hola, Vite con Vue.js!' // Estado inicial con un mensaje
    }
  },
  methods: {
    // Método para cambiar el mensaje cuando se presiona el botón
    changeMessage() {
      this.message = '¡El mensaje ha cambiado!';
    }
  }
}
</script>

<!-- Estilos opcionales que se aplicarán a este componente -->
<style>
#app {
  text-align: center;
  margin-top: 50px;
}
button {
  padding: 10px;
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 5px;
}
button:hover {
  background-color: #2c8b73;
}
</style>
