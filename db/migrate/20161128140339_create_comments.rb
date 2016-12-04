# frozen_string_literal: true
class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.integer :commentable_id
      t.string :commentable_type
      # t.references :post, index: true, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
  end
end
