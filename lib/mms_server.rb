class MmsServer
  @@stime = Time.now.to_time  
  @@pwd = Digest::MD5.hexdigest( Setting.sn + Setting.password ).upcase
  @@mms_client = Savon.client(wsdl: Setting.mms_url)
  
  def self.mms_send(title, mobile, content)
    begin
      @@mms_client.call(:mdMmsSend, message: { :sn => Setting.sn, :pwd => @@pwd, :title => title, :mobile => mobile, :content => content, :stime => @@stime })
    end
  end
  
  def self.mms_receive
    begin
      @@mms_client.call(:mdMmsReceive, message: { :sn => Setting.sn, :pwd => @@pwd })
    end
  end

end