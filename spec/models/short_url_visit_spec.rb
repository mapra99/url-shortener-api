require 'rails_helper'

RSpec.describe ShortUrlVisit, type: :model do
  context 'associations' do
    it { should belong_to(:short_url) }
  end

  context 'visits collection' do
    let!(:short_url) { create(:short_url) }
    let!(:short_url_visits) { create_list(:short_url_visit, 10, short_url: short_url) }

    describe '#latest_since' do
      it 'shows the latest visits records since specific date/time' do
        ref_time = 1.second.ago
        latest_urls = ShortUrlVisit.latest_since(ref_time)
        latest_urls.each do |url|
          expect(url.visited_at).to be > ref_time
        end
      end
    end

    describe '#most_recent_order' do
      it 'shows the visits ordered by visit timestamp' do
        expect(ShortUrlVisit.most_recent_order).to eq(short_url_visits.reverse)
      end
    end
  end
end
