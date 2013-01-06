class HomeController < ApplicationController
  
  add_breadcrumb :index, :root_path
  
  def index
    @balance = Service::MMS.get_balance
  end
end
