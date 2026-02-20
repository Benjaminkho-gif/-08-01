class Book < ApplicationRecord
  # Associations
  has_many :taggings, dependent: :destroy        # corrected plural
  has_many :tags, through: :taggings
    
  has_one_attached :image

  has_many :order_details
  has_many :orders, through: :order_details

  has_many :line_items, dependent: :destroy
  has_many :carts, through: :line_items

  # Allowlist searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    ["book_name", "author_name", "issue_date", "price", "created_at", "updated_at"]
  end

  # Allowlist searchable associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    ["carts", "image_attachment", "image_blob", "line_items", "order_details", "orders", "taggings", "tags"]
  end
  
  # Validations
  validates :book_name, presence: true
  validates :author_name, presence: true
  validates :issue_date, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0, message: "価格は0以上の数値で入力してください" }
end