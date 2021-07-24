module ExpensesHelper
  # checks is Back button should link to show group page or index expenses page
  # @param group [Group]
  # @return group or expense path
  def back_to_expenses_or_group_path(group)
    group.present? ? group_path(group) : expenses_path
  end
end
