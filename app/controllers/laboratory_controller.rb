class LaboratoryController < ApplicationController
  def show
    @laboratory = Laboratory.where(name: params['id']).first
    raise ActiveRecord::RecordNotFound unless @laboratory
    computers = Computer.where(laboratory: @laboratory).all
    render json: { status: 200, body: computers }
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
end
