# frozen_string_literal: true

# profiles controller
class ProfilesController < ApplicationController
  before_action :authenticate_customer!

  # GET /profiles
  # before_action :authenticate_customer!
  def show
    @profile = current_customer.profile
  end
end
