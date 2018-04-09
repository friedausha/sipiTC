require 'rails_helper'

RSpec.describe ReservationController, type: :controller do
  let(:laboratory) { create :laboratory }
  let(:headers) do
    { 'Authorization' => "#{laboratory.name}" + ':' + "#{laboratory.password}" }
  end
  let(:nrp) { Faker::Lorem.characters }
  let(:email) { Faker::Lorem.characters }
  let(:phone_number) { Faker::Lorem.characters }
  let(:name) { Faker::Lorem.characters }

  let(:user) { create :user, nrp: nrp, email: email, phone_number: phone_number,
                name: name }
  let(:computer) { create :computer }
  let(:start_date) { Faker::Date.between(2.years.ago, 2.weeks.ago) }
  let(:end_date) { Faker::Date.between(1.week.ago, Date.today + 1.week) }
  let(:reason) { Faker::Lorem.characters }
  let(:params) do {
    'nrp' => nrp,
    'email' => email,
    'phone_number' => phone_number,
    'name' => name,
    'computer' => "#{computer.id}",
    'start_date' => start_date,
    'end_date' => end_date,
    'reason' => reason
    }
  end
  describe '#create' do
    it 'calls Registrar and creates new user and reservation' do
      post :create, params: params

      user = User.find_by(nrp: nrp)
      expect(user.email).to eq(email)
      expect(user.phone_number).to eq(phone_number)

      reservation = Reservation.find_by(computer: computer)
      expect(reservation.user).to eq(user)
      expect(reservation.computer).to eq(computer)
      # expect(AdminsMailer).to receive(:new_reservation_email)
      #   .with(computer.laboratory)
    end
  end

  describe '#update' do
    it 'updates reservation status' do
      computer = create :computer, laboratory: laboratory
      reservation = create :reservation, computer: computer
      params = {
        'id' => reservation.id,
        'status' => '1'
      }
      request.headers.merge!headers
      put :update, params: params

      expect(computer.reload.status).to eq(1)
      expect(computer.reload.reservation_started).to eq(reservation.start_date)
    end
  end
end
