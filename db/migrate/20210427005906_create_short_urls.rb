class CreateShortUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :short_urls do |t|
      t.string :original_url, null: false
      t.string :transformed_path, null: false

      t.timestamps
    end
  end
end
