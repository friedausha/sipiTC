require 'rails_helper'

RSpec.describe LaboratoryController, type: :controller do
  let(:laboratory) { create :laboratory }
  let(:headers) do
    { 'Authorization' => "#{laboratory.name}" + ':' + "#{laboratory.password}" }
  end

  describe '#show' do
    it 'shows certain inventory inlaboratory' do
      laboratory = create :laboratory
      inventory1 = create :inventory, laboratory: laboratory
      inventory2 = create :inventory, laboratory: laboratory
      inventory3 = create :inventory, laboratory: laboratory
      params = {
        'id' => laboratory.name
      }

      res = get :show, params: params
      res = JSON.parse(res.body)
      expect(res['body']).to eq(JSON.parse([inventory1, inventory2, inventory3].to_json))
      res1 = get :show, params: {'id' => 'abs'}
      p Laboratory.where(name: 'abs').first.present?
      expect(res1.status).to eq(404)

    end
  end
  describe '#update' do
    it 'updates attributes of inventory' do
      laboratory = create :laboratory
      name = Faker::Lorem.characters
      password = Faker::Lorem.characters
      params = {
        'id' => laboratory.id,
        'name' => name,
        'password' => password
      }
      request.headers.merge!headers
      put :update, params: params

      expect(laboratory.reload.name).to eq(name)
      expect(laboratory.reload.password).to eq(password)
      expect(laboratory.reload.email).to eq(laboratory.email)
    end
  end
end
