class Registrar
  def register_or_update_user(user_attributes: )
    user = User.find_or_create_by(nrp: user_attributes[:nrp])
    user.update_attributes(user_attributes)
  end

  def register_reservation(reservation_attributes:)
    reservation = Reservation.new(reservation_attributes)
    reservation.save!
  end
end
