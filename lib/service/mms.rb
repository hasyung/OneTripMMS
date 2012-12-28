module Service
  class MMS
    @@client = Savon.client(wsdl: Setting.mms_url)
    
    def self.get_all_info
      response = @@client.call(:get_all_info, message: default_options)
      response.body[:get_all_info_response][:get_all_info_result]
    end
    
    def self.get_balance
      response = @@client.call(:get_balance, message: default_options)
      response.body[:get_balance_response][:get_balance_result].strip
    end
    
    def self.get_md5_balance(options = {})
      options[:password] ||= pwd
      response = @@client.call(:balance, message: default_options.merge!(options))
    end
    
    def self.send_mms(options = {})
      options[:password] ||= pwd
      response = @@client.call(:md_mms_send, message: default_options.merge!(options))
      response.body
    end
    
    private
    def self.default_options
      { sn: Setting.sn, password: Setting.password }
    end
    
    def self.pwd
      new_password = Setting.sn + Setting.password
      Digest::MD5.hexdigest(new_password).upcase
    end
  end
end