class Frame < ActiveRecord::Base
  attr_accessible :body, :content, :number
  
  belongs_to :place, :counter_cache => true, :dependent => :destroy
end
