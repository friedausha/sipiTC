class ReservationUpdater

attr_reader :reservation
  def initialize(reservation: )
    @reservation = reservation
  end

  def update_status(status: )
    reservation.update(status: status)
  end
end
