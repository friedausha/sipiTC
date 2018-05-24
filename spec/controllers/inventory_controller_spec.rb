require 'rails_helper'

RSpec.describe InventoryController, type: :controller do
  let(:laboratory) { create :laboratory }
  let(:headers) do
    { 'Authorization' => "#{laboratory.name}" + ':' + "#{laboratory.password}" }
  end

  describe '#create' do
    it 'creates new inventory' do
      note = Faker::Lorem.characters
      laboratory = create :laboratory
      inventory = build :inventory, laboratory: laboratory
      params = {
        'laboratory' => laboratory.name,
        'spec' => inventory.spec,
        'name' => inventory.name,
        'note' => note
      }
      request.headers.merge!headers

      post :create, params: params

      res = Inventory.where(name: inventory.name).first
      expect(res.spec).to eq(inventory.spec)
      expect(res.note).to eq(note)
      expect(res.status).to eq('Belum Dipinjam')
      expect(res.reservation_ended).to eq(nil)
    end
  end
  describe '#show' do
    it 'shows certain inventory' do
      inventory = create :inventory
      params = {
        'id' => inventory.id
      }

      res = get :show, params: params
      res = JSON.parse(res.body)
      expect(res['body']).to eq(JSON.parse(inventory.to_json))
    end
  end
  describe '#update' do
    it 'updates attributes of inventory' do
      inventory = create :inventory
      spec = Faker::Lorem.characters
      notes = Faker::Lorem.characters
      params = {
        'id' => inventory.id,
        'spec' => spec,
        'note' => notes,
        'reservation_ended' => Date.today
      }
      request.headers.merge!headers
      put :update, params: params

      expect(inventory.reload.spec).to eq(spec)
      expect(inventory.reload.note).to eq(notes)
      expect(inventory.reload.status).to eq('Belum Dipinjam')
    end
  end

  describe '#delete' do
    it 'delete certain inventory' do
      inventory = create :inventory
      params = {
        'id' => inventory.id
      }
      request.headers.merge!headers

      delete :destroy, params: params
      expect(Inventory.all.count).to eq(0)
    end
  end
end
