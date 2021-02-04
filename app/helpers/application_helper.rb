module ApplicationHelper
  def expense_owner? customer, expense
    expense.customer == customer
  end
end
