class ChangeComputerStatusJob < ApplicationJob
  queue_as :default

  def perform
    Computer.where('reservation_ended <= ?', Date.today).update_all(status: 0,
    reservation_started: nil, reservation_ended: nil)
  end
end
