module Zucp
  class API
    include Zucp::Base
    
    def initialize  
      super
    end
    
    # 获取漫道的信息
    def get_all_info
      response = build_savon(@mms).call(:get_all_info, message: ticket(false))
      response.body[:get_all_info_response][:get_all_info_result]
    end
    
    # 查询漫道余额
    def get_balance
      response = build_savon(@mms).call(:balance, message: ticket)
      response.body[:balance_response][:balance_result]
    end
    
    # 发送彩信
    # 参数：hash
    # :mobile => 要发送的号码
    # :title => 要发送的标题
    # :content => 要发送的内容
    def send_mms(options = {})
      options[:stime] ||= ""
      response = build_savon(@mms).call(:md_mms_send, message: ticket.merge!(options))
      response.body[:md_mms_send_response][:md_mms_send_result].to_i
    end
    
    # 接受短信
    def receive_sms
      response = build_savon(@mms).call(:mo, message: ticket)
      response.body[:mo_response][:mo_result]
    end
    
    private
    def build_savon(url)
      Savon.client(wsdl: url)
    end
  end
end