class GroupsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = current_customer.groups.includes(:creator)
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @expenses = @group.expenses.includes(:customer)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = current_customer.groups.build(group_params)

    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /groups/:id/promote_to_admin
  # POST /groups/:id/promote_to_admin.json
  def promote_to_admin
    group = current_customer.groups.includes(:members, :admins).find_by_id(params[:id])
    member = Customer.find_by_id(params[:member_id])
    if member_of_group?(member, group)
      make_member_an_admin(member, group)
    else
      flash[:alert] = t('groups.not_a_member')
    end
    redirect_to group_path(group)
  end

  # POST /groups/:id/demote_to_member
  # POST /groups/:id/demote_to_member.json
  def demote_to_member
    group = current_customer.groups.find_by_id(params[:id])
    admin = Customer.find_by_id(params[:member_id])
    if group_have_multiple_admins(group)
      if group.admins.delete(admin)
        flash[:notice] = t('groups.demoted_to_member')
      else
        flash[:alert] = t('groups.not_demoted_to_member')
      end
    else
      flash[:alert] = t('groups.last_admin')
    end
    redirect_to group_path(group)
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = current_customer.groups.includes(:creator, :admins).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name)
  end

  def member_of_group? member, group
    group.members.pluck(:id).include?(member.id)
  end

  def make_member_an_admin member, group
    if group.admins << member
      flash[:notice] = t('groups.promoted_to_admin')
    else
      flash[:alert] = t('groups.not_promoted_to_admin')
    end
  end

  def group_have_multiple_admins group
    group.admins.count > 1
  end
end
