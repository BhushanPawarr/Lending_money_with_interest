
class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :loans
  has_many :adjustments
  enum role: { user: 0, admin: 1 }

  validates :wallet_balance, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_initialize :set_default_balance, if: :new_record?

  def admin?
    self.role == 'admin'
  end

  private

  def set_default_balance
    if self.role == 'admin'
      self.wallet_balance ||= 1_000_000
    else
      self.wallet_balance ||= 10_000
    end
  end
 
end
