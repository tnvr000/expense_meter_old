class Group < ApplicationRecord
  belongs_to :owner, class_name: :Customer, foreign_key: :customer_id
  has_many :expenses
  has_many :memberships
  has_many :members, through: :memberships, source: :customer
end
