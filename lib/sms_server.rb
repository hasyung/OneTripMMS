class SmsServer
  @@sms_client = Savon.client(wsdl: Setting.sms_url)
  
  def self.sms_send(mobile, content)
    begin
      @@sms_client.call(:SendSMS, message: { :sn => Setting.sn, :pwd => Setting.password, :mobile => mobile, :content => content })
    end
  end
  
  def self.sms_receive
    begin
      @@sms_client.call(:RECSMS, message: { :sn => Setting.sn, :pwd => Setting.password })
    end
  end
  
end