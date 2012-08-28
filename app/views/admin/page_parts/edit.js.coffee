if $('#view').length > 0
  $('#view').attr 'value', '<%= @selected_page_part.id %>'


if $('#page_parts_nav').length > 0
  $('.tab-content .active').hide().removeClass('active')
  $('.tab-content #<%= @selected_page_part.id %>').show().addClass('active')

  $('.delete_page_part').html('<%= delete_page_part %>')

