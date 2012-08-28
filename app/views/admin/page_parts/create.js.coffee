$('.tab-content .tab-pane').last().after('<%= escape_javascript(render :partial => "page_part", :locals => { :index => (@page.page_parts.size - 1) } ) %>')

$('.nav-tabs .tab').removeClass('active')
$('.tab-content .tab-pane').hide().removeClass('active')
$('.tab-content #<%= @page_part.id %>').show().addClass('active')

# add to page part nav and make it the selected tab
$('#page_parts_nav .tab').last().after('<%= escape_javascript(render :partial => "page_part_nav") %>')

$('.delete_page_part').html('<%= delete_page_part %>')

if $('#view').length > 0
  $('#view').attr 'value', '<%= @page_part.id %>'

editor = new MoustacheEditor elementId: '<%= @page_part.id %>_content', filter: $('.page_parts select').last().val()
MoustacheEditor.editors.push editor
