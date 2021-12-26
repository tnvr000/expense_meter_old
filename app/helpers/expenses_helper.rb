# frozen_string_literal: true

# module helper methods in expeneses view
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

  # returns ID for 'for' attribute of label and ID for account checkbox
  # @param account [Cash] [Bank] [Ewallet]
  # @return for attribute and sub_account checkbox ID [String]
  def sub_account_checkbox_id(account)
    "expense_sub_account_#{account.class.to_s.downcase}_#{account.id}"
  end

  # returns ID for sub amount textfield
  # @param account [Cash] [Bank] [Ewallet]
  # @return sub amount ID [String]
  def sub_account_amount_id(account)
    "expense_sub_amount_#{account.class.to_s.downcase}_#{account.id}"
  end

  # returns name for sub account checkbox
  # @param account [Cash] [Bank] [Ewallet]
  # @return sub account chechbox name [String]
  def sub_account_checkbox_name(account)
    "expense[sub_accounts][#{account.class.to_s.downcase}s][][id]"
  end

  # returns name for sub amount textfield
  # @param account [Cash] [Bank] [Ewallet]
  # @return sub amount text field name [String]
  def sub_account_amount_name(account)
    "expense[sub_accounts][#{account.class.to_s.downcase}s][][amount]"
  end

  # checks if given sub-account needs to be checked
  # @param account [Cash] [Bank] [Ewallet]
  # @param payment_from [Hash]
  # @return sub-account checked status [Boolean] 
  def sub_account_checked?(account, payment_from)
    payment_from[account.class.to_s.downcase].present? &&
      payment_from[account.class.to_s.downcase][account.id].present?
  end

  # returns amount for given sub-account if present
  # @param account [Cash] [Bank] [Ewallet]
  # @param payment_from [Hash]
  # @return amount [Integer]
  def sub_account_amount(account, payment_from)
    if sub_account_checked?(account, payment_from)
      payment_from[account.class.to_s.downcase][account.id]
    else
      ''
    end
  end

  # return options for sub-account checkbox
  # @param account [Cash] [Bank] [ewallet]
  # @param payment_from [Hash]
  # @return options for sub-account checkbox [Hash]
  def sub_account_checkbox_options(account, payment_from)
    {
      id: sub_account_checkbox_id(account),
      name: sub_account_checkbox_name(account),
      checked: sub_account_checked?(account, payment_from),
      autocomplete: 'off',
      'data-sub-account-target' => 'useSubAccount',
      'data-action' => 'change->sub-account#enable_amount',
      'data-sub-account-id-param' => sub_account_amount_id(account)
    }
  end

  # return options for sub-account amount textfield
  # @param account [Cash] [Bank] [ewallet]
  # @param payment_from [Hash]
  # @return options for sub-account amount [Hash]
  def sub_account_amount_options(account, payment_from)
    {
      id: sub_account_amount_id(account),
      name: sub_account_amount_name(account),
      class: 'hidden',
      disabled: true,
      autocomplete: 'off',
      value: sub_account_amount(account, payment_from)
    }
  end

  # returns options for stimulus category controller
  # @param expense [Expense]
  # @return ananomous [Hash]
  def stimulus_category_controller_options(expense)
    {
      'data-controller' => 'category',
      'data-category-selected-primary-category-value' => expense.try(:category).try(:primary_category).try(:id),
      'data-category-selected-category-value' => expense.try(:category).try(:id),
      'data-category-selected-options-value' => '0'
    }
  end
end
