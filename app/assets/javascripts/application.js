// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation

function autocompleteCity(objeto, position) {
  if (typeof position === 'undefined') { position = new google.maps.LatLng(0, 0); }

  var map = showMap(position, false);
  var input = document.getElementById(objeto + '_city');
  var options = {
    types: ['(cities)']
  };

  var marker = new google.maps.Marker({
    animation: google.maps.Animation.DROP,
    position: position,
    map: map,
    draggable: true
  });

  $('#map-canvas').click(function(){
    document.getElementById(objeto + '_latitude').value = marker.getPosition().lat();
    document.getElementById(objeto + '_longitude').value = marker.getPosition().lng();
  });

  var autocomplete = new google.maps.places.Autocomplete(input, options);
  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var city = autocomplete.getPlace();
    document.getElementById(objeto + '_latitude').value = city.geometry.location.lat();
    document.getElementById(objeto + '_longitude').value = city.geometry.location.lng();

    // Centraliza o marcador e o mapa de acordo com a city escolhida no autocomplete se houver um mapa e marcador
    if (map && marker){
      map.setCenter(new google.maps.LatLng(city.geometry.location.lat(), city.geometry.location.lng()));
      marker.setPosition(new google.maps.LatLng(city.geometry.location.lat(), city.geometry.location.lng()));
    }
  });
}

function showMap(position, showMarker){
  var mapOptions = {
    center: position,
    zoom: 14,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map($('#map-canvas')[0] ,mapOptions);

  if (typeof showMarker === 'undefined') {
    marker = new google.maps.Marker({
      animation: google.maps.Animation.DROP,
      position: position,
      map: map
    });
  }

  return map;
}

$(function(){ $(document).foundation(); });
