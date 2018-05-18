require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create :user }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:nrp) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:nrp) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:reservations) }
end
