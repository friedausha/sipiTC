require 'rails_helper'

RSpec.describe LaboratoryController, type: :controller do
  let(:laboratory) { create :laboratory }
  let(:headers) do
    { 'Authorization' => "#{laboratory.name}" + ':' + "#{laboratory.password}" }
  end

  describe '#show' do
    it 'shows certain computer inlaboratory' do
      laboratory = create :laboratory
      computer1 = create :computer, laboratory: laboratory
      computer2 = create :computer, laboratory: laboratory
      computer3 = create :computer, laboratory: laboratory
      params = {
        'id' => laboratory.name
      }

      res = get :show, params: params
      res = JSON.parse(res.body)
      expect(res['body']).to eq(JSON.parse([computer1, computer2, computer3].to_json))
      res1 = get :show, params: {'id' => 'abs'}
      p Laboratory.where(name: 'abs').first.present?
      expect(res1.status).to eq(404)

    end
  end
  describe '#update' do
    it 'updates attributes of computer' do
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
