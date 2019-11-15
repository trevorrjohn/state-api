# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  {
    name: "Home",
    street: "824 Park Ave South",
    city: "New York",
    state: "NY",
    country: "USA"
  },
  {
    name: "Work",
    street: "999 Madison Ave",
    city: "New York",
    state: "NY",
    country: "USA"
  },
  {
    name: "Country",
    street: "1 Santa Monica Blvd",
    city: "Santa Monica",
    state: "CA",
    country: "USA"
  }
].each do |params|
  Address.new(params).save!(validate: false)
end
