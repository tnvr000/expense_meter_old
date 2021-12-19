# frozen_strinf_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_customer!

  # GET /accounts
  # before_action :authenticate_customer
  def show
    @account = current_customer.account
    @cash = @account.cash
  end
end
