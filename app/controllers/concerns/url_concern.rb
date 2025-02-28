module UrlConcern
  extend ActiveSupport::Concern

  private

  def url_params
    params.require(:url).permit(:original_url)
  end

  def not_found_response
    render json: { error: "URL not found" }, status: :not_found
  end
end
