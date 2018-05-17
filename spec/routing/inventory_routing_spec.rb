require 'rails_helper'

RSpec.describe 'routes for Computer', type: :routing do
  it 'routes inventory to inventorycontroller' do
    expect(post('inventory')).to route_to('inventory#create')
    expect(put: 'inventory/1').to route_to(
      controller: 'inventory',
      action: 'update',
      id: '1'
    )
    expect(get: 'inventory/1').to route_to(
      controller: 'inventory',
      action: 'show',
      id: '1'
    )
    expect(delete: 'inventory/1').to route_to(
      controller: 'inventory',
      action: 'destroy',
      id: '1'
    )
  end
end
