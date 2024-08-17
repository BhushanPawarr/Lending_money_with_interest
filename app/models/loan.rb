class Loan < ApplicationRecord
  belongs_to :user
  has_many :adjustments, dependent: :destroy

  enum status: { requested: 0, approved: 1, open: 2, closed: 3, rejected: 4, waiting_for_adjustment_acceptance: 5, readjustment_requested: 6 }

  
  validates :amount, :interest_rate, :status, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :interest_rate, numericality: { greater_than_or_equal_to: 0 }

  # We can Calculate the total amount to be repaid (principal + interest)
  def total_amount
    amount + total_interest
  end
  # Set default values for new loans
  after_initialize :set_default_values

  private

  def set_default_values
    self.total_interest ||= 0
    self.last_interest_calculated_at ||= Time.current
  end 
end
