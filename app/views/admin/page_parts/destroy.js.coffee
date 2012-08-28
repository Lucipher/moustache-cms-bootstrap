pagePartId = '#' + '<%= @page_part.id %>'
pagePartNavId = '#' + '<%= @page_part.id %>' + '_nav'

if $(pagePartId).length
  $(pagePartId).fadeToggle 'slow', 'linear', ->
    $(this).remove()
  
  $(pagePartNavId).fadeToggle 'slow', 'linear', ->
    $(this).remove()
    $('#page_parts_nav .tab').last().addClass('active')
    $('#page_parts_wrapper .tab-pane').last().addClass('active hidden').show()
    $('.delete_page_part').html('<%= delete_page_part %>')


if $('#view').length > 0
  $('#view').attr 'value', '<%= @selected_page_part.id %>'


$('.tab a').last().bind 'ajax:beforeSend', ->
  $('.page_parts div.spinner_wrapper .spinner').removeClass('hidden')
