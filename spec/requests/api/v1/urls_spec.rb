require 'rails_helper'

RSpec.describe "Api::V1::Urls", type: :request do
  describe 'GET /api/v1/urls' do
    let!(:urls) { create_list(:url, 2) }

    before { get '/api/v1/urls' }

    it 'returns a successful response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of URLs' do
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(urls.count)
    end
  end

  describe 'GET /api/v1/urls/:id' do
    let(:url) { create(:url) }

    context 'when the URL exists' do
      before { get "/api/v1/urls/#{url.id}" }

      it 'returns the correct URL' do
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['id']).to eq(url.id)
        expect(json_response['original_url']).to eq(url.original_url)
      end
    end

    context 'when the URL does not exist' do
      before { get '/api/v1/urls/999' }

      it 'returns 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /api/v1/urls' do
    context 'with valid parameters' do
      let(:valid_params) { { url: attributes_for(:url) } }

      it 'creates a new URL and returns a successful response' do
        expect {
          post '/api/v1/urls', params: valid_params
        }.to change(Url, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { url: { original_url: 'invalid-url' } } }

      it 'does not create a new URL and returns an error message' do
        expect {
          post '/api/v1/urls', params: invalid_params
        }.not_to change(Url, :count)

        expect(response).to have_http_status(:unprocessable_entity)

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).not_to be_empty
      end
    end

    context 'short_url handling' do
      let(:custom_short_url) { SecureRandom.alphanumeric(8) }

      before { post '/api/v1/urls', params: { url: { original_url: Faker::Internet.url, short_url: custom_short_url } } }

      it 'does not allow manual short_url assignment' do
        json_response = JSON.parse(response.body)
        expect(json_response['short_url']).not_to eq(custom_short_url)
      end
    end

    context 'URL validation' do
      before { post '/api/v1/urls', params: { url: { original_url: 'invalid-url' } } }

      it 'returns an error' do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Original url is not a valid URL")
      end
    end
  end
end
