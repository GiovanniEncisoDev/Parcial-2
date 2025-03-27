"use strict";

var fs = require('fs');

var path = require('path'); //console.log(__dirname)
//console.log(__filename)


var ruta = path.join(__dirname, '_Presidentes.json'); // Une las partes de la ruta para formar una sola
//console.log(ruta);

var cadenaTxt = fs.readFileSync(ruta, 'utf-8'); // Lee el archivo y lo convierte en una cadena de texto

var ObjetoJs = JSON.parse(cadenaTxt); // Convierte la cadena de texto en un objeto de JavaScript
// Recorremos la lista de presidentes con dos ciclos anidados

ObjetoJs.forEach(function (presidente) {
  // Recorremos la lista de presidentes
  for (var clave in presidente) {
    // Recorremos las propiedades de cada presidente
    if (clave === "nombre" || clave === "lugar_nacimiento") {
      // Solo mostramos el nombre y lugar de nacimiento
      console.log("".concat(clave, ": ").concat(presidente[clave])); // Mostramos la clave y el valor de la propiedad
    }
  }

  console.log("-----------------"); // Separador entre cada uno
});