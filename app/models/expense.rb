class Expense < ApplicationRecord
  belongs_to :customer
  belongs_to :group, optional: true
  has_many :taggings
  has_many :tags, through: :taggings
end
