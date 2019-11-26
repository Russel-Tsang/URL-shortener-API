class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    # @short_urls = ShortUrl.order(click_count: :desc).limit(100)
    # render :index
  end

  def create
    short_url = ShortUrl.new(full_url: params[:full_url])
    if short_url.valid?
      render json: {short_code: short_url.short_code}
    else
      render json: @short_url.errors.full_messages, status: 422
    end
  end

  def show
  end

end
