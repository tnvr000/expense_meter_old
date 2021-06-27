class ExpensesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = current_customer.expenses.includes(:customer)
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
    
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = current_customer.expenses.build(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
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
end
