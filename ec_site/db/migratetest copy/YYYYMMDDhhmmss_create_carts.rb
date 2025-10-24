class CreateCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :carts do |t|
      t.string :session_id, null: false
      t.timestamps
    end
    add_index :carts, :session_id, unique: true
  end
end