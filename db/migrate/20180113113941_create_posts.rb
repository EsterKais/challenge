class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table(:posts, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4') do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
