class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table(:users, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8mb4') do |t|
      t.string :username

      t.timestamps
    end
  end
end
