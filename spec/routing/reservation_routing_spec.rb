require 'rails_helper'

RSpec.describe 'routes for Reservation', type: :routing do
  it 'routes reservation to reservationcontroller with create action' do
    expect(post('reservation')).to route_to('reservation#create')
    expect(put: 'reservation/1').to route_to(
      controller: 'reservation',
      action: 'update',
      id: '1'
    )
    expect(get: 'reservation/1').to route_to(
      controller: 'reservation',
      action: 'show',
      id: '1'
    )
  end
end
