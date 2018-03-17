FactoryBot.define do
  factory :admin do
    name { Faker::Lorem.characters }
    nrp { Faker::Lorem.characters }
    email { Faker::Lorem.characters }
    phone_number { Faker::Lorem.characters }
    laboratory
  end
end
