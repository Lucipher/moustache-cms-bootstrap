if $('#add_domain').length
  $('#add_domain').before('<%= escape_javascript(render(:partial => 'admin/domain_names/domain')) %>').fadeIn()

