json.array!(@fuels) do |fuel|
  json.extract! fuel, :id, :name, :status
  json.url fuel_url(fuel, format: :json)
end
