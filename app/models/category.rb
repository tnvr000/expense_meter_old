class Category < ApplicationRecord
  belongs_to :primary_category
  has_many :expenses
end
