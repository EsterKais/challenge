users = []

(1..100).each do |int|
  users << User.new(username: Faker::Superhero.name)
end

# I know using activerecord-import gem is quite the overkill here,
# but in reality, this can be a performance saviour.
User.import(users)

posts = []

(1..100).each do |int|
  posts << Post.new(title: Faker::ChuckNorris.fact, body: Faker::Hipster.paragraph(5), user_id: rand(100))
end

Post.import(posts)

comments = []

(1..100).each do |int|
  comments << Comment.new(title: Faker::RuPaul.quote, body: Faker::Hipster.paragraph(1), user_id: rand(100), post_id: rand(100))
end

Comment.import(comments)
