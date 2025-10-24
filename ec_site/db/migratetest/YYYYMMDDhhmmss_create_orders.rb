class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :quantity, null: false
      t.string :delivery_address, null: false
      t.integer :total, null: false 

      t.timestamps
    end
  end
end