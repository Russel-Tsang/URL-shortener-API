class RemoveNullConstraintsShortUrls < ActiveRecord::Migration[6.0]
  def change
    change_column_null :short_urls, :title, true
    change_column_null :short_urls, :full_url, true
    change_column_null :short_urls, :short_code, true
    change_column_null :short_urls, :click_count, true
  end
end
