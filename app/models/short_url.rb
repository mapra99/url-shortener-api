class ShortUrl < ApplicationRecord
  has_many :visits, class_name: 'ShortUrlVisit'

  validates :original_url,
            presence: true,
            uniqueness: true,
            format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must have valid format. ex: https://example.com" }

  before_save :generate_path

  private

  def generate_path
    return if transformed_path.present?

    self.transformed_path = "/#{SecureRandom.base36(8)}"
  end
end
