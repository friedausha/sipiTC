class Registrar
  def initialize(user_attributes:, reservation_attributes:)
    @user_attributes = user_attributes
    @reservation_attributes = reservation_attributes
  end

  def register_or_update_user
    user = User.find_or_create_by(nrp: @user_attributes[:nrp])
    user.update_attributes(@user_attributes)
  end

  def register_reservation
    Reservation.create!(@reservation_attributes)
  end
end
