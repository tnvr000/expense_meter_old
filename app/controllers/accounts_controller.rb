# frozen_strinf_literal: true

class AccountsController < ApplicationController
  before_action :authenticate_customer!

  # GET /accounts
  # before_action :authenticate_customer
  def index
    @account = current_customer.account
    @money_in_hand = @account.money_in_hand
  end
end
