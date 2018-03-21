require 'rails_helper'

RSpec.describe Registrar do
  let(:nrp) { Faker::Lorem.characters }
  let(:email) { Faker::Lorem.characters }
  let(:phone_number) { Faker::Lorem.characters }
  let(:name) { Faker::Lorem.characters }
  let(:user_attributes) do
    {
      nrp: nrp,
      email: email,
      phone_number: phone_number,
      name: name
    }
  end
  let(:user) do
    User.new nrp: nrp, email: email, phone_number: phone_number,
             name: name
  end
  let(:computer) { create :computer }
  let(:reason) { Faker::Lorem.characters }
  let(:reservation_attributes) do
    {
      user: user,
      computer: computer,
      start_date: Faker::Date.between(2.weeks.ago, 1.week.ago),
      end_date: Faker::Date.between(Date.today, Date.today + 2.weeks),
      reason: reason,
      status: Random.rand(1..100)
    }
  end
  let(:registrar) { Registrar.new user_attributes: user_attributes,
                            reservation_attributes: reservation_attributes }
  describe '#initialize' do
    it 'initialize updater' do
      registrar = Registrar.new(user_attributes: user_attributes,
                                reservation_attributes: reservation_attributes)
      expect(registrar).to_not be_nil
    end
  end

  describe '#register_user' do
    context 'user already exist' do
      it 'updates attributes' do
        create :user, nrp: nrp

        registrar.register_or_update_user
        new_user = User.where(nrp: nrp).first
        expect(new_user.email).to eq(email)
        expect(new_user.phone_number).to eq(phone_number)
      end
    end

    context 'user doesnt exist' do
      it 'creates new user' do
        registrar.register_or_update_user

        user = User.find_by(nrp: nrp)
        expect(User.all.count).to eq 1
        expect(user.email).to eq(email)
        expect(user.phone_number).to eq(phone_number)
      end
    end
  end

  describe '#register_reservation' do
    it 'register_reservation' do
      registrar.register_reservation

      reservation = Reservation.find_by(user: user)
      expect(reservation.computer).to eq(computer)
      expect(reservation.reason).to eq(reason)
    end
  end
end
