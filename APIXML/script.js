let solicitud = new XMLHttpRequest();
solicitud.onload = function(){
  let respuesta = JSON.parse(solicitud.response);
  let definicion = respuesta[0].meanings[0].definitions[0].definition;
  document.getElementById("resultado").innerHTML = `<p>Definición: ${definicion}</p>`;
}

solicitud.open("GET", "https://api.dictionaryapi.dev/api/v2/entries/en/house", true);
solicitud.send();
