json.urls do
    json.array!(@short_urls) do |url| 
        json.extract! url, :title, :full_url, :short_code, :click_count
    end
end