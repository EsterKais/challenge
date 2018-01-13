users = []

(1..100).each do |int|
  users << User.new(username: Faker::Superhero.name)
end

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

BEERS = %w[IPA borwn_ale pilsner lager lambic hefeweizen]
beers = []

BEERS.each do |beer|
  beers << Beer.new(beer_type: beer)
end

Beer.import(beers)

payments = []

(1..100).each do |int|
  payments << Payment.new(user_id: int, amount: int, issue_date: rand(Time.now - 2.years..Time.now - 1.years))
end

Payment.import(payments)
