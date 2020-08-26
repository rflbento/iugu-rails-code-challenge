class Account < ApplicationRecord
  has_secure_token

  has_many :transfers, dependent: :nullify

  validates :account_number,
            presence: true,
            numericality: { only_integer: true },
            uniqueness: true
  validates :account_name, presence: true
  validates :initial_balance, presence: true, numericality: { only_integer: true }
  validates :token, presence: true, uniqueness: { case_sensitive: true }

  def balance
    initial_balance + transfers.sum(&:amount)
  end
end
