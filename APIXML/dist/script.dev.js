"use strict";

var solicitud = new XMLHttpRequest();

solicitud.onload = function () {
  var respuesta = JSON.parse(solicitud.response);
  var definicion = respuesta[0].meanings[0].definitions[0].definition;
  document.getElementById("resultado").innerHTML = "<p>Definici\xF3n: ".concat(definicion, "</p>");
};

solicitud.open("GET", "https://api.dictionaryapi.dev/api/v2/entries/en/house", true);
solicitud.send();