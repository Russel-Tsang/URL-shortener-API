class CreateShortUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :short_urls do |t|
      t.string :title 
      t.string :full_url, null: false
      t.string :short_code 
      t.integer :click_count, default: 0
      t.timestamps
    end
    add_index :short_urls, :full_url, :unique => true
  end
end
