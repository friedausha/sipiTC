class Admin < ApplicationRecord
  validates :name, :nrp, :email, :phone_number, presence: true
  validates :nrp, :email, uniqueness: true
  belongs_to :laboratory
end
