class FramesController < ApplicationController
  
  before_filter :find_place
  before_filter :add_place_breadcrumb
  
  def index
    @frames = @place.frames.number_asc
    add_breadcrumb :index
    
    content = ""
    sn = "SDK-WSS-010-02513"
    password = "850-2EE5"
    pwd = Digest::MD5.hexdigest(sn + password).upcase
    logger.info("pwd=#{pwd}")
    title = @place.name
    mobile = "15928135150"
    stime = Time.now.to_time
    logger.info("stime=#{stime}")
    @frames.each do |frame|
      content += frame.mms_content if frame.mms_content.present?
      content += frame.mms_image if frame.mms_image.present?
    end
    content = content[0, content.length - 1]
    logger.info("content=#{content}")
    Server.mms_send(sn, pwd, title, mobile, content, stime)
   
  end

  def new
    add_breadcrumb :new
    @frame = @place.frames.new
  end
  
  def create
    @frame = @place.frames.new params[:frame]
    if @frame.save
      redirect_to place_frames_path(@place), :notice => t('messages.frames.success')
    else
      binding.pry
      render :new
    end
    add_breadcrumb :new
  end

  def edit
    @frame = Frame.find params[:id]
    add_breadcrumb :edit
  end
  
  def update
    @frame = Frame.find params[:id]
    if @frame.update_attributes params[:frame]
      redirect_to place_frames_path(@place), :notice => t('messages.frames.success')
    else
      render :edit
    end
    add_breadcrumb :edit
  end
  
  def destroy
    @frame = Frame.find params[:id]
    if @frame.destroy
      redirect_to place_frames_path(@place), :notice => t('messages.frames.success')
    else
      redirect_to place_frames_path(@place), :notice => t('messages.frames.error')
    end
  end
  
  def build_number
    
  end
  
  private
  def find_place
		@place = Place.find params[:place_id]
    raise ActiveRecord::RecordNotFound unless @place
  end
  
  def add_place_breadcrumb
    add_breadcrumb @place.name, place_frames_path(@place)
  end
end
