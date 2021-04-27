class Api::V1::ShortUrlsController < Api::V1::ApplicationController
  def create
    @short_url = ShortUrl.new(short_url_params)

    if @short_url.save
      render json: @short_url, status: 200
    else
      render json: { errors: @short_url.errors.full_messages }, status: 400
    end
  end

  def stats
  end

  def redirect
  end

  private

  def short_url_params
    params.require(:short_url).permit(:original_url, :transformed_path)
  end
end
