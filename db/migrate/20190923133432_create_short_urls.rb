class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.string :short_urls, :title, 
      t.string :short_urls, :full_url, null: false
      t.string :short_urls, :short_code, 
      t.integer :short_urls, :click_count, default: 0, null: false,
      t.timestamps
    end
  end
end
