class CalculateInterestJob < ApplicationJob
  queue_as :default

  def perform
    Loan.open.find_each do |loan|
      calculate_interest(loan)
    end
  end

  private
  def calculate_interest(loan)
    time_since_last_calculation = Time.current - loan.last_interest_calculated_at
    # Convert annual rate to per-minute rate
    interest_rate_per_minute = (loan.interest_rate / 100.0) / (60.0 * 24) 
    # Calculate interest accrued
    interest = loan.amount * interest_rate_per_minute * (time_since_last_calculation / 60)

    loan.update(
      total_interest: loan.total_interest + interest,
      last_interest_calculated_at: Time.current
    )
  end
end
