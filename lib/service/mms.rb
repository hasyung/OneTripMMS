module Service
  class MMS
    @@client = Savon.client(wsdl: Setting.web_service.mms_url)
    
    def self.get_all_info
      response = @@client.call(:get_all_info, message: default_options)
      response.body[:get_all_info_response][:get_all_info_result]
    end
    
    def self.get_balance
      response = @@client.call(:get_balance, message: default_options)
      response.body[:get_balance_response][:get_balance_result].strip
    end
    
    def self.get_md5_balance(options = {})
      options[:pwd] ||= pwd
      response = @@client.call(:balance, message: default_options.merge!(options))
    end
    
    def self.send_mms(options = {})
      options[:pwd] ||= pwd
      options[:stime] ||= ""
      response = @@client.call(:md_mms_send, message: default_options.merge!(options))
      response.body[:md_mms_send_response][:md_mms_send_result].to_i
    end
    
    def self.send_log(message)
      file = File.open(File.expand_path("public/send.log", Rails.root), File::WRONLY | File::APPEND | File::CREAT)
      logger = Logger.new file
      logger.info "#{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")} - #{message}\n"
      file.close
    end
    
    private
    def self.default_options
      { sn: Setting.web_service.sn, pwd: Setting.web_service.pwd }
    end
    
    def self.pwd
      new_password = Setting.web_service.sn + Setting.web_service.pwd
      Digest::MD5.hexdigest(new_password).upcase
    end
  end
end