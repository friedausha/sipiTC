class ChangeInventoryStatusJob < ApplicationJob
  queue_as :default

  def perform
    Inventory.where('reservation_ended <= ?', Date.today).update_all(status: 0,
    reservation_started: nil, reservation_ended: nil)
  end
end
