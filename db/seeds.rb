# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

for i in 1..1000 do
  Post.create(:kind => Random.rand(0..1) ,:message => Faker::Lorem.words(Random.rand(4..15)).join(' ').squish)
end
