class AddInterestTrackingToLoans < ActiveRecord::Migration[7.0]
  def change
    add_column :loans, :total_interest, :decimal
    add_column :loans, :last_interest_calculated_at, :datetime
  end
end
