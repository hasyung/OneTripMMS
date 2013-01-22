module Zucp
  module Base
    attr_accessor :sms, :mms, :sn, :pwd
  
    def initialize
      @sms = Setting.zucp.sms
      @mms = Setting.zucp.mms
      @sn = Setting.zucp.sn
      @pwd = Setting.zucp.pwd
      @mpwd = Digest::MD5.hexdigest(@sn + @pwd).upcase
    end
    
    def ticket(is_encrypt = true)
      result = Hash.new
      result[:sn] = @sn
      result[:pwd] = is_encrypt ? @mpwd : @pwd
      result
    end
  end
end