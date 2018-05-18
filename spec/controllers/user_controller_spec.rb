require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let(:user) { create :user }
  let(:headers) do
    { 'Authorization' => "#{user.nrp}" + ':' + "#{user.password}" }
  end
  let(:params) do
    {
        'name' => user.name,
        'nrp' => user.nrp,
        'phone_number' => user.phone_number,
        'email' => user.email,
        'password' => user.password
    }
  end
  describe '#create' do
    it 'creates new user' do
      post :create, params: params

      user1 = User.find_by(nrp: user.nrp)
      expect(User.all.count).to eq(1)
      expect(user1.password).to eq(user.password)
    end
  end
end