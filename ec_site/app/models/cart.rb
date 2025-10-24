class Cart < ApplicationRecord
 
  has_many :line_items
  has_many :books, through: :line_items

  # カートに商品を追加するメソッド
  def add_product(book, quantity)
    line_item = line_items.find_or_initialize_by(book: book)
    line_item.quantity += quantity
    line_item.price = book.price
    line_item.save
  end

  # カートの合計金額
  def total_price
    line_items.sum { |item| item.quantity * item.price }
  end

  # カート内の合計個数
  def total_number
    line_items.sum(:quantity)
  end

end