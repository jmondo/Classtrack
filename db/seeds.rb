# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Administrator.find_or_create_by_email("registrar@babson.edu") do |a|
  a.password = "Classtrackr0cks"
  a.password_confirmation = "Classtrackr0cks"
end
