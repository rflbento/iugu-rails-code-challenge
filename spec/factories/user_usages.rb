FactoryBot.define do
  factory :user_usage do
    path { "https://foo.bar" }
    number_of_clicks { 1 }
  end
end
