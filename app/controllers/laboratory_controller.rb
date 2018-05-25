class LaboratoryController < ApplicationController
  def show
    @laboratory = Laboratory.where(name: params['id']).first
    raise ActiveRecord::RecordNotFound unless @laboratory
    inventories = Inventory.where(laboratory: @laboratory).all
    render json: { status: 200, body: inventories }
  end

  def update
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).permitted?
    return render json: { status: 403 } unless permitted

    laboratory = Laboratory.find_by(id: params['id'])
    return render json: { status: 404 } unless laboratory

    laboratory.update_attributes(password: params['password']) if params['password']
    laboratory.update_attributes(email: params['email']) if params['email']
    laboratory.update_attributes(name: params['name']) if params['name']

    return render json: { status: 200 }
  end

  def create
    permitted = Authenticator.new(authorization:
                                  request.headers['Authorization']).permitted?
    laboratory = Laboratory.find_by(name: request.headers['Authorization'].split(':')[0])
    return 404 unless laboratory
    return render json: { status: 403 } unless permitted
    render json: { status: 200 , body: laboratory }
  end
end
