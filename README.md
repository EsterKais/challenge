# Setup

1. Clone the repository
2. Bundle install
3. Run rake db:setup

**Notes:**

As this is just a sample app and the purpose was to just set up models andrelationships, I made no controllers/views.

# Answers

## First:

This was the very first idea:
`SELECT issue_date FROM payments ORDER BY amount DESC LIMIT 1;`

But this seemed more sophisticated:
`SELECT issue_date FROM  payments where amount=(select max(amount) from payments);`

## Second:
### Part 1: refer to the repository, `db/schema.rb`.
**Notes:**

Referring to `db/seeds.rb`, I know using activerecord-import gem is quite the overkill here,
but in reality, this can be a performance saviour.

### Part 2: please refer to the repository, `app/models`.

Due to the addition of has_many associations, the resulting migrations can be found at:
`db/migrate/20180113115720_add_user_to_posts.rb` and
`db/migrate/20180113120038_add_user_and_post_to_comments.rb`

As I noticed that in part 3, I decided to: `belongs_to :author, class_name: "User", foreign_key: "user_id"`

### Part 3

`@posts = Post.all`
`SELECT  posts.* FROM posts`

There is a (maybe intentional?) typo `posts` instead of `@posts`.
`@comments = @posts.map(&:comments).flatten`
`SELECT  comments.* FROM comments WHERE comments.post_id = 1` times the number of comments.

The below didn't work, but if I imagine that it would work (i.e. with update_attributes),
you'd do a transaction per save, which is a lot of extra ~0.5ms. Plus, fetching every  `user` with: `SELECT  users.* FROM users WHERE users.id = <insert_id_here>`

@comments.each do |comment|
  comment.author.username = "Something"
end

**Refactor:**

If you're going to get all posts anyway, why even get the posts? Just get all the comments and save the database the trouble of messing with posts.

However, I can imagine that in real life, there might be comments without posts or some other weirdnesses, so I guess it's safer to get the posts first.

Using batches in case there would be millions of records and the simple assignment of `username` didn't work, thus `update_attribute`.

I could even go crazy with making pure SQL queries here instead of using rails to insert the update data(for huge data migrations, that can be a life saver), but I hope this will do for now.

```
  Comment.includes(:author).where(post: Post.all).find_in_batches do |comment_batch|
    ActiveRecord::Base.transaction do
      comment_batch.each do |comment|
        comment.author.update_attribute(:username, params[:username])
      end
    end
  end
```

```
  Comment Load (0.6ms)  SELECT  `comments`.* FROM `comments` WHERE `comments`.`post_id` IN (SELECT `posts`.`id` FROM `posts`) ORDER BY `comments`.`id` ASC LIMIT 1000
    User Load (0.4ms)  SELECT `users`.* FROM `users` WHERE `users`.`id` IN (96, 54, 17, 5, 64, 1, 99, 47, 8, 49, 12, 3, 63, 21, 18, 40, 20, 86, 82, 73, 51, 4, 87, 84, 62, 78, 70, 89, 38, 6, 44, 28, 41, 39, 75, 46, 32, 35, 74, 71, 2, 80, 34, 50, 27, 10, 77, 95, 30, 16, 88, 81, 93, 48, 37, 97, 53)
     (0.2ms)  BEGIN
    SQL (0.4ms)  UPDATE `users` SET `username` = 'Anyone?', `updated_at` = '2018-01-13 14:31:49' WHERE `users`.`id` = 96
    SQL (0.3ms)  UPDATE `users` SET `username` = 'Anyone?', `updated_at` = '2018-01-13 14:31:49' WHERE `users`.`id` = 54
    ...
    (1.4ms)  COMMIT
```

## Third: please refer to `app/models/person.rb` for children & grandchildren and either `db/schema.rb` or `db/migrate/20180113150222_create_people.rb` for DB setup.

## Fourth:
