class Account < ApplicationRecord
  has_secure_token

  validates :id,
            presence: true,
            numericality: { only_integer: true },
            uniqueness: true
  validates :name, presence: true
  validates :balance, presence: true, numericality: { only_integer: true }
  validates :token, presence: true, uniqueness: { case_sensitive: true }
end
