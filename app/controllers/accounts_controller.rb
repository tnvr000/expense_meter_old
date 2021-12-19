# frozen_string_literal: true

# accouts controller
class AccountsController < ApplicationController
  before_action :authenticate_customer!

  # GET /accounts
  # before_action :authenticate_customer
  def show
    @account = current_customer.account
    @cash = @account.cash
    @banks = @account.banks
    @ewallets = @account.ewallets
  end
end
