class Place < ActiveRecord::Base
  extend FriendlyId
  
  attr_accessible :description, :name, :slug, :return_code, :title
  
  before_save :update_return_code_attribute
  
  has_many :frames, :dependent => :destroy
  
  friendly_id :return_code, :use => :slugged
  
  validates :name, :return_code, :slug, :title, :presence => true
  
  validates :name, :length => { :within => 2..30 }
  validates :name, :uniqueness => true
  
  validates :title, :length => { :within => 2..30 }
  
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
  
  def self.receive_sms
    result = Service::SMS.receive_sms
    if result.to_i > 1
      Service::SMS.receive_log result.split("\n").to_s
      result.split("\n").group_by { |item| item.split(",")[3] }.each do |key, value|
        phones = []
        value.map { |v| phones << v.split(",")[2] }
        place = Place.find_by_return_code(key.downcase)
        if !place.blank?
          send_result = Service::MMS.send_mms(:title => place.title, 
                                              :content => place.mms_content, 
                                              :mobile => phones.join(","), 
                                              :stime => "")
          if send_result > 1
            Service::MMS.send_log "phones: #{phones.join(",")}, title: #{place.title}, state: success"
          else
            Service::MMS.send_log "phones: #{phones.join(",")}, title: #{place.title}, state: fail - #{send_result}"
          end
        else
          Service::MMS.send_log "phones: #{phones.join(",")}, key: #{key}, state: #{t('messages.tests.error.f_1')}"
        end
      end
    end
  end
  
  private
  def update_return_code_attribute
    if self.return_code.present?
      self.return_code = self.return_code.downcase
    end
  end
  
end
