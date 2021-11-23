module ExpensesHelper
  # checks is Back button should link to show group page or index expenses page
  # @param group [Group]
  # @return group or expense path
  def back_to_expenses_or_group_path(group)
    group.present? ? group_path(group) : expenses_path
  end

  # returns tags belonging to given expense
  # @param expense [Expense]
  # @return tags [String]
  def print_tags(expense)
    expense.tags.map(&:name).join(', ')
  end

  # return ID for 'for' attribute of label and tag checkbox
  # @param tag [Tag]
  # @return tag checkbox ID [String]
  def tag_checkbox_id(tag)
    "expense_tag_#{tag.id}"
  end

  # returns options for stimulus category controller
  # @param expense [Expense]
  # @return ananomous [Hash]
  def stimulus_category_controller_options expense
    {
      'data-controller' => 'category',
      'data-category-selected-primary-category-value' => expense.try(:category).try(:primary_category).try(:id),
      'data-category-selected-category-value' => expense.try(:category).try(:id)
    }
  end
end
