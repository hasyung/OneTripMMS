class TestsController < ApplicationController
  
  def show
    add_breadcrumb :show
  end
  
  def send_mms
    if params[:test].blank? || params[:test][:mobile].blank? || params[:test][:place].blank?
      return redirect_to test_path, :alert => t("messages.tests.arguments_error")
    end
    
    @place = Place.find_by_id params[:test][:place]
    
    options = {}
    options[:stime] = "" if params[:test][:stime].blank?
    options[:mobile] = params[:test][:mobile]
    options[:title] = "#{t('links.tests.prefix_test')}-#{@place.title}"
    options[:content] = @place.mms_content
    
    result = Service::MMS.send_mms options
    if result < 0
      redirect_to test_path, :alert => t("messages.tests.error.e_#{result.abs}")
    else
      redirect_to test_path, :notice => t("messages.tests.success")
    end
  end
  
end
