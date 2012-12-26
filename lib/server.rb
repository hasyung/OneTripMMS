require "xmlrpc/client"

class Server
  @@server = XMLRPC::Client.new2("http://sdk3.entinfo.cn:8060/webservice.asmx")
  
  def self.mms_send(sn, pwd, title, mobile, content, stime)
    begin
      @@server.call2("mdMmsSend", sn, pwd, title, mobile, content, stime)
    end
  end
  
  def self.mms_receive(sn, pwd, title, mobile, content, stime)
    begin
      @@server.call("mdMmsReceive", sn, pwd)
    end
  end
  
end