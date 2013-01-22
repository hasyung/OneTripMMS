class ApplicationController < ActionController::Base
  
  protect_from_forgery
  before_filter :authenticate_user!
  add_breadcrumb :root, :root_path
  
end
