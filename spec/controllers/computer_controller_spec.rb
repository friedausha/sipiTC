require 'rails_helper'

RSpec.describe ComputerController, type: :controller do
  let(:laboratory) { create :laboratory }
  let(:headers) do
    { 'Authorization' => "#{laboratory.name}" + ':' + "#{laboratory.password}" }
  end

  describe '#create' do
    it 'creates new computer' do
      note = Faker::Lorem.characters
      laboratory = create :laboratory
      computer = build :computer, laboratory: laboratory
      params = {
        'laboratory' => laboratory.name,
        'spec' => computer.spec,
        'name' => computer.name,
        'note' => note
      }
      request.headers.merge!headers

      post :create, params: params

      res = Computer.where(name: computer.name).first
      p res
      expect(res.spec).to eq(computer.spec)
      expect(res.note).to eq(note)
      expect(res.status).to eq(0)
      expect(res.reservation_ended).to eq(nil)
    end
  end
  describe '#show' do
    it 'shows certain computer' do
      computer = create :computer
      params = {
        'id' => computer.id
      }

      res = get :show, params: params
      res = JSON.parse(res.body)
      expect(res['body']).to eq(JSON.parse(computer.to_json))
    end
  end
  describe '#update' do
    it 'updates attributes of computer' do
      computer = create :computer
      spec = Faker::Lorem.characters
      notes = Faker::Lorem.characters
      params = {
        'id' => computer.id,
        'spec' => spec,
        'note' => notes,
        'reservation_ended' => Date.today
      }
      request.headers.merge!headers
      put :update, params: params

      expect(computer.reload.spec).to eq(spec)
      expect(computer.reload.note).to eq(notes)
      expect(computer.reload.status).to eq(0)
    end
  end

  describe '#delete' do
    it 'delete certain computer' do
      computer = create :computer
      params = {
        'id' => computer.id
      }
      request.headers.merge!headers

      delete :destroy, params: params
      expect(Computer.all.count).to eq(0)
    end
  end
end
