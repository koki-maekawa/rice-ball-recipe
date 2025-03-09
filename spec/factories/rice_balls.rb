FactoryBot.define do
  factory :rice_ball do
    title { Faker::Food.dish }
    description { Faker::Lorem.sentence }
    user

    after(:build) do |rice_ball|
      rice_ball.image.attach(io: File.open('./spec/factories/test_image/onigiri.png'), filename: 'onigiri.png')
    end
  end
end
