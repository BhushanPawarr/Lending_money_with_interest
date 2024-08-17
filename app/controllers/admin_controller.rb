class AdminController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @loans = Loan.order(created_at: :desc).limit(10) 
  end

  def show_loan
    @loan = Loan.find_by(id: params[:id])
    if @loan.nil?
      redirect_to dashboard_path, alert: 'Loan not found.'
    end
  end

  def approve_loan
    @loan = Loan.find(params[:id])
    if @loan.update(status: :approved)
      redirect_to dashboard_path, notice: 'Loan approved.'
    else
      redirect_to dashboard_path, alert: 'Unable to approve loan.'
    end
  end

  def reject_loan
    @loan = Loan.find(params[:id])
    if @loan.update(status: :rejected)
      redirect_to dashboard_path, notice: 'Loan rejected.'
    else
      redirect_to dashboard_path, alert: 'Unable to reject loan.'
    end
  end

  def adjust_loan
    @loan = Loan.find(params[:id])
    if @loan.update(loan_params.merge(status: :waiting_for_adjustment_acceptance))
      redirect_to dashboard_path, notice: 'Loan adjustment requested.'
    else
      redirect_to dashboard_path, alert: 'Unable to adjust loan.'
    end
  end

  def handle_readjustment_request
    @loan = Loan.find(params[:id])

    if params[:reject] == 'true'
      @loan.update(status: :rejected)
      redirect_to dashboard_path, notice: 'Loan has been rejected.'
    else
      if @loan.update(loan_params.merge(status: :waiting_for_adjustment_acceptance))
        redirect_to dashboard_path, notice: 'Adjustment made. Waiting for user acceptance.'
      else
        redirect_to dashboard_path, alert: 'Unable to make adjustment.'
      end
    end
  end
  
  private

  def loan_params
    params.permit(:amount, :interest_rate)
  end
end
