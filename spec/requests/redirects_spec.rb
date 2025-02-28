require 'rails_helper'

RSpec.describe "Redirects", type: :request do
  describe 'GET /:short_url' do
    let(:url) { create(:url) }

    it 'redirects to the original URL' do
      get "/#{url.short_url}"
      expect(response).to redirect_to(url.original_url)
    end

    it 'increments the visits count' do
      expect {
        get "/#{url.short_url}"
        url.reload
      }.to change(url, :visits_count).by(1)
    end

    it 'returns 404 for non-existent short URL' do
      get "/nonexistent"
      expect(response).to have_http_status(:not_found)
      expect(response.body).to eq("URL not found")
    end

    it 'caches the URL lookup' do
      expect(Rails.cache).to receive(:fetch).with("short_url:#{url.short_url}", expires_in: 1.hour).and_call_original
      get "/#{url.short_url}"
    end

    it 'uses cached URL on subsequent requests' do
      Rails.cache.write("short_url:#{url.short_url}", url)
      expect(Url).not_to receive(:find_by!)

      get "/#{url.short_url}"
      expect(response).to redirect_to(url.original_url)
    end
  end
end
