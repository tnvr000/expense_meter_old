class Tag < ApplicationRecord
  belongs_to :customer
  has_many :taggings
  has_many :expenses, through: :taggings
end
