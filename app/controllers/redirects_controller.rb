class RedirectsController < ApplicationController
  def show
    @url = Rails.cache.fetch("short_url:#{params[:short_url]}", expires_in: 1.hour) do
      Url.find_by!(short_url: params[:short_url])
    end

    @url.increment_visits!
    redirect_to @url.original_url, allow_other_host: true
  end

  rescue_from ActiveRecord::RecordNotFound do
    render plain: "URL not found", status: :not_found
  end
end
