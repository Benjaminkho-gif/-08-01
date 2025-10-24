class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :book_name, null: false
      t.string :author_name, null: false
      t.date :issue_date
      t.boolean :product_display, null: false, default: true
      t.integer :price, null: false
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end