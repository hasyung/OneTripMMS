class Place < ActiveRecord::Base
  extend FriendlyId
  
  attr_accessible :description, :name, :slug, :return_code
  
  has_many :frames, :dependent => :destroy
  
  friendly_id :return_code, :use => :slugged
  
  validates :name, :return_code, :slug, :presence => true
  
  validates :name, :length => { :within => 2..30 }
  validates :name, :uniqueness => true
  
  validates :return_code, :length => { :within => 2..10 }
  validates :return_code, :format => { :with => /^[A-Za-z]+$/ }
  validates :return_code, :uniqueness => true
  
  validates :slug, :length => { :within => 2..10 }
  validates :slug, :format => { :with => /^[A-Za-z]+$/ }
  validates :slug, :uniqueness => true
  
  validates :description, :length => { :within => 0..100 }
  
  def mms_content
    content = ""
    frames.number_asc.each_with_index do |f, i|
      content << "#{i + 1}_1.txt,#{f.content};"
      content << "#{i + 1}_2.#{f.image_ext},#{f.image_base64};"
    end
    content.chop
  end
  
end
