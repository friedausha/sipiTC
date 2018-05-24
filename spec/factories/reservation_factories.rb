FactoryBot.define do
  factory :reservation do
    reason { Faker::Lorem.sentences }
    start_date { Faker::Date.between(1.year.ago, 2.days.ago) }
    end_date { Faker::Date.between(Date.today, Date.today + 1.year) }
    status { 'Belum Diterima' }
    user
    inventory
  end
end
