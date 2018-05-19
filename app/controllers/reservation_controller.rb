class ReservationController < ApplicationController
  def create
    permitted = Authenticator.new(authorization: request.headers['Authorization']).user_permitted?
    return render json: { status: 403 } unless permitted
    inventory = Inventory.find(params['inventory'])
    return render json: { status: 404 } unless inventory
    reservation_attributes = {
        user: User.find_by(nrp: params['nrp']),
        inventory: inventory,
        start_date: params['start_date'],
        end_date: params['end_date'],
        reason: params['reason'],
        status: 0
    }
    registrar = Registrar.new
    reservation = registrar.register_reservation(reservation_attributes: reservation_attributes)
    Mailers.new.new_reservation_email(inventory.laboratory)
    return render json: { status: 200 } if reservation.present?
    render json: { status: 300 }
  end

  def show
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).permitted?
    return render json: { status: 403 } unless permitted

    laboratory = Laboratory.where(name: params['id'])
    return render json: { status: 404 } unless laboratory
    inventory = Inventory.where(laboratory: laboratory).all
    reservation = Reservation.where(inventory: inventory).all
    render json: { status: 200, body: reservation }
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
