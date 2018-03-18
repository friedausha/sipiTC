require 'rails_helper'

RSpec.describe ReservationUpdater do
  describe '#initialize' do
    it 'initialize updater' do
      reservation = create :reservation
      updater = ReservationUpdater.new reservation: reservation
      expect(updater).to_not be_nil
      expect(updater.reservation).to eq(reservation)
    end
  end

  describe '#update_status' do
    it 'updates status' do
      reservation = create :reservation
      updater = ReservationUpdater.new reservation: reservation
      status = Random.rand(1..100)
      updater.update_status(status: status)
      expect(reservation.reload.status).to eq(status)
    end
  end
end
