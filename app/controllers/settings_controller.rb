class SettingsController < ApplicationController
  
  add_breadcrumb :index, :settings_path, :only => [:index]
  
  def index
    if request.post?
      if !params[:setting].blank?
        Setting.mms_url = params[:setting][:mms_url]
        Setting.sms_url = params[:setting][:sms_url]
        Setting.sn = params[:setting][:sn]
        Setting.password = params[:setting][:password]
      end
      
      redirect_to :root, :notice => t("helpers.messages.setting")
    end
  end
end
