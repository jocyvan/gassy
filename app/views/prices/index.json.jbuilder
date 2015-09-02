json.array!(@prices) do |price|
  json.extract! price, :id, :fuel_id, :station_id, :value
  json.url price_url(price, format: :json)
end
