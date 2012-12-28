module Service
  class MMS
    @@url = "http://sdk3.entinfo.cn:8060/webservice.asmx?WSDL"
    @@client = Savon.client(wsdl: @@url)
    
    def self.get_all_info
      response = @@client.call(:get_all_info, message: default_options)
      response.body[:get_all_info_response][:get_all_info_result]
    end
    
    def self.get_balance
      response = @@client.call(:get_balance, message: default_options)
      response.body[:get_balance_response][:get_balance_result].strip
    end
    
    def self.get_md5_balance(options = {})
      options[:pwd] ||= md5_pwd
      response = @@client.call(:balance, message: default_options.merge!(options))
    end
    
    def self.send_mms(options = {})
      options[:pwd] ||= md5_pwd
      response = @@client.call(:md_mms_send, message: default_options.merge!(options))
      response.body
    end
    
    private
    def self.default_options
      { sn: Setting.web_service.sn, pwd: Setting.web_service.pwd }
    end
    
    def self.md5_pwd
      new_pwd = Setting.web_service.sn + Setting.web_service.pwd
      Digest::MD5.hexdigest(new_pwd).upcase
    end
  end
end