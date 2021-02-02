class UserUsage < ApplicationRecord
  validates :path, presence: true
  validates :number_of_clicks,
            presence: true, numericality: { only_integer: true }
end
