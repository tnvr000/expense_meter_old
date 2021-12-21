# frozen_string_literal: true

class Bank < ApplicationRecord
  belongs_to :account
  has_many :expenditures, as: :expensable
end
