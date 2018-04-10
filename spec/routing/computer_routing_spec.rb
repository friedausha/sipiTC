require 'rails_helper'

RSpec.describe 'routes for Computer', type: :routing do
  it 'routes computer to computercontroller' do
    expect(post('computer')).to route_to('computer#create')
    expect(put: 'computer/1').to route_to(
      controller: 'computer',
      action: 'update',
      id: '1'
    )
    expect(get: 'computer/1').to route_to(
      controller: 'computer',
      action: 'show',
      id: '1'
    )
    expect(delete: 'computer/1').to route_to(
      controller: 'computer',
      action: 'destroy',
      id: '1'
    )
  end
end
