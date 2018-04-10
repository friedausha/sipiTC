class ComputerController < ApplicationController
  def create
  end

  def show
    computer = Computer.find_by(id: params['id'])
    return render json: { status: 404 } unless computer
    render json: { status: 200,  body: computer }
  end

  def update
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).permitted?
    return render json: { status: 403 } unless permitted

    computer = Computer.where(id: params['id']).first
    return render json: { status: 404 } unless computer

    computer.update_attributes(spec: params['spec']) if params['spec']
    computer.update_attributes(note: params['note']) if params['note']
    computer.update_attributes(name: params['name']) if params['name']
    computer.update_attributes(status: params['status']) if params['status']
    computer.update_attributes(reservation_started:
    params['reservation_started']) if params['reservation_started']
    computer.update_attributes(reservation_ended:
    params['reservation_ended']) if params['reservation_ended']
    return render json: { status: 200 }
  end

  def destroy
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).permitted?
    return render json: { status: 403 } unless permitted

    computer = Computer.where(id: params['id']).first
    computer.destroy!
  end
end
