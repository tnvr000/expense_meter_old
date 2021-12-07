# frozen_string_literal: true

# profiles controller
class ProfilesController < ApplicationController
  before_action :authenticate_customer!

  # GET /profile
  # before_action :authenticate_customer!
  def show
    @profile = current_customer.profile
  end

  # GET /profile/edit
  # before_action :authenticate_customer!
  def edit
    @profile = current_customer.profile
  end

  # PUT /profile
  # PATCH /profile
  # @param name [String]
  # @param name [String]
  # before_action :authenticate_customer!
  def update
    @profile = current_customer.profile
    @profile.assign_attributes(profile_params)
    respond_to do |format|
      if @profile.save
        format.html { redirect_to profile_url, notice: t('profiles.updated') }
      else
        format.html { render :edit }
      end
    end
  end

  private

  # only allow a list of trusted parameters through.
  def profile_params
    params.require(:profile).permit(:name, :contact)
  end
end
