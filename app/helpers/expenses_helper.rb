module ExpensesHelper
  def back_to_expenses_or_group_path group
    if group.present?
      group_path(group)
    else
      expenses_path
    end
  end
end
