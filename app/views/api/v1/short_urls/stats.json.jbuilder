json.array! @short_urls do |short_url|
  json.id short_url.id
  json.original_url short_url.original_url
  json.transformed_url "#{@base_url}#{short_url.transformed_path}"
  json.created_at short_url.created_at
  
  json.visits short_url.visits do |visit|
    json.visited_at visit.visited_at
  end
end
