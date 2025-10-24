class Book < ApplicationRecord
  has_many :tagging, dependent: :destroy
  has_many :tags, through: :tagging
    
  has_one_attached :image

  has_many :order_details
  has_many :orders, through: :order_details

  has_many :line_items, dependent: :destroy
  has_many :carts, through: :line_items

  # Allowlist searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["book_name", "author_name", "issue_date", "price", "created_at", "updated_at"]
  end
  
  validates :book_name, presence: true
  validates :author_name, presence: true
  validates :issue_date, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0, message: "価格は0以上の数値で入力してください" }
end
