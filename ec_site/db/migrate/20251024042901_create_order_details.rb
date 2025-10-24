class CreateOrderDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :order_details do |t|
      t.references :book, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :count, null: false
      t.integer :price, null: false

      t.timestamps
    end
  end
end