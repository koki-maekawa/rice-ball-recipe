FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 8) }
    password_confirmation { password }
    reset_password_token { nil }
    reset_password_sent_at { nil }
    policies_agreed { true }
  end
end
