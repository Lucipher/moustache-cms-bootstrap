class Site
  include Mongoid::Document
  include Mongoid::Timestamps
  include Etherweb::Mongoid::MetaData
  
  attr_accessible :name, :subdomain, :meta_data
  
  field :name
  key :name
  field :subdomain
  field :default_domain
  field :domains, type: Array, default: []
  
  # -- Index ---------------------------------------
  index :domains
  
  # -- Associations ---------------------------------------
  has_many :pages 
  has_many :layouts
  has_many :media_files
  has_many :users
    
  # -- Validations ----------------------------------------
  validates :name,
            :presence => true,
            :uniqueness => true
  validates :subdomain,
            :presence => true,
            :uniqueness => true
            
  # -- Callbacks -----------------------------------------------
  before_save :add_subdomain_to_domains
  after_destroy :destroy_associated
            
  # -- Scopes ---------------------------------------
  scope :match_domain, lambda { |domain| { :any_in => { :domains => [*domain] }}}
  
 
  # -- Instance Methods ----------------------------------------
  def full_subdomain
    "#{self.subdomain}.#{self.default_domain}"
  end
  
  def add_subdomain_to_domains
    self.domains ||= []
    if self.subdomain_changed? || self.default_domain_changed?
      if self.subdomain_was.nil?
        self.domains << self.full_subdomain
      else
        domains.delete(old_domain) if domains.include?(old_domain)
        (self.domains << self.full_subdomain).uniq!
      end
    end
  end
  
  def add_full_subdomain(domain)
    (domains << domain).uniq!
  end
  
  private
  
    def old_domain
      "#{self.subdomain_was}.#{self.default_domain_was}"
    end
    
    def destroy_associated
      destroy_pages
      destroy_users
      destroy_layouts
      destroy_media_files
    end
  
    def destroy_pages
      self.pages.destroy
    end
  
    def destroy_users
      self.users.destroy
    end
  
    def destroy_layouts
      self.layouts.destroy
    end
    
    def destroy_media_files
      self.media_files.destroy
    end
end