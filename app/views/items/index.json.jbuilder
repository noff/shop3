json.array!(@items) do |item|
  json.extract! item, :rating, :price, :name, :description
  json.url item_url(item, format: :json)
end
