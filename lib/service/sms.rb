module Service
  class SMS
    @@client = Savon.client(wsdl: Setting.web_service.sms_url)
    
    def self.receive_sms
      options = { pwd: pwd }
      response = @@client.call(:mo, message: default_options.merge!(options))
      response.body[:mo_response][:mo_result]
    end
    
    private
    def self.default_options
      { sn: Setting.web_service.sn, password: Setting.web_service.pwd }
    end
    
    def self.pwd
      new_password = Setting.web_service.sn + Setting.web_service.pwd
      Digest::MD5.hexdigest(new_password).upcase
    end
  end
end