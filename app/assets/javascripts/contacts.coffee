# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#filter').on 'input', get_table

get_table = () ->
  console.log($(this).val())
  $.ajax
    url: '/ajax'
    method: 'POST'
    data: {fltr: $(this).val()}
    success: (data) ->
      $('#contacts_table').html data
      console.log data  