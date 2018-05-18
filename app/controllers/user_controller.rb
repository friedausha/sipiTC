class UserController < ApplicationController
  def create
    registrar = Registrar.new
    user_attributes = {
        nrp: params['nrp'],
        email: params['email'],
        phone_number: params['phone_number'],
        name: params['name']
    }
    registrar.register_or_update_user(user_attributes: user_attributes)
  end

  def update

  end
end
