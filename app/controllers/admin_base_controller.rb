class AdminBaseController < ApplicationController
  protect_from_forgery   

  force_ssl if Rails.env == 'production'
    
  before_filter :authenticate_admin_user!
  after_filter :discard_flash_message

  check_authorization :unless => :devise_controller? 
  
  layout "admin/admin"
  
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}" 
    render :file => "#{Rails.root}/public/403", :status => 403, :layout => false
  end
  
  protected 
      
    def admin?     
      current_admin_user.role?("admin")
    end

    def created_updated_by_for(obj)
      obj.created_by_id = current_admin_user.id
      obj.updated_by_id = current_admin_user.id
    end
  
    def logout
      reset_session
      cookies.to_hash.each_key do |k| 
        cookies.delete(k.to_sym)
      end
    end

    def discard_flash_message
      if request.xhr? && response != :found
        flash.discard(:notice)
      end
    end

    
  private

    def redirector_path(object)
     params[:commit] == "Save and Continue Editing" ? [:edit, :admin, object] : [:admin, object.class.name.tableize.to_sym]
    end
    
    def redirector(path_continue, path_redirect, notice=nil)
      if params[:commit] == "Save and Continue Editing"
        redirect_to path_continue, :notice => notice
      else
        redirect_to path_redirect, :notice => notice
      end
    end

    def creator_updator_set_id(site_asset)
      site_asset.creator_id = current_admin_user.id
      site_asset.updator_id = current_admin_user.id
    end
end
