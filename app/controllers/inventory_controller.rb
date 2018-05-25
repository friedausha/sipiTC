class InventoryController < ApplicationController
  def create
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).permitted?
    return render json: { status: 403 } unless permitted

    laboratory = Laboratory.find_by(name: params['laboratory'])
    return render json: { status: 404 } unless laboratory

    return render json: { status: 404 } unless params['name'] && params['spec']
    Inventory.create!(laboratory_id: laboratory.id, name: params['name'],
    spec: params['spec'], status: 'Belum Dipinjam')
    inventory = Inventory.find_by(name: params['name'])
    inventory.update_attributes(note: params['note']) if params['note']
    render json: { status: 200 }
  end

  def show
    laboratory = Laboratory.find_by(name: params['id'])
    inventory = Inventory.where(laboratory: laboratory).all
    return render json: { status: 404 } unless inventory
    render json: { status: 200,  body: inventory }
  end

  def update
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).permitted?
    return render json: { status: 403 } unless permitted

    inventory = Inventory.where(id: params['id']).first
    return render json: { status: 404 } unless inventory

    inventory.update_attributes(spec: params['spec']) if params['spec']
    inventory.update_attributes(note: params['note']) if params['note']
    inventory.update_attributes(name: params['name']) if params['name']
    inventory.update_attributes(status: params['status']) if params['status']
    inventory.update_attributes(reservation_started:
    params['reservation_started']) if params['reservation_started']
    inventory.update_attributes(reservation_ended:
    params['reservation_ended']) if params['reservation_ended']
    return render json: { status: 200 }
  end

  def destroy
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).permitted?
    return render json: { status: 403 } unless permitted

    inventory = Inventory.where(id: params['id']).first
    inventory.destroy!
    render json: { status: 200 }
  end
end
