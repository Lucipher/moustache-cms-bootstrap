class CmsSiteController < ApplicationController
  
  before_filter :load_page, :only => :render_html
  layout nil
  
  def render_html
    if !@page.nil? && (@page.published? || current_admin_user)
      render :text => HandlebarCms::Mustache::CmsPage.new(self).render, :status => 200
    else
      render_404
    end
  end
  
  private
  
    def load_page
      @page = @current_site.page_by_full_path("/#{params[:page_path]}")
      if @page.nil?
        render_404
      end
    end
    
    def render_404
      if @page = @current_site.page_by_full_path("404")
        render :text => HandlebarCms::Mustache::CmsPage.new(self).render, :status => 404
      else 
        render :file => "#{Rails.root}/public/404.html", :status => 404
      end
    end

end
