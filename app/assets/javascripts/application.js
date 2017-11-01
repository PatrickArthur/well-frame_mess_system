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
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(document).on('blur','#care_givers', function() {
  $.get( "/search_caregivers", {val: this.value}, function( data ) {
    if (data.care_giver != null) {
      $(".searched_caregivers").after('<li>' + data.care_giver.email + '</li>');
      $('<input>').attr('type','hidden').attr('name','recipients[]').attr('value',data.care_giver.id).appendTo('form');
      $('#care_givers').val("");
    } else {
      $('.message_errors').html('<p>' + data.errors + '</p>');
    }
  });
});
