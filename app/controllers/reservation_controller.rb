class ReservationController < ApplicationController
  def create
    registrar = Registrar.new
    user_attributes = {
      nrp: params['nrp'],
      email: params['email'],
      phone_number: params['phone_number'],
      name: params['name']
    }
    registrar.register_or_update_user(user_attributes:
    user_attributes)
    user = User.find_by(nrp: params['nrp'])
    return render json: {status: 400} unless user
    inventory = Inventory.find_by!(name: params['inventory'])
    reservation_attributes = {
      user: user,
      inventory: inventory,
      start_date: params['start_date'],
      end_date: params['end_date'],
      reason: params['reason']
    }
    reservation = registrar.register_reservation(reservation_attributes:
    reservation_attributes)
    return render json: { status: 400} unless reservation.valid?
    Mailers.new.new_reservation_email(inventory.laboratory)
    render json: { status: 200 }
  end

  def update
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).permitted?
    return render json: { status: 403 } unless permitted

    reservation = Reservation.find_by(id: params['id'])
    reservation.update_status(status: params['status'])
    inventory = reservation.inventory
    if params['status'] == '1'
        # UsersMailer.reservation_accepted_email(user: reservation.user).deliver_now
        inventory.update_attributes!(status: 1)
        inventory.change_available_dates(reservation_started: reservation.start_date,
                                        reservation_ended: reservation.end_date)
    else
      inventory.update_attributes!(status: params['status'])
      # UsersMailer.reservation_rejected_email(user: reservation.user).deliver_now
    end
    return render json: { status: 200 }
  end
end
