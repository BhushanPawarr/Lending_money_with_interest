class Adjustment < ApplicationRecord
  belongs_to :loan
  validates :amount, :interest_rate, :made_by, presence: true
end
