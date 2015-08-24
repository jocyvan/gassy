# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(name: 'First User', email: 'first@example.com', password: 'testes', password_confirmation: 'testes')

for i in 1..20
  user.stations.create!(name: "Station ##{i}", city: "City ##{i}", latitude: -2.5247401, longitude:-44.2230234)
end
