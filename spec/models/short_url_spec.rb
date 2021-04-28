require 'rails_helper'
require 'byebug'

RSpec.describe ShortUrl, type: :model do
  context 'associations' do
    it { should have_many(:visits) }
  end

  context 'validations' do
    subject { build(:custom_short_url) }

    it { should validate_presence_of(:original_url) }
    it { should validate_uniqueness_of(:transformed_path) }

    describe 'original URL validations' do
      context 'valid formats' do
        example 'simple url with no sub-domain' do
          subject.original_url = 'https://example.com'
          expect(subject).to be_valid
        end

        example 'simple url with sub-domain' do
          subject.original_url = 'https://build.example.com'
          expect(subject).to be_valid
        end

        example 'url with paths and query params' do
          subject.original_url = 'https://www.example.com/one/path?with=queryParams'
          expect(subject).to be_valid
        end
      end

      context 'invalid formats' do
        example 'missing protocol' do
          subject.original_url = 'example.com'
          expect(subject).not_to be_valid
        end

        example 'not a URL at all' do
          subject.original_url = 'asdasdaasd'
          expect(subject).not_to be_valid
        end

        example 'a path' do
          subject.original_url = '/one_path/no_domain'
          expect(subject).not_to be_valid
        end
      end
    end

    describe 'custom path validations' do
      context 'invalid formats' do
        example 'simple path' do
          subject.transformed_path = '/simple-path'
          expect(subject).to be_valid
        end

        example 'deep path' do
          subject.transformed_path = '/simple-path/deeper-path'
          expect(subject).to be_valid
        end

        example 'with query params' do
          subject.transformed_path = '/simple-path?query=params'
          expect(subject).to be_valid
        end
      end

      context 'invalid formats' do
        example 'providing a url instead of a path' do
          subject.transformed_path = 'https://example.com'
          expect(subject).not_to be_valid
        end

        example 'providing a common string instead of a path' do
          subject.transformed_path = 'a normal string'
          expect(subject).not_to be_valid
        end

        example 'including spaces inside the path' do
          subject.transformed_path = '/a cool path'
          expect(subject).not_to be_valid
        end
      end
    end
  end

  context 'transformed path' do
    describe 'when no custom path is provided' do
      subject { build(:short_url) }

      it 'is assigned a random path on save' do
        subject.save
        expect(subject.transformed_path).not_to be_nil
        expect(subject.transformed_path).to be_a(String)
      end
    end

    describe 'when a custom path is provided' do
      subject { build(:custom_short_url) }

      it 'is saved with the provided custom path' do
        custom_path = subject.transformed_path
        subject.save
        expect(subject.transformed_path).to eq(custom_path)
      end
    end
  end
end
