class ShortUrlVisit < ApplicationRecord
  belongs_to :short_url

  before_save :set_visited_at

  scope :most_recent, -> { order(visited_at: :desc) }
  scope :latest, -> { most_recent.first }

  private

  def set_visited_at
    return if visited_at.present?

    self.visited_at = Time.now
  end
end
