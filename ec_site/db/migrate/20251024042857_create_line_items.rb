class CreateLineItems < ActiveRecord::Migration[7.1]
  def change
    create_table :line_items do |t|
      t.references :book, null: false, foreign_key: true
      t.references :cart, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.integer :price, default: 0

      t.timestamps
    end
  end
end