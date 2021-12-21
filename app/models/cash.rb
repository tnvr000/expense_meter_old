# frozen_string_literal: true

class Cash < ApplicationRecord
  belongs_to :account
  has_many :expenditures, as: :expensable
end
