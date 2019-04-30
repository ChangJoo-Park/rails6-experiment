# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Comment.destroy_all
Post.destroy_all
User.destroy_all

USER_COUNT = 100

users = []
posts = []
comments = []

USER_COUNT.times do |index|
  user = User.create(
    email: Faker::Internet.email,
    password: Faker::Internet.email
  )
  user.user_profile.username = "#{Faker::Internet.username}#{Faker::Lorem.word}"
  user.user_profile.name = Faker::Name.name
  users.push(user)
end

puts "USER CREATED"

users.each do |user|
  Faker::Number.between(10, 20).times do |index|
    tag_list = []
    Faker::Number.between(2, 5).times do |tag_index|
      tag_list.push(Faker::Hacker.adjective.parameterize)
    end

    post = Post.create(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      published: Faker::Boolean.boolean(0.7),
      tag_list: tag_list.join(", "),
      user: user
    )
    posts.push(post)
  end
end

puts "POST CREATED"

2000.times do |post|
  user = users.sample
  post = posts.sample
  Comment.create(
    body: Faker::Lorem.sentence,
    user: user,
    post: post
  )
end

puts "COMMENT CREATED"
