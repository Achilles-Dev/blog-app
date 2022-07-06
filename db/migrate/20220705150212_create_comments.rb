class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :author_id
      t.integer :post_id

      t.timestamps
    end
    add_index :comments, :author_id
    add_index :comments, :post_id
    add_foreign_key :comments, :users
    add_foreign_key :comments, :posts
  end
end
