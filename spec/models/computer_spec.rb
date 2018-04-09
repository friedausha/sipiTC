require 'rails_helper'

RSpec.describe Computer, type: :model do
  subject { create :computer }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:spec) }
  it { should validate_presence_of(:status) }
  it { should belong_to(:laboratory) }
  it { should have_many(:reservations) }

  describe '#change_status' do
    it 'updates status' do
      computer = create :computer
      status = Random.rand(1..1000)
      computer.change_status(status: status)
      expect(computer.reload.status).to eq(status)
    end
  end

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

      list = Computer.list_available
      expect(list.length).to eq(3)
    end
  end

  describe '#change_spec_and_note' do
    it 'changes spec and note' do
      spec = Faker::Lorem.characters
      note = Faker::Lorem.characters

      computer = create :computer
      computer.change_spec_and_note(spec: spec, note: note)

      expect(computer.reload.spec).to eq(spec)
      expect(computer.reload.note).to eq(note)
    end
  end
end
