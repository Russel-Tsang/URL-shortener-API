class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    @short_urls = ShortUrl.order(click_count: :desc).limit(100)
    render :index
  end

  def create
    short_url = ShortUrl.new(full_url: params[:full_url])
    if short_url.save
      render json: {short_code: short_url.short_code}
    else
      render json: {errors: short_url.errors.full_messages}, status: 422
    end
  end

  def show
    short_url = ShortUrl.find_by(short_code: params[:id])
    if short_url
      short_url.update(click_count: short_url.click_count + 1)
      redirect_to short_url.full_url 
    else
      render status: 404
    end
  end

end
