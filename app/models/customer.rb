class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses
  has_many :my_groups, class_name: :Group, foreign_key: :customer_email, primary_key: :email
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :ownerships
  has_many :owner_of_groups, through: :ownerships, source: :group
  has_many :tags
end
