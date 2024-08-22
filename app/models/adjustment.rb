class Adjustment < ApplicationRecord
  belongs_to :loan
  belongs_to :user
  validates :amount, :interest_rate, :made_by, presence: true
end
