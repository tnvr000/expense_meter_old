# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :customer
  has_one :cash
  has_many :banks
end
