HandlebarCms::Application.routes.draw do   

  namespace :admin do
    devise_for :users, :path => '', :controllers => { :sessions => 'admin/sessions', :passwords => 'admin/passwords' } 

    resources :users, do
      member do
        get :change_password
      end
    end
    resources :layouts

    resources :pages do 
      put :sort, :on => :member
      get :new_meta_tag, :on => :collection
      get :new_custom_field, :on => :collection
      resources :meta_tags, :except => [:index, :show] 
      resources :custom_fields, :except => [:index, :show]
      resources :page_parts, :only => [:show, :create, :destroy]
    end

    resources :authors

    resources :article_collections do
      resources :articles do
        get :new_meta_tag, :on => :collection
        resources :meta_tags, :except => [:index, :show] 
      end
    end

    match 'articles/new_meta_tag' => 'articles#new_meta_tag', :as => 'articles_new_meta_tag'

    resources :theme_collections do
      resources :theme_assets do 
        resources :tag_attrs
      end
    end

    resources :snippets 

    resources :asset_collections do
      resources :site_assets
    end

    resources :sites, :path => 'current_site', :controller => 'current_site', :except => [:index] do
      resources :meta_tags, :except => :index 
      resources :domain_names, :except => [:index, :show]
    end
    
  end

  match "/admin" => redirect("/admin/pages")

  scope :controller => "cms_site" do
    get "/" => :render_html, :as => "cms_html", :path => '(*page_path)'
  end

  root :to => 'admin/pages#index'

end
