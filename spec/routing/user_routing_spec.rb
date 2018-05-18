require 'rails_helper'

RSpec.describe 'routes for user', type: :routing do
  it 'routes reservation to usercontroller with create action' do
    expect(post('user')).to route_to('user#create')
    expect(put: 'user/1').to route_to(
                                        controller: 'user',
                                        action: 'update',
                                        id: '1'
                                    )
  end
end
