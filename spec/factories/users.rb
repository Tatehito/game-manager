FactoryBot.define do
  factory :user do
    provider {"Twitter"}
    uid {"1"}
    user_name {"tatehito"}
  end

  factory :another_user do
    provider {"Twitter"}
    uid {"2"}
    user_name {"another"}
  end
end