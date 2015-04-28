# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Contact
  constructor: (id, first_name, last_name, email, company,
    region, is_broker, is_charterer, is_owner, size, enabled) ->

get_contact_from_table = (t, offset) ->
  return t.children().eq(offset).children().val()

is_checked = (t, offset) ->
  return t.children().eq(offset).children().is(":checked")

get_table = () ->
  if ($('#filter').length == 0)
    return
  console.log($('#filter').val())
  $.ajax
    url: '/ajax'
    method: 'POST'
    data: {fltr: $('#filter').val()}
    success: (data) ->
      $('#contacts_table').html data
      $('.upd_con').click upd_button_clicked
      $('.edt_con').click edt_button_clicked

edt_button_clicked = () ->
  t = $(this).parent().parent()
  id = t.closest('tr').attr('id')
  window.location.href = "/contacts/" + id + "/edit"

upd_button_clicked = () ->
  t = $(this).parent().parent()
  c = new Contact
  c.id = t.closest('tr').attr('id')
  c.first_name = get_contact_from_table(t, 0)
  c.last_name = get_contact_from_table(t, 1)
  c.company = get_contact_from_table(t,2)
  c.email = get_contact_from_table(t, 3)
  c.is_broker = is_checked(t, 4)
  c.is_charterer = is_checked(t, 5)
  c.is_owner = is_checked(t, 6)
  c.region = get_contact_from_table(t, 7)
  c.size = get_contact_from_table(t, 8)
  c.enabled = is_checked(t, 9)
  console.log(c)
  $.ajax
    url: '/upd_cont'
    method: 'POST'
    data: {contact: c}
    success: (data) ->
      console.log(data)
    error: (data) ->
      console.log(data)

$ ->
  get_table()
  $('#filter').on 'input', get_table
