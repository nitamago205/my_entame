FactoryBot.define do
  factory :my_select do
    title { Faker::Lorem.characters(number:20) }
    body { Faker::Lorem.characters(number:100) }
    post
  end
end