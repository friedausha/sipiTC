FactoryBot.define do
  factory :computer do
    number { Faker::Lorem.characters }
    spec { Faker::Lorem.characters }
    note { Faker::Lorem.sentence }
    # reservation_started { Faker::Date.between(1.year.ago, 2.weeks.ago)}
    # reservation_ended { Faker::Date.between(1.week.ago, Date.today+1.year) }
    status 0
    laboratory
  end
end
