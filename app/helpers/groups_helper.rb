module GroupsHelper
  def group_owner? group
    current_customer == group.owner
  end

  def authorize_to_edit_expense? group, expense
    group_owner?(group) || expense_owner?(current_customer, expense)
  end
end
