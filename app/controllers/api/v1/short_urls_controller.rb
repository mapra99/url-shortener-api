class Api::V1::ShortUrlsController < Api::V1::ApplicationController
  before_action :base_url

  def create
    @short_url = ShortUrl.create(short_url_params)
    render json: { errors: @short_url.errors.full_messages }, status: 400 and return unless @short_url.save
  end

  def stats
  end

  def redirect
    @short_url = ShortUrl.find_by(transformed_path: request.path)
    redirect_to @short_url.original_url
  end

  private

  def short_url_params
    params.require(:short_url).permit(:original_url, :transformed_path)
  end

  def base_url
    @base_url ||= request.base_url
  end
end
