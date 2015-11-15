# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# get ids from all posts to array.
# iterate through all comments; where post_id == nil, random populate from array
# [array].sample

# posts = Post.all
# posts.each do |post|
#   post.user ||= User.order("RANDOM()").first
#   post.save
# end
#
# comments = Comment.all
# comments.each do |comment|
#   comment.user ||= User.order("RANDOM()").first
#   comment.post ||= Post.order("RANDOM()").first
#   comment.save
# end

# posts = Post.all
# posts.each do |post|
#   array = []
#   (Random.rand(6) + 1).times do
#     array.push (Random.rand(6) + 1)
#   end
#   post.update(category_ids: array)
# end
