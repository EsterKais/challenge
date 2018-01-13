class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :amount
      t.datetime :issue_date

      t.timestamps
    end
  end
end
