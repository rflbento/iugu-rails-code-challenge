FactoryBot.define do
  factory :transfer do
    account { create(:account) }
    amount { 1000 }
  end
end
