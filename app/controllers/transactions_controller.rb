# frozen_string_literal: true

# transactions contoller
class TransactionsController < ApplicationController
  before_action :authenticate_customer!

  # GET /transactions
  # befeore_action :authenticate_customer!
  def show
    @transactions = current_customer.account.transactions
  end
end
