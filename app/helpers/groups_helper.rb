module GroupsHelper
  def group_admin? customer, group
    group.admins.pluck(:id).include?(customer.id)
  end

  def authorize_to_edit_expense? customer, group, expense
    group_admin?(customer, group) || expense_owner?(customer, expense)
  end

  def group_creator_name group
    group.created_by.try(:email) || group.customer_email
  end
end
