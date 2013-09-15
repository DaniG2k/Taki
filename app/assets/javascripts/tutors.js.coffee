# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', 'form .remove_fields', (event) ->
  if $(@).closest('fieldset').siblings('fieldset').length > 0
    $(@).prev('input[type=hidden]').val('1')
    $(@).closest('fieldset').hide()
  event.preventDefault()

# If having problems with css selectors try using this version instead:
#$(document).on 'click', 'form .remove_fields', (event) ->
# $('input[name$="[_destroy]"]', $(this).siblings()).val('1')
# $(this).closest('fieldset').hide()
# event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  if $(@).siblings('fieldset').length <= 5
    time = new Date().getTime()
    regexp = new RegExp($(@).data('id'), 'g')
    $(@).before($(@).data('fields').replace(regexp, time))
  event.preventDefault()