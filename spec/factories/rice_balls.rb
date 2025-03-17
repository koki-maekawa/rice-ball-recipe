FactoryBot.define do
  factory :rice_ball do
    title { Faker::Food.dish }
    description { Faker::Lorem.sentence }
    user

    after(:build) do |rice_ball|
      rice_ball.image.attach(io: File.open('./spec/factories/test_image/onigiri.png'), filename: 'onigiri.png')
    end

    trait :with_ingredients_and_steps do
      after(:create) do |rice_ball|
        create_list(:ingredient, 2, rice_ball: rice_ball)
        create_list(:step, 2, rice_ball: rice_ball)
      end
    end
  end
end
