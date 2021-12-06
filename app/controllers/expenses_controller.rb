class ExpensesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_expense, only: %i[show edit update destroy]

  # GET /expenses
  # GET /expenses.json
  # before_action: authenticate_customer!
  def index
    @expenses = current_customer.expenses.includes(:customer, :tags, category: :primary_category)
  end

  # GET /expenses/1
  # GET /expenses/1.json
  # @param id [String]
  # before_action: authenticate_customer! set_expense
  def show
    @tags = @expense.tags
  end

  # GET /expenses/new
  # before_action: authenticate_customer!
  def new
    @expense = Expense.new
    @tags = current_customer.tags
    @primary_categories = PrimaryCategory.pluck(:name, :id)
  end

  # GET /expenses/1/edit
  # @param id [String]
  # before_action: authenticate_customer! set_expense
  def edit
    @tags = current_customer.tags
    @primary_categories = PrimaryCategory.pluck(:name, :id)
  end

  # POST /expenses
  # POST /expenses.json
  # @param title [String]
  # @param amount [String]
  # @param description [String]
  # @param category [Integer]
  # @param tags [Array<Integer>]
  # before_action: authenticate_customer!
  def create
    @expense = current_customer.expenses.build(expense_params)
    respond_to do |format|
      if @expense.save
        @expense.add_tags(expense_tags(params[:expense][:tag_ids]))
        format.html { redirect_to(@expense, notice: t('expenses.created')) }
        format.json { render(:show, status: :created, location: @expense) }
      else
        format.html { render(:new) }
        format.json { render(json: @expense.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  # @param title [String]
  # @param amount [String]
  # @param description [String]
  # before_action: authenticate_customer! set_expense
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        @expense.manage_tags(expense_tags(params[:expense][:tag_ids]))
        format.html { redirect_to(expense_path(@expense, group_id: @group.try(:id)), notice: t('expenses.updated')) }
        format.json { render(:show, status: :ok, location: @expense) }
      else
        format.html { render(:edit) }
        format.json { render(json: @expense.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  # @param id [String]
  # before_action: authenticate_customer! set_expense
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to(show_expenses_or_group_url(@group), notice: t('expenses.deleted')) }
      format.json { head(:no_content) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense =
      if authorized_customer?
        @group = Group.find_by(id: params[:group_id])
        Expense.where(id: params[:id], group_id: params[:group_id]).first
      else
        current_customer.expenses.includes(:customer, :tags, category: :primary_category).find(params[:id])
      end
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:title, :amount, :description, :category_id)
  end

  # checks if expense is accessed via a group and if it has authorisation to access the expense
  # All the members of group of which the expense belongs to is authorized
  def authorized_customer?
    params[:group_id].present? && Membership.exists?(group_id: params[:group_id], customer_id: current_customer.id)
  end

  # checks if control should go back to show group page or index expense page
  # @param group [Group]
  def show_expenses_or_group_url(group)
    group.present? ? group_url(group) : expenses_url
  end

  # retrive tags of given ids from along the current_customer tags
  # @param tag_ids [Array]
  # return tags
  def expense_tags(tag_ids)
    current_customer.tags.where(id: tag_ids)
  end
end
