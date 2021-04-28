require 'rails_helper'
require 'byebug'

RSpec.describe 'Short Url endpoints', type: :request do
  context 'POST /api/v1/short_urls - shorten a URL' do
    let(:original_url) { Faker::Internet.url }
    let(:base_body) {{short_url: {original_url: original_url}}}

    describe 'passing a url to be shortened' do
      before do
        post('/api/v1/short_urls.json', params: base_body)
      end

      it 'should respond with an ok status' do
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(response).to have_http_status(200)
      end

      describe 'the generated shortened URL' do
        it 'should come in the response body' do
          payload = JSON.parse(response.body)
          expect(payload).not_to be_empty
          expect(payload).to be_kind_of(Hash)
          expect(payload).to have_key('transformed_url')
          expect(response).to have_http_status(200)
        end
      end
    end

    describe 'passing a custom shortened path' do
      let(:custom_path) { '/custom-path' }

      before do
        base_body[:short_url].merge!({transformed_path: custom_path})
        post('/api/v1/short_urls.json', params: base_body)
      end

      it 'should respond with an ok status' do
        payload = JSON.parse(response.body)
        expect(payload).not_to be_empty
        expect(response).to have_http_status(200)
      end

      describe 'the generated shortened URL' do
        it 'should come in the response body' do
          payload = JSON.parse(response.body)
          expect(payload).not_to be_empty
          expect(payload).to be_kind_of(Hash)
          expect(payload).to have_key('transformed_url')
          expect(response).to have_http_status(200)
        end

        it 'should equal the custom path' do
          payload = JSON.parse(response.body)
          transformed_url = payload['transformed_url']
          url_path = URI.parse(transformed_url).path

          expect(url_path).to eq(custom_path)
        end
      end
    end
  end

  context 'GET /:shortened_path' do
    let(:short_url) { create(:short_url) }

    before do
      get short_url.transformed_path
    end

    it 'redirects to the original URL' do
      expect(response).to have_http_status(302)
      expect(response.header).to have_key('Location')
      expect(response.header['Location']).to eq(short_url.original_url)
    end

    it 'tracks the visit' do
      expect(short_url.visits.length).to eq(1)
    end
  end

  context 'GET /api/v1/short_urls/stats' do
    let!(:short_urls) { create_list(:short_url, 2) }
    let!(:first_url_visits) { create_list(:short_url_visit, 10, short_url: short_urls[0]) }
    let!(:second_url_visits) { create_list(:short_url_visit, 5, short_url: short_urls[1]) }

    before do
      get '/api/v1/short_urls/stats.json'
    end

    it 'should respond with an ok status' do
      payload = JSON.parse(response.body)
      expect(payload).not_to be_empty
      expect(response).to have_http_status(200)
    end

    it 'should return an array of all the existing short urls' do
      payload = JSON.parse(response.body)
      expect(payload).to be_kind_of(Array)

      short_url_ids = payload.pluck('id').map(&:to_i)
      expect(short_url_ids.sort).to eq(short_urls.pluck(:id).sort)
    end

    it 'should return the short urls sorted by created_at, newest first' do
      payload = JSON.parse(response.body)

      short_url_ids = payload.pluck('id').map(&:to_i)
      expect(short_url_ids).to eq(short_urls.pluck(:id).reverse)
    end
  end
end
