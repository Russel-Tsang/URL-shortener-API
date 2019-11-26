class UpdateShortUrls < ActiveRecord::Migration[6.0]
  def change
    add_column :short_urls, :title, :string, null: false
    add_column :short_urls, :full_url, :string, null: false
    add_column :short_urls, :short_code, :string, null: false
    add_column :short_urls, :click_count, :integer, null: false, default: 0
  end
end
