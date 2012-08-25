jQuery ->
  $(document).ready ->
    if $('form#new_site_asset .accordion-inner').length
      site_asset = $('form#new_site_asset').attr('action')
      site_asset_new = $('form#new_site_asset').attr('action') + '/new'
      $('form#new_site_asset #submit_fields').html('<a href=' + site_asset + ' class="cancel">« back to collection</a><a href=' + site_asset_new + ' class="cancel btn btn-mini btn-warning pull-right">reset form</a></li>')

      $("div#uploader").pluploadQueue
        runtimes: "html5"
        url:  $('form#new_site_asset').attr('action')
        rename: true
        multipart: true
        multipart_params:
          authenticity_token: $('input[name=authenticity_token]').val()
