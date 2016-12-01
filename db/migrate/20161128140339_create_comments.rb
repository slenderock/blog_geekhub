class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body

      t.references :post, index: true, foreign_key: {on_delete: :cascade}
      t.timestamps
    end
  end
end
