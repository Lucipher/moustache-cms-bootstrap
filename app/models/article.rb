class Article 
  include Mongoid::Document 
  include Mongoid::Timestamps

  include Mongoid::TaggableWithContext

  attr_accessible :title,
                  :permalink,
                  :slug,
                  :content,
                  :current_state, 
                  :current_state_attributes,
                  :filter_name,
                  :authors,
                  :layout_id,
                  :tags

  # -- Fields -----------
  field :title
  field :permalink
  field :slug
  field :content
  field :filter_name
  field :authors, :type => Array
  field :creator_id
  field :updator_id
  field :layout_id

  taggable

  # -- Associations -------------
  embeds_one :current_state, :as => :publishable
  embeds_many :meta_tags, :as => :meta_taggable
  embedded_in :article_collection

    # -- Validations -----------------------------------------------
  validates :title,
            :presence => true,
            :uniqueness => { :case_sensitive => false, :scope => :article_collection }
            
  validates :permalink,
            :presence => true,
            :uniqueness => { :case_sensitive => false, :scope => :article_collection }

  validates :slug,
            :presence => true

  validates :creator_id,
            :presence => true

  validates :updator_id,
            :presence => true

  validates :filter_name,
            :presence => true

  # -- Callbacks ----------
  before_validation :format_title, :slug_set, :permalink_set

  alias :full_path :permalink
  alias :full_path= :permalink=

  def permalink_set
    time = DateTime.now
    year = time.year.to_s
    month = time.month.to_s
    day = time.day.to_s
    self.permalink = "/#{self._parent.name}/#{year}/#{month}/#{day}/#{self.slug}"
  end

  private 
    def format_title
      self.title.strip! unless self.title.nil?
    end
    
    def slug_set
      if slug.blank? 
        self.slug = self.title.downcase
      else
        self.slug.downcase!
        self.slug.strip!
      end
      self.slug.gsub!(/[\s_]/, '-')
    end
end