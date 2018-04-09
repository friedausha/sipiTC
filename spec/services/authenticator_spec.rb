require 'rails_helper'

RSpec.describe Authenticator do
  let(:laboratory) {
    create :laboratory
  }
  let(:authorization) { "#{laboratory.name}" + ':' + "#{laboratory.password}" }
  describe '#initialize' do
    it 'creates Authenticator' do
      authenticator = Authenticator.new(authorization: authorization)
      expect(authenticator).to_not be_nil
    end
  end

  describe '#permitted' do
    it 'check whether the client is permitted' do
      authenticator = Authenticator.new(authorization: authorization)
      expect(authenticator.permitted?).to eq(true)
    end
    context 'wrong password' do
      it 'returns false' do
        authenticator = Authenticator.new(authorization: 'askla:alkd')
        expect(authenticator.permitted?).to eq(false)
      end
    end
  end
end
