class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  add_breadcrumb :root, :root_path
  
end
