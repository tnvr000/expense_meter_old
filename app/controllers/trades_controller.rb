# frozen_string_literal: true

# trades contoller
class TradesController < ApplicationController
  before_action :authenticate_customer!

  # GET /trades
  # befeore_action :authenticate_customer!
  def show
    @trades = current_customer.account.trades
  end
end
