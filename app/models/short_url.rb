class ShortUrl < ApplicationRecord
  has_many :visits, class_name: 'ShortUrlVisit', dependent: :destroy

  validates :original_url,
            presence: true,
            format: { with: URI::DEFAULT_PARSER.make_regexp,
                      message: 'must have valid format. ex: https://example.com' }

  validates :transformed_path,
            uniqueness: true,
            format: { with: %r{\A(/\S+|)\Z}i, message: 'must have valid format. ex: /custom-path?with=someParams' }

  before_save :generate_path

  scope :ordered_by_recent, -> { order(created_at: :desc) }
  scope :with_ordered_visits, -> { includes(:visits).ordered_by_recent.order('short_url_visits.visited_at DESC') }

  def self.destroy_old_urls(date = 6.months.ago)
    latest_urls_ids = ShortUrlVisit.latest_since(date).pluck(:short_url_id)
    old_urls = where.not(id: latest_urls_ids)
    old_urls.destroy_all
  end

  private

  def generate_path
    return if transformed_path.present?

    self.transformed_path = "/#{SecureRandom.base36(8)}"
  end
end
