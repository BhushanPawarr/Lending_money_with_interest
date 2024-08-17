class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @recent_loan = current_user.loans.order(created_at: :desc).first if current_user.user?
  end
  
  def new
    @loan = Loan.new
  end

  def request_loan
    Rails.logger.info "Params: #{params.inspect}"
    @loan = current_user.loans.new(loan_params)
    @loan.status = :requested
    if @loan.save
      redirect_to user_path(current_user), notice: 'Loan request submitted.'
    else
      render :new
    end
  end

  def loan_details
    @loan = current_user.loans.find(params[:id])
  end
  
  def accept_loan
    @loan = current_user.loans.find(params[:id])
    if @loan.approved? && @loan.update(status: :open)
      current_user.update(wallet_balance: current_user.wallet_balance + @loan.amount)
      User.admin.first.update(wallet_balance: User.admin.first.wallet_balance - @loan.amount)
      redirect_to user_path(current_user), notice: 'Loan accepted.'
    else
      redirect_to user_path(current_user), alert: 'Unable to accept loan.'
    end
  end

  def reject_loan
    @loan = current_user.loans.find(params[:id])
    if @loan.update(status: :rejected)
      redirect_to user_path(current_user), notice: 'Loan rejected.'
    else
      redirect_to user_path(current_user), alert: 'Unable to reject loan.'
    end
  end

  def repay_loan
    @loan = current_user.loans.find(params[:id])
    repayment_amount = [current_user.wallet_balance, (@loan.total_amount).round(2)].min
    if repayment_amount > 0
      current_user.update(wallet_balance: current_user.wallet_balance - repayment_amount)
      User.admin.first.update(wallet_balance: User.admin.first.wallet_balance + repayment_amount)
      @loan.update(status: :closed)
      redirect_to user_path(current_user), notice: 'Loan repaid.'
    else
      redirect_to user_path(current_user), alert: 'Insufficient balance to repay the loan.'
    end
  end

  def accept_adjustment
    @loan = current_user.loans.find(params[:id])
    if @loan.waiting_for_adjustment_acceptance? && @loan.update(status: :open)
      current_user.update(wallet_balance: current_user.wallet_balance + @loan.amount)
      User.admin.first.update(wallet_balance: User.admin.first.wallet_balance - @loan.amount)
      redirect_to user_path(current_user), notice: 'Adjustment accepted and loan is now open.'
    else
      redirect_to user_path(current_user), alert: 'Unable to accept adjustment.'
    end
  end

  def reject_adjustment
    @loan = current_user.loans.find(params[:id])
    if @loan.waiting_for_adjustment_acceptance? && @loan.update(status: :rejected)
      redirect_to user_path(current_user), notice: 'Adjustment rejected and loan is now closed.'
    else
      redirect_to user_path(current_user), alert: 'Unable to reject adjustment.'
    end
  end

  def request_readjustment
    @loan = current_user.loans.find(params[:id])
    if @loan.waiting_for_adjustment_acceptance? && @loan.update(status: :readjustment_requested)
      redirect_to user_path(current_user), notice: 'Readjustment requested.'
    else
      redirect_to user_path(current_user), alert: 'Unable to request readjustment.'
    end
  end
  
  private

  def loan_params
    params.require(:loan).permit(:amount, :interest_rate)
  end
end
