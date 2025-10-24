class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :cart

  # 小計金額を計算
  def total_price
    quantity * price
  end
end