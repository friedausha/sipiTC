require 'rails_helper'

RSpec.describe ChangeInventoryStatusJob, type: :job do
  describe '#perform' do
    it 'changes status of unavailable inventory' do
      tomorrow = Date.tomorrow
      com1 = create :inventory, reservation_ended: 2.days.ago
      com2 = create :inventory, reservation_ended: tomorrow

      ChangeInventoryStatusJob.perform_now

      expect(com1.reload.reservation_ended).to eq(nil)
      expect(com1.reload.status).to eq(0)
      expect(com2.reload.reservation_ended).to eq(tomorrow)
    end
  end
end
