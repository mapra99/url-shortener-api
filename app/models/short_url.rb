class ShortUrl < ApplicationRecord
  has_many :visits, class_name: 'ShortUrlVisit'

  validates :original_url,
            presence: true,
            format: { with: URI::DEFAULT_PARSER.make_regexp,
                      message: 'must have valid format. ex: https://example.com' }

  validates :transformed_path,
            uniqueness: true,
            format: { with: %r{\A(/\S+|)\Z}i, message: 'must have valid format. ex: /custom-path?with=someParams' }

  before_save :generate_path

  private

  def generate_path
    return if transformed_path.present?

    self.transformed_path = "/#{SecureRandom.base36(8)}"
  end
end
