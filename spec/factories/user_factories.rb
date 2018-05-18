FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters }
    nrp { Faker::Lorem.characters }
    email { Faker::Lorem.characters }
    phone_number { Faker::Lorem.characters }
    password { Faker::Lorem.characters }
  end
end
