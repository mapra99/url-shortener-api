class AddIndexToShortUrls < ActiveRecord::Migration[6.1]
  def change
    add_index :short_urls, :transformed_path
  end
end
