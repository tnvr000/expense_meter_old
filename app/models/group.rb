# @author Tanveer Ahmad Khan
class Group < ApplicationRecord
  belongs_to :created_by, class_name: :Customer, foreign_key: :customer_email, primary_key: :email
  has_many :expenses
  has_many :memberships
  has_many :members, through: :memberships, source: :customer
  has_many :ownerships
  has_many :admins, through: :ownerships, source: :customer

  validates :token, presence: true

  # Checks if the given customer is a member of the associated group
  # @param customer [Customer]
  # @return Boolean
  def member_of_group? customer
    members.pluck(:id).include?(customer.id)
  end

  # Checks if the member is an admin of the associated group
  # @param member [Customer]
  # @return Boolean
  def member_an_admin? member
    admins.pluck(:id).include?(member.id)
  end

  # Checks if the associated group has at least 1 member
  # @return Boolean
  def multiple_members?
    members.count > 1
  end

  # Checks if the associated group has at least 1 admin
  # @return Boolean
  def multiple_admins?
    admins.count > 1
  end

  # Promotes the given member to be an admin of the associated group
  # @param member [Customer]
  # @return list of admins [Customer::ActiveRecord::Associations::CollectionProxy]
  def make_member_an_admin member
    admins << member
  end

  # Demotes the given admin to the a member of the associated group
  # @param admin [Customer]
  # @return Array containing demoted admin [Customer]
  def make_admin_a_member admin
    admins.delete(admin)
  end

  # Removes the given member from the associated group.
  # Also removes the given member from admin, if it was one 
  # @param member [Customer]
  # @return Array containing the removed member [Customer]
  def remove_member member
    make_admin_a_member(member) if member_an_admin?(member)
    members.delete(member)
  end

  # Make the given customer a member of the associated group
  # @params customer [Customer]
  # @return list of members including the given customer [Customer::ActiveRecord::Associations::CollectionProxy]
  def make_member customer
    members << customer
  end

  # Generates and saves a token that is used in sharable link to join group
  # @return Boolean
  def generate_token
    self.token = SecureRandom.urlsafe_base64
    save
  end
end
