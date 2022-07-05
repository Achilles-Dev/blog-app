# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :author_id
      t.integer :post_id
      t.date :updated_at
      t.date :created_at

      t.timestamps
    end
  end
end
