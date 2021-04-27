require 'rails_helper'

RSpec.describe ShortUrlVisit, type: :model do
  describe 'associations' do
    it { should belong_to(:short_url) }
  end
end
