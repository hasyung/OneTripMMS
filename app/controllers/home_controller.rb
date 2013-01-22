class HomeController < ApplicationController
  
  add_breadcrumb :index, :root_path
  
  def index
    api = Zucp::API.new
    @balance = api.get_balance
  end
end
