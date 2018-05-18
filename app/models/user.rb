class User < ApplicationRecord
  validates :name, :nrp, :email, :phone_number, :password, presence: true
  validates :nrp, :email, uniqueness: true
  has_many :reservations
end
