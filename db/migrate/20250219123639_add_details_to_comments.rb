class AddDetailsToComments < ActiveRecord::Migration[8.0]
  def change
    add_column :comments, :body, :string
    add_reference :comments, :user, null: false, foreign_key: true
    add_reference :comments, :post, null: false, foreign_key: true
  end
end
