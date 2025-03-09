FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    amount { Faker::Food.measurement }
    rice_ball
  end
end
