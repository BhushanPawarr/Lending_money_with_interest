class CreateAdjustments < ActiveRecord::Migration[7.0]
  def change
    create_table :adjustments do |t|
      t.references :loan, null: false, foreign_key: true
      t.decimal :amount
      t.decimal :interest_rate
      t.string :made_by
      t.string :status

      t.timestamps
    end
  end
end
