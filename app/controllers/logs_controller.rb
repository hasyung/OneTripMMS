class LogsController < ApplicationController
  
  def index
    add_breadcrumb :index
    @receive_logs = ""
    File.open(File.expand_path("public/receive.log", Rails.root)) do |file|
      file.each_line() { |line| @receive_logs << "#{line}" }
      file.close
    end
    @send_logs = ""
    File.open(File.expand_path("public/send.log", Rails.root)) do |file|
      file.each_line() { |line| @send_logs << "#{line}" }
      file.close
    end
  end
  
end
