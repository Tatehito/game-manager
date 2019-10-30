FactoryBot.define do
  factory :user do
    provider {"Twitter"}
    uid {"123456789"}
    user_name {"tatehito"}
  end
end