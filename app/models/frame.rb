class Frame < ActiveRecord::Base
  attr_accessible :body, :content, :number, :place_id, :image, :image_cache
  
  before_save :update_content_attribute, :update_image_attribute
  
  belongs_to :place, :counter_cache => true
  
  validates :number, :body, :place_id, :image, :presence => true
  
  validates :number, :numericality => { :only_integer => true, :greater_than_or_equal_to => 1 }
  validates :number, :uniqueness => { :scope => :place_id }
  
  validates :body, :length => { :within => 0..10000 }
  
  mount_uploader :image, ImageUploader
  
  scope :number_asc, order("number ASC")
  
  def mms_content
    "#{self.number}_1.txt,#{content};"
  end
  
  def mms_image
    "#{self.number}_2.#{image_ext},#{image_base64};"
  end
  
  private
  def update_content_attribute
    if body.present? && body_changed?
      self.content = Base64.encode64 self.body.encode("gb2312")
    end
  end
  
  def update_image_attribute
    if image.present? && image_changed?
      self.image_base64 = Base64.encode64(open(image.path) { |io| io.read })
      self.image_content_type = MIME::Types.type_for(image.file.original_filename).first.to_s
      self.image_size = image.file.size
      self.image_ext = image.file.extension
    end
  end
end
