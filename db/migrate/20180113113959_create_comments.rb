class CreateComments < ActiveRecord::Migration[5.1]
  def change
    # This is the first time I am actually using the options for create_table, but from personal
    # experience, especially with a blog platform, emojis (users LOVE emojis) are important and migrating to allow that
    # later will be a pain!
    create_table(:comments, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4') do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
