require 'rails_helper'

RSpec.describe Computer, type: :model do
  subject { create :computer }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:spec) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:laboratory) }
  it { should have_many(:reservations) }

  describe '#change_available_dates' do
    it 'change reservation start and end' do
      start_date = Faker::Date.between(2.weeks.ago, Date.today)
      end_date = Faker::Date.between(Date.tomorrow, Date.today+2.weeks)

      computer = create :computer
      computer.change_available_dates(reservation_started: start_date,
      reservation_ended: end_date)

      expect(computer.reload.reservation_started).to eq(start_date)
      expect(computer.reload.reservation_ended).to eq(end_date)
    end
  end

  describe '.list_available' do
    it 'returns array of available computers' do
      create :computer
      create :computer
      create :computer
      create :computer, reservation_ended: Date.tomorrow, status: 1
      create :computer, reservation_ended: Date.yesterday, status: 1

      list = Computer.list_available(date: Date.today)
      expect(list.length).to eq(4)
    end
  end
end
