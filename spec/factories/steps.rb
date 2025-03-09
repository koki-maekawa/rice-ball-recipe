FactoryBot.define do
  factory :step do
    description { Faker::Lorem.sentence }
    sequence(:step_number) { |n| n }
    rice_ball
  end
end
