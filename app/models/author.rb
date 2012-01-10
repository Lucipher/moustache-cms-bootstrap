class Author
  include Mongoid::Document 
  include Mongoid::Timestamps

  attr_accessible :prefix,
                  :firstname,
                  :middlename,
                  :lastname,
                  :image,
                  :profile

  # -- Fields ------
  field :prefix
  field :firstname
  field :middlename
  field :lastname
  field :profile
  field :filename_md5
  field :file_path_md5
  field :file_path_md5_old
  field :url_md5
  mount_uploader :image, AuthorUploader

  # -- Associations ---
  belongs_to :site
  belongs_to :created_by, :class_name => "User"
  belongs_to :updated_by, :class_name => "User"
  has_and_belongs_to_many :articles

  # -- Callbacks ---
  before_save :strip_whitespace, :calc_md5

  def full_name
    if self.middlename.empty?
      self.firstname.capitalize + ' ' + self.lastname.capitalize
    else
      self.firstname.capitalize + ' ' + self.middlename.capitalize + ' ' + self.lastname.capitalize
    end
  end

  def calc_md5
    if self.new_record?
      chunk = self.image.read
      md5 = ::Digest::MD5.hexdigest(chunk)
      self.filename_md5 = "#{self.image.filename.split('.').first}-#{md5}.#{self.image.file.extension}"
      self.file_path_md5 = File.join(Rails.root, 'public', self.image.store_dir, '/', self.filename_md5)
      self.url_md5 = "/#{self.image.store_dir}/#{self.filename_md5}"
      FileUtils.mkdir_p File.join(Rails.root, 'public', self.image.store_dir)
      File.open(self.file_path_md5, 'wb') { |f| f.write(chunk) }
    end
  end


  def articles
    collection = ArticleCollection.where(:site_id => site.id)
    articles = []
    collection.each do |ac|
      ac.articles.each do |article|
        art = article.where(:article_ids => self.id).first
        unless art.nil? 
          articles << art
        end
      end
    end
    articles  
  end

  private 
    def strip_whitespace
      self.firstname.strip!
      self.middlename.strip!
      self.lastname.strip!
    end
end