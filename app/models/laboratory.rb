class Laboratory < ApplicationRecord
  validates :name, :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :computers
  has_many :admins
end
