# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#user_birthday').datepicker({
    changeMonth: true,
    changeYear: true,
    minDate: "-90Y",
    maxDate: 0,
    yearRange: "-60:-15",
    dateFormat: "yy-mm-dd"
    })