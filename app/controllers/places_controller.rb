class PlacesController < ApplicationController
  
  add_breadcrumb :index, :places_path, :only => [:index]
  
  def index
    @places = Place.all
  end

  def new
    @place = Place.new
    add_breadcrumb :new
  end
  
  def create
    @place = Place.new params[:place]
    if @place.save
      redirect_to places_path, :notice => t('messages.places.success')
    else
      render :new
    end
    add_breadcrumb :new
  end

  def edit
    @place = Place.find params[:id]
    add_breadcrumb :edit
    add_breadcrumb @place.name
  end
  
  def update
    @place = Place.find params[:id]
    add_breadcrumb :edit
    add_breadcrumb @place.name
    if @place.update_attributes params[:place]
      redirect_to places_path, :notice => t('messages.places.success')
    else
      render :edit
    end
  end
  
  def destroy
    @place = Place.find params[:id]
    if @place.destroy
      redirect_to places_path, :notice => t('messages.places.success')
    else
      redirect_to places_path, :notice => t('messages.places.error')
    end
  end
end
