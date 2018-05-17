require 'rails_helper'

RSpec.describe Inventory, type: :model do
  subject { create :inventory }
  it { should validate_presence_of(:spec) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:name) }
  it { should belong_to(:laboratory) }
  it { should have_many(:reservations) }

  describe '#change_available_dates' do
    it 'change reservation start and end' do
      start_date = Faker::Date.between(2.weeks.ago, Date.today)
      end_date = Faker::Date.between(Date.tomorrow, Date.today+2.weeks)

      inventory = create :inventory
      inventory.change_available_dates(reservation_started: start_date,
      reservation_ended: end_date)

      expect(inventory.reload.reservation_started).to eq(start_date)
      expect(inventory.reload.reservation_ended).to eq(end_date)
    end
  end

  describe '.list_available' do
    it 'returns array of available inventories' do
      create :inventory
      create :inventory
      create :inventory
      create :inventory, reservation_ended: Date.tomorrow, status: 1
      create :inventory, reservation_ended: Date.yesterday, status: 1

      list = Inventory.list_available(date: Date.today)
      expect(list.length).to eq(4)
    end
  end
end
