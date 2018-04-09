FactoryBot.define do
  factory :laboratory do
    name { Faker::Lorem.characters }
    email { Faker::Lorem.characters }
    password { Faker::Lorem.characters }
  end
end
