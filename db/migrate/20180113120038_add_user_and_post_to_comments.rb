class AddUserAndPostToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :user, foreign_key: true, index: true
    add_reference :comments, :post, foreign_key: true, index: true
  end
end
