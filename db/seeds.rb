# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
100.times do
  Comment.create({title: Faker::Book.title, body: Faker::Lorem.paragraph, rating: rand(5) + 1})
end
print Cowsay::say("Created a 100 comments!")
