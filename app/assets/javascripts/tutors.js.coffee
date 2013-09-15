# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', 'form .remove_fields', (event) ->
  # Needs closest because remove link is within fieldset
  # so we need to go up the DOM tree.
  if $(@).closest('fieldset').siblings('fieldset').length > 0
    $(@).prev('input[type=hidden]').val('1')
    $(@).closest('fieldset').fadeOut().remove('fieldset')
  event.preventDefault()

# If having problems with css selectors try using this version instead:
#$(document).on 'click', 'form .remove_fields', (event) ->
# $('input[name$="[_destroy]"]', $(this).siblings()).val('1')
# $(this).closest('fieldset').hide()
# event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  # Doesn't need closest method since the add field link
  # sits outside the fieldset.
  console.log($(@).siblings('fieldset'))
  if $(@).siblings('fieldset').length < 7
    time = new Date().getTime()
    regexp = new RegExp($(@).data('id'), 'g')
    fieldset = $($(@).data('fields').replace(regexp, time)).hide()
    $(@).before(fieldset)
    fieldset.fadeIn()
  event.preventDefault()