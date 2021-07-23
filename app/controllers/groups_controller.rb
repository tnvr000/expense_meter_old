class GroupsController < ApplicationController
  before_action :authenticate_customer!
  before_action -> { set_group(%i[created_by admins]) }, only: %i[show edit update destroy]
  before_action -> { set_group(%i[members admins]) }, only: [:promote_to_admin]
  before_action -> { set_group([:admins]) }, only: [:add_member]
  before_action -> { set_group([]) }, only: %i[demote_to_member remove_member make_member]
  before_action :authorize_membership!, only: %i[show edit promote_to_admin demote_to_member add_member remove_member make_member update destroy]
  before_action :authorize_adminship!, only: %i[promote_to_admin add_member]
  before_action -> { set_member({ id: params[:member_id] }) }, only: %i[promote_to_admin remove_member]
  before_action -> { set_member({ email: params[:email] }) }, only: [:make_member]
  before_action -> { set_admin({ id: params[:member_id] }) }, only: [:demote_to_member]
  before_action -> { authorize_member_removal!(@group, @member) }, only: [:remove_member]
  before_action -> { authorize_member_addition!(@group, @member) }, only: [:make_member]

  # GET /groups
  # GET /groups.json
  # before_action: authenticate_customer!
  def index
    @groups = current_customer.groups.includes(:created_by)
  end

  # GET /groups/:id
  # GET /groups/:id.json
  # @param id [String]
  # before_action: authenticate_customer! set_group([:created_by, :admin]) authorize_membership!
  def show
    @expenses = @group.expenses.includes(:customer)
  end

  # GET /groups/new
  # before_action: authenticate_customer!
  def new
    @group = Group.new
  end

  # GET /groups/:id/edit
  # @param id[String]
  # before_action: authenticate_customer! set_group([:created_by, :admin]) authorize_membership!
  def edit
  end

  # POST /groups
  # POST /groups.json
  # @param name [String]
  # before_action: authenticate_customer!
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
  # @param id [String]
  # @param member_id [String]
  # before_action: authenticate_customer! set_group([:member, :admin]) authorize_membership! authorize_adminship!
  #   set_member({id: params[:member_id]})
  def promote_to_admin
    if @group.member_of_group?(@member)
      make_member_an_admin(@member, @group)
    else
      flash[:alert] = t('groups.not_a_member')
    end
    redirect_to group_path(@group)
  end

  # POST /groups/:id/demote_to_member
  # POST /groups/:id/demote_to_member.json
  # @param id [String]
  # @param admin_id [String]
  # before_action: authenticate_customer! set_group() authorize_membership! set_admin({id: params[:member_id]})
  def demote_to_member
    if @group.multiple_admins?
      make_admin_a_member(@admin, @group)
    else
      flash[:alert] = t('groups.last_admin')
    end
    redirect_to group_path(@group)
  end

  # GET /groups/:id/add_member
  # @param id [String]
  # before_action: authenticate_customer! set_group([:admins]) authorize_membership! authorize_adminship!
  def add_member
    @group.generate_token if @group.token.blank?
  end

  # POST /groups/:id/remove_member
  # @param id [String]
  # @param member_id [String]
  # before_action: authenticate_customer! set_group() authorize_membership! set_member({id: params[:member_id]})
  #   authorize_member_removal!(@group, @member)
  def remove_member
    @group.remove_member(@member)
    redirect_to(group_path(@group), alert: 'Member removed.')
  end

  # POST /groups/:id/make_member
  # @param id [String]
  # @param email [String]
  # before_action: authenticate_customer! set_group() authorize_membership! authorize_adminship!
  #   set_member({email: params[:email]}) authorize_member_addition!(@group, @member)
  def make_member
    @group.make_member(@member)
    redirect_to(group_path(@group), notice: 'Member is added')
  end

  # GET /groups/:id/invitation
  # @param id
  # @param token
  # before_action: authenticate_customer!
  def invitation
    @group = Group.where('groups.id = ? AND groups.token = ?', params[:id], params[:token]).first
    redirect_to(root_path) and return if @group.blank?
    redirect_to(group_path(@group), notice: 'Already a member') and return if @group.member_of_group?(current_customer)

    @member_count = @group.members.count
  end

  # POST /groups/:id/accept_invitation
  # @param id[String]
  # before_action: authenticate_customer!
  def accept_invitation
    @group = Group.find_by(id: params[:id])
    redirect_to(root_path) and return if @group.blank?
    redirect_to(group_path(@group), notice: 'Already a member') and return if @group.member_of_group?(current_customer)

    @group.members << current_customer
    redirect_to(group_path(@group), notice: 'Became a member')
  end

  # PATCH/PUT /groups/:id
  # PATCH/PUT /groups/:id.json
  # @param id
  # @param name
  # before_action: authenticate_customer! set_group(:created_by, :admins) authorize_membership!
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

  # DELETE /groups/:id
  # DELETE /groups/:id.json
  # @param id
  # before_action: authenticate_customer! set_group(:created_by, :admins) authorize_membership!
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  # set group instance variable from list of groups of current_customer
  def set_group include_associations
    @group = current_customer.groups.includes(include_associations).find_by(id: params[:id])
  end

  # set member instance variable
  def set_member args
    @member = Customer.find_by(args)
  end

  # set admin instance variable
  def set_admin args
    @admin = Customer.find_by(args)
  end

  # checks if current customer is a member of group or not
  # group is retrived from list of groups the customer is member of.
  # If the @group is blank, it means the customer is not a member of this group
  def authorize_membership!
    redirect_to root_path, alert: 'Group not found.' if @group.blank?
  end

  # checks if the current customer is an admin of the group
  def authorize_adminship!
    redirect_to group_path(@group), alert: 'Not authorized' unless @group.member_an_admin?(current_customer)
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name)
  end

  # make the given member an admin of the given group
  # @param member [Customer]
  # @param group [Group]
  def make_member_an_admin member, group
    if group.make_member_an_admin(member)
      flash[:notice] = t('groups.promoted_to_admin')
    else
      flash[:alert] = t('groups.not_promoted_to_admin')
    end
  end

  # make the given admin a member of the given group
  # @param admin [Customer]
  # @param group [Group]
  def make_admin_a_member admin, group
    if group.make_admin_a_member(admin)
      flash[:notice] = t('groups.demoted_to_member')
    else
      flash[:alert] = t('groups.not_demoted_to_member')
    end
  end

  # checks if the given member is currently signed in customer
  # @param member [Customer]
  # @return Boolean
  def member_current_customer? member
    member.id == current_customer.id
  end

  # checks if the given member of the given group can be removed
  # @param group [Group]
  # @param member [Customer]
  # @return Boolean
  def member_removable? group, member
    status = false
    if member.blank?
      flash[:alert] = 'Member does not exists.'
    elsif !group.member_of_group?(member)
      flash[:alert] = 'Not a member.'
    elsif !group.multiple_members?
      flash[:alert] = 'You are the last member'
    elsif !group.member_an_admin?(current_customer) && !member_current_customer?(member)
      flash[:alert] = 'Unauthorized access'
    else
      status = true
    end
    status
  end

  # confirm member removability of member or redirect
  def authorize_member_removal! group, member
    redirect_to(group_path(group)) unless member_removable?(group, member)
  end

  # comfirm member addition of given member in given number
  def authorize_member_addition! group, member
    redirect_to(add_member_group_path(group), alert: 'Customer does not exists') and return if member.blank?

    redirect_to(group_path(group), alert: 'Already a member') if group.member_of_group?(member)
  end
end
