# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account
  belongs_to :transactionable, polymorphic: true
end
