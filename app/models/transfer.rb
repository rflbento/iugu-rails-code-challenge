class Transfer < ApplicationRecord
  belongs_to :account

  validates :amount,
            presence: true,
            numericality: { only_integer: true }
end
