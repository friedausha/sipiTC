require 'rails_helper'

RSpec.describe Computer, type: :model do
  subject { create :computer }
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:spec) }
  it { should validate_presence_of(:status) }
  it { should belong_to(:laboratory) }
  it { should have_many(:reservations) }
end
