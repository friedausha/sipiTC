class UserController < ApplicationController
  def create
    registrar = Registrar.new
    user_attributes = {
        nrp: params['nrp'],
        email: params['email'],
        phone_number: params['phone_number'],
        name: params['name'],
        password: params['password']
    }
    registrar.register_or_update_user(user_attributes: user_attributes)
    render json: { status: 200 }
  end

  def update
    permitted = Authenticator.new(authorization:
      request.headers['Authorization']).user_permitted?
    return render json: { status: 403 } unless permitted

    user = User.where(id: params['id']).first
    return render json: { status: 404 } unless user

    user.update_attributes(name: params['name']) if params['name']
    user.update_attributes(nrp: params['nrp']) if params['nrp']
    user.update_attributes(email: params['email']) if params['email']
    user.update_attributes(password: params['password']) if params['password']
    user.update_attributes(phone_number: params['phone_number']) if params['phone_number']
    render json: { status: 200 }
  end
end
