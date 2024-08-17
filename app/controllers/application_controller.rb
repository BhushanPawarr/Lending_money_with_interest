class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

# Override Devise's after sign-in path
  def after_sign_in_path_for(resource)
    if resource.admin?
      dashboard_path
    else
      user_path(resource)
    end
  end

  def create_loan_adjustments(loan)
    loan.adjustments.create!(
      amount: loan.amount,
      interest_rate: loan.interest_rate,
      made_by: current_user.email ,
      status: loan.status
    )
  end
end
