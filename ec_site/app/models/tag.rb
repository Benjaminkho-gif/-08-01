class Tag < ApplicationRecord
    has_many :tagging, dependent: :destroy
    has_many :books, through: :tagging

    validates :tag_name, presence: true
  end