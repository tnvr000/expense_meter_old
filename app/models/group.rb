class Group < ApplicationRecord
  belongs_to :created_by, class_name: :Customer, foreign_key: :customer_email, primary_key: :email
  has_many :expenses
  has_many :memberships
  has_many :members, through: :memberships, source: :customer
  has_many :ownerships
  has_many :admins, through: :ownerships, source: :customer
end
