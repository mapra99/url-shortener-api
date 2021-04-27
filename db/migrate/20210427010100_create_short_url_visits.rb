class CreateShortUrlVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :short_url_visits do |t|
      t.references :short_url, null: false, foreign_key: true
      t.datetime :visited_at, null: false
    end
  end
end
