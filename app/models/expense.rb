class Expense < ApplicationRecord
  belongs_to :customer
  belongs_to :group, optional: true
end
