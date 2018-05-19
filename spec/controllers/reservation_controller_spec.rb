require 'rails_helper'

RSpec.describe ReservationController, type: :controller do
  let(:laboratory) { create :laboratory }
  let(:headers) do
    { 'Authorization' => "#{laboratory.name}" + ':' + "#{laboratory.password}" }
  end
  let(:nrp) { 'aba' }
  let(:email) { Faker::Lorem.characters }
  let(:phone_number) { Faker::Lorem.characters }
  let(:name) { Faker::Lorem.characters }
  let(:password) { 'aaa' }
  let(:user) { create :user, nrp: nrp, email: email, phone_number: phone_number,
                name: name, password: password }
  let(:inventory) { create :inventory, laboratory: laboratory }
  let(:start_date) { Faker::Date.between(2.years.ago, 2.weeks.ago) }
  let(:end_date) { Faker::Date.between(1.week.ago, Date.today + 1.week) }
  let(:reason) { Faker::Lorem.characters }
  let(:params) do {
    'nrp' => nrp,
    'inventory' => inventory,
    'start_date' => start_date,
    'end_date' => end_date,
    'reason' => reason
    }
  end
  describe '#create' do
    it 'calls Registrar and creates new reservation' do
      headers1 = { 'Authorization' => "aba:aaa" }
      request.headers.merge!headers1
      post :create, params: params
      reservation = Reservation.all.first

      p response.status
      expect(response).to have_http_status(200)
      p start_date
      expect(reservation.start_date).to eq(start_date)
      expect(reservation.reason).to eq(reason)
    end
  end

  describe '#update' do
    it 'updates reservation status' do
      inventory = create :inventory, laboratory: laboratory
      reservation = create :reservation, inventory: inventory
      params = {
        'id' => reservation.id,
        'status' => '1'
      }
      request.headers.merge!headers
      put :update, params: params

      expect(inventory.reload.status).to eq(1)
      expect(inventory.reload.reservation_started).to eq(reservation.start_date)
    end
  end
  context 'status not accepted' do
    it 'doesnt update anything' do
      inventory = create :inventory, laboratory: laboratory
      reservation = create :reservation, inventory: inventory
      params = {
        'id' => reservation.id,
        'status' => '2'
      }
      request.headers.merge!headers
      put :update, params: params

      expect(inventory.reload.status).to eq(2)
    end
  end
end
