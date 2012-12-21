class Place < ActiveRecord::Base
  extend FriendlyId
  
  attr_accessible :description, :name
  
  has_many :frames
  
  friendly_id :name, :use => :slugged
end
