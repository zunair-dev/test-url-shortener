class Api::V1::UrlsController < ApplicationController
  include UrlConcern

  protect_from_forgery with: :null_session
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def index
    urls = Url.order(created_at: :desc)
    render json: urls, status: :ok
  end

  def show
    url = Url.find_by!(id: params[:id])
    render json: url, status: :ok
  end

  def create
    # url = Url.new(url_params.except(:short_url)) # ensure that short_url isn't set manually
    url = Url.new(url_params)

    if url.save
      render json: url, status: :created
    else
      render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
