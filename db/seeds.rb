# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: 'Jocyvan Castro', email: 'jocyvan.castro@gmail.com', password: 'testes', password_confirmation: 'testes', role: :admin)
User.create!(name: 'Eduardo Carneiro', email: 'eduardolcarneiro@gmail.com', password: 'testes', password_confirmation: 'testes')

Fuel.create!(name: 'Gasolina')
Fuel.create!(name: 'Diesel')
