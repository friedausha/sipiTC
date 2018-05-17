require 'rails_helper'

RSpec.describe 'routes for laboratory', type: :routing do
  it 'routes inventory to laboratorycontroller' do
    expect(put: 'laboratory/1').to route_to(
      controller: 'laboratory',
      action: 'update',
      id: '1'
    )
    expect(get: 'laboratory/1').to route_to(
      controller: 'laboratory',
      action: 'show',
      id: '1'
    )
  end
end
