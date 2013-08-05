# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
user_birthday = ->
  $('#user_birthday').datepicker({
    changeMonth: true,
    changeYear: true,
    minDate: "-90Y",
    maxDate: 0,
    yearRange: "-60:-15",
    dateFormat: "yy-mm-dd"
    })
    
$(document).ready(user_birthday)
$(document).on('page:load', user_birthday)

