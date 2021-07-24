class ExpensesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_expense, only: %i[show edit update destroy]

  # GET /expenses
  # GET /expenses.json
  # before_action: authenticate_customer!
  def index
    @expenses = current_customer.expenses.includes(:customer)
  end

  # GET /expenses/1
  # GET /expenses/1.json
  # @param id [String]
  # before_action: authenticate_customer! set_expense
  def show; end

  # GET /expenses/new
  # before_action: authenticate_customer!
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  # @param id [String]
  # before_action: authenticate_customer! set_expense
  def edit; end

  # POST /expenses
  # POST /expenses.json
  # @param title [String]
  # @param amount [String]
  # @param description [String]
  # before_action: authenticate_customer!
  def create
    @expense = current_customer.expenses.build(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to(@expense, notice: 'Expense was successfully created.') }
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
        format.html { redirect_to(expense_path(@expense, group_id: @group.try(:id)), notice: 'Expense was successfully updated.') }
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
      format.html { redirect_to(show_expenses_or_group_url(@group), notice: 'Expense was successfully destroyed.') }
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
        current_customer.expenses.includes(:customer).find(params[:id])
      end
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:title, :amount, :description)
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
end
