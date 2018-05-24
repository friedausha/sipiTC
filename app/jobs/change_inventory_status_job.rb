class ChangeInventoryStatusJob < ApplicationJob
  queue_as :default

  def perform
    Inventory.where('reservation_ended <= ?', Date.today).update_all(
    status: 'Belum Dipinjam',
    reservation_started: nil, reservation_ended: nil)
  end
end
