require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:original_url) }

    context 'original_url format' do
      let(:valid_url_http) { build(:url, original_url: Faker::Internet.url(scheme: 'http')) }
      let(:valid_url_https) { build(:url, original_url: Faker::Internet.url) }
      let(:invalid_url) { build(:url, original_url: SecureRandom.alphanumeric(8)) }

      it 'allows URLs with http schema' do
        valid_url_http.validate
        expect(valid_url_http.errors[:original_url]).to be_empty
      end

      it 'allows URLs with https schema' do
        valid_url_https.validate
        expect(valid_url_https.errors[:original_url]).to be_empty
      end

      it 'rejects invalid URLs' do
        invalid_url.validate
        expect(invalid_url.errors[:original_url]).to include('is not a valid URL')
      end
    end
  end

  describe 'before_validation' do
    let(:url) { build(:url, short_url: nil) }

    it 'generates a short_url before validation' do
      expect(url.short_url).to be_nil
      url.valid?
      expect(url.short_url).to be_present
    end
  end

  describe '#increment_visits!' do
    let(:url) { create(:url) }

    it 'increments the visits_count' do
      expect { url.increment_visits! }.to change(url, :visits_count).by(1)
    end
  end
end
