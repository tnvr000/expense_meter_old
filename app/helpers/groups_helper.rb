module GroupsHelper
  # checks if the given member is the admin of given group
  # @param member [Customer]
  # @param group [Group]
  def group_admin? member, group
    group.admins.pluck(:id).include?(member.id)
  end

  # checks if the given member of the given group is authorized to edit the given expense
  # @param member [Customer]
  # @param group [Group]
  # @param expense [Expense]
  def authorize_to_edit_expense? member, group, expense
    group_admin?(member, group) || expense_owner?(member, expense)
  end

  # return the name, or email if name is not present, who created the given group
  # @param group [Group]
  def group_creator_name group
    group.created_by.try(:email) || group.customer_email
  end

  # return text to be displayed on button that removes a member
  # @param member [customer]
  # @return String
  def remove_member_button_name member
    member.id == current_customer.id ? 'Leave' : 'Remove'
  end

  # return text to be displayed on button that revoke adminship
  # @param member [Customer]
  # @return Button Text[String]
  def revoke_adminship_button_name member
    member.id == current_customer.id ? 'Denounce Adminship' : 'Demote To Menber'
  end
end
