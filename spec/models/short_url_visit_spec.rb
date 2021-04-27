require 'rails_helper'

RSpec.describe ShortUrlVisit, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:original_url) }
    it { should validate_uniqueness_of(:original_url) }
  end

  describe 'associations' do
    it { should belong_to(:short_url) }
  end
end
