require 'rails_helper'

RSpec.describe ShortUrlVisit, type: :model do
  context 'associations' do
    it { should belong_to(:short_url) }
  end

  context 'visits collection' do
    let!(:short_url) { create(:short_url) }
    let!(:short_url_visits) { create_list(:short_url_visit, 10, short_url: short_url) }

    describe '#latest' do
      it 'shows the latest visit record' do
        expect(ShortUrlVisit.latest).to eq(short_url_visits.last)
      end
    end
  
    describe '#most_recent' do
      it 'shows the visits ordered by visit timestamp' do
        expect(ShortUrlVisit.most_recent).to eq(short_url_visits.reverse)
      end
    end
  end
end
