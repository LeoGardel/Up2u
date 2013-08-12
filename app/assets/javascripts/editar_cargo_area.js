function cargoAreaAlterada() {
  
  var area = document.getElementById("area_area_id").selectedIndex;
  var cargo = document.getElementById("cargo_cargo_id").selectedIndex;
  var areaOptions = document.getElementById("area_area_id").options;
  var cargoOptions = document.getElementById("cargo_cargo_id").options;

  chamadaAjax(areaOptions[area].text, cargoOptions[cargo].text);

}

function chamadaAjax(i, j) {

  $.ajax({
  url: 'atualizar_cargo_area',
  type: 'POST',
  dataType: 'json',
  data: {areaNome: i, cargoNome: j},
  })
  .done(function(dataReceived) {
    $('#cargo_area_nome').html(dataReceived["cargoAreaNome"]);
    $('#cargo_area_descr').html(dataReceived["cargoAreaDescr"]);
    $('#area_descr').html(dataReceived["areaDescr"]);
    $('#cargo_descr').html(dataReceived["cargoDescr"]);
  });

}