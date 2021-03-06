FactoryBot.define do
  factory :inventory do
    spec { Faker::Lorem.characters }
    note { Faker::Lorem.sentence }
    name { Faker::Lorem.characters }
    # reservation_started { Faker::Date.between(1.year.ago, 2.weeks.ago)}
    # reservation_ended { Faker::Date.between(1.week.ago, Date.today+1.year) }
    status { 'Belum Dipinjam' }
    laboratory
  end
end
