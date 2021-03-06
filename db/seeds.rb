# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(:email => 'andi@example.com', :password => 'blablabla', :password => 'blablabla')#.confirm!
User.create!(:email => 'domi@example.com', :password => 'blablabla', :password => 'blablabla')#.confirm!
User.create!(:email => 'simi@example.com', :password => 'blablabla', :password => 'blablabla')#.confirm!

kind = ['Offer', 'Demand']

for i in 1..100 do
  Post.create(:kind => kind[Random.rand(0..1)] ,:body => Faker::Lorem.words(Random.rand(4..15)).join(' ').squish, :user_id => Random.rand(1..3))
end

for i in 1..1000 do
  Message.create(:post_id => Random.rand(1..100) ,:body => Faker::Lorem.words(Random.rand(5..30)).join(' ').squish, :user_id => Random.rand(1..3))
end
