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
//= require rails.validations
//= require fancybox
//= require_tree .

$(document).ready(function() {
    $(function() {
        $('.datepicker').datepicker({
            dateFormat: 'yy-mm-dd'
        });
    });
    $(".form-control").change(function() {
        get_user_address_if_input_changed();
    });
});

function get_user_address_if_input_changed() {
    var user_country = $("#user_country").val();
    var user_city = $("#user_city").val();
    var user_address = $("#user_address").val();
    var full_user_address = user_country + " " + user_city + " " + user_address;
    $.ajax({
        url: "https://maps.googleapis.com/maps/api/geocode/json?address=" + full_user_address,
        type: "get",
        success: function(data) {
            var lat = data.results[0].geometry.location.lat;
            var lng = data.results[0].geometry.location.lng;
            initialize(lat, lng);
        },
        error: function() {
            console.log("Error");
        }
    });
};


var geocoder;
var map;
var marker;

function initialize(lat, lng) {
    if (lat === undefined || lng === undefined) {

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude;
                var lng = position.coords.longitude;
                var latlng = new google.maps.LatLng(lat, lng);
                var options = {
                    zoom: 18,
                    center: latlng,
                    mapTypeId: google.maps.MapTypeId.SATELLITE,
                    v: 3
                };
                map = new google.maps.Map(document.getElementById("map_canvas"), options);
                //Определение геокодера
                geocoder = new google.maps.Geocoder();
                marker = new google.maps.Marker({
                    map: map,
                    draggable: true
                });
            })
        }
    } else {
        //Определение карты
        var lat = lat;
        var lng = lng;
        var latlng = new google.maps.LatLng(lat, lng);
        var options = {
            zoom: 18,
            center: latlng,
            mapTypeId: google.maps.MapTypeId.SATELLITE,
            v: 3
        };
        map = new google.maps.Map(document.getElementById("map_canvas"), options);
        //Определение геокодера
        geocoder = new google.maps.Geocoder();
        marker = new google.maps.Marker({
            map: map,
            draggable: true
        });
        $("#map_label").html("Selected address");
    }
}

$(document).ready(function() {

    initialize();

    //Добавляем слушателя события обратного геокодирования для маркера при его перемещении
    google.maps.event.addListener(marker, 'drag', function() {
        geocoder.geocode({ 'latLng': marker.getPosition() }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                if (results[0]) {
                    $('#address').val(results[0].formatted_address);
                    $('#latitude').val(marker.getPosition().lat());
                    $('#longitude').val(marker.getPosition().lng());
                }
            }
        });
    });

});
