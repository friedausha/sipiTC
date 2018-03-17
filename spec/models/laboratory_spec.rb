require 'rails_helper'

RSpec.describe Laboratory, type: :model do
  subject { create :laboratory }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should have_many(:computers) }
  it { should have_many(:admins) }
end
