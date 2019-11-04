FactoryBot.define do
  factory :game do
    uid { 1 }
    asin { 1 }
    status { 1 }
    platform { 1 }
    evaluation { 1 }
    memo { "MyText" }
    play_time { 1 }
  end
end
