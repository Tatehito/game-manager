FactoryBot.define do
  factory :game do
    association :user
    asin { 1 }
    status { 1 }
  end
end
