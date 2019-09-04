class Api::PicturesController < ApplicationController
  def index
    # Avoid N+1 queries by using "with_attached_photos"
    @pictures = Picture.with_attached_photos.all 
    if @pictures
      render :index
    else
      render json: ['Pictures not found'], status: 422
    end
  end

  def create
    @picture = Picture.new(picture_params)
    if @picture.save 
      render :index
    else
      render json: @picture.errors.full_messages, status: 422
    end
  end

  private
  def picture_params
    params.require(:picture).permit(:title, :photo)
  end

end