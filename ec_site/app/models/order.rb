class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :books, through: :order_details
  has_many :order_details
end