FactoryBot.define do
  factory :game do
    association :user
    asin { 1 }
    status { 1 }
    title { 'dummy game' }
    image { 'https://dummy/images.jpg' }
  end
end
