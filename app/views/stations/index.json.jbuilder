json.array!(@stations) do |station|
  json.extract! station, :id, :name, :city, :latitude, :longitude
  json.url station_url(station, format: :json)
end
