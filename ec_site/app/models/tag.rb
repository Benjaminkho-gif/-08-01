# app/models/tag.rb
class Tag < ApplicationRecord
  has_many :taggings
  has_many :books, through: :taggings

  # Allowlist searchable attributes
  def self.ransackable_attributes(auth_object = nil)
    ["id", "tag_name", "created_at", "updated_at"]
  end

  # Allowlist searchable associations
  def self.ransackable_associations(auth_object = nil)
    ["books", "taggings"]
  end
end