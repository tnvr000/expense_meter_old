# frozen_string_literal: true

class Trade < ApplicationRecord
  belongs_to :account
  belongs_to :tradable, polymorphic: true
end
