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
  let(:inventory) { create :inventory }
  let(:reason) { Faker::Lorem.characters }
  let(:user) { create :user }
  let(:reservation_attributes) do
    {
      user: user,
      inventory: inventory,
      start_date: Faker::Date.between(2.weeks.ago, 1.week.ago),
      end_date: Faker::Date.between(Date.today, Date.today + 2.weeks),
      reason: reason,
    }
  end
  let(:registrar) { Registrar.new }

  describe '#register_user' do
    context 'user already exist' do
      it 'updates attributes' do
        create :user, nrp: nrp

        registrar.register_or_update_user(user_attributes: user_attributes)
        new_user = User.where(nrp: nrp).first
        expect(new_user.email).to eq(email)
        expect(new_user.phone_number).to eq(phone_number)
      end
    end

    context 'user doesnt exist' do
      it 'creates new user' do
        registrar.register_or_update_user(user_attributes: user_attributes)

        user = User.find_by(nrp: nrp)
        expect(User.all.count).to eq 1
        expect(user.email).to eq(email)
        expect(user.phone_number).to eq(phone_number)
      end
    end
  end

  describe '#register_reservation' do
    it 'register_reservation' do
      registrar.register_reservation(reservation_attributes: reservation_attributes)

      reservation = Reservation.find_by(user: user)
      expect(reservation.inventory).to eq(inventory)
      expect(reservation.reason).to eq(reason)
      expect(reservation.status).to eq(0)
    end
  end
end
