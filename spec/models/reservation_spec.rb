require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject { create :reservation }
  it { should validate_presence_of(:reason) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:end_date) }
  it { should belong_to(:user) }
  it { should belong_to(:inventory) }

  describe '#update_status' do
    it 'updates status' do
      reservation = create :reservation
      status = Faker::Lorem.characters
      reservation.update_status(status: status)
      expect(reservation.reload.status).to eq(status)
    end
  end
end
