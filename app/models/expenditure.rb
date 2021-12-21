# frozen_string_literal: true

class Expenditure < ApplicationRecord
  belongs_to :expense
  belongs_to :expensable, polymorphic: true
  has_one :transactions, as: :transactionable
end
