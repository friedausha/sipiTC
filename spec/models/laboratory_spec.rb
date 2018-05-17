require 'rails_helper'

RSpec.describe Laboratory, type: :model do
  subject { create :laboratory }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_many(:inventories) }
end
