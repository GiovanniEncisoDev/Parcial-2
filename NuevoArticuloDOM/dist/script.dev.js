"use strict";

// Acceder al botón y agregar un evento de clic
document.getElementById('changeContentButton').addEventListener('click', function () {
  // Cambiar el texto del párrafo
  document.getElementById('infoText').innerHTML = 'El término bloatware se refiere a software que consume recursos excesivos, incluso para tareas simples.'; // Cambiar la imagen al hacer clic

  document.getElementById('bloatwareImage').src = '/NuevoArticuloDOM/Que es.jpg'; // Cambia esto por la ruta de otra imagen
});