class Group < ApplicationRecord
  belongs_to :creator, class_name: :Customer, foreign_key: :customer_id
  has_many :expenses
  has_many :memberships
  has_many :members, through: :memberships, source: :customer
  has_many :ownerships
  has_many :admins, through: :ownerships, source: :customer
end
