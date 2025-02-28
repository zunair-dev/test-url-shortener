require 'rails_helper'

RSpec.describe Api::V1::UrlsController, type: :controller do
  describe 'GET #index' do
    let!(:urls) { create_list(:url, 10) }

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'returns all URLs in JSON format' do
      get :index

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(urls.count)
    end
  end

  describe 'GET #show' do
    context 'when the URL exists' do
      let(:url) { create(:url) }

      it 'returns the correct URL' do
        get :show, params: { id: url.id }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['id']).to eq(url.id)
        expect(json_response['original_url']).to eq(url.original_url)
      end
    end

    context 'when the URL does not exist' do
      it 'returns 404' do
        get :show, params: { id: 999 }

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { url: attributes_for(:url) } }

      it 'creates a new URL and returns a successful response' do
        expect {
          post :create, params: valid_params
        }.to change(Url, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { url: { original_url: 'not-a-url' } } }

      it 'does not create a new URL and returns an error status' do
        expect {
          post :create, params: invalid_params
        }.not_to change(Url, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'short_url handling' do
      let(:custom_short_url) { SecureRandom.alphanumeric(8) }

      it 'does not allow manual short_url assignment' do
        post :create, params: { url: { original_url: Faker::Internet.url, short_url: custom_short_url } }

        json_response = JSON.parse(response.body)
        expect(json_response['short_url']).not_to eq(custom_short_url)
      end
    end

    context 'URL validation' do
      it 'returns an error when original_url is invalid' do
        post :create, params: { url: { original_url: 'invalid-url' } }

        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to include("Original url is not a valid URL")
      end
    end
  end
end
