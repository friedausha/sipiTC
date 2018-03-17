class Laboratory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :computers
  has_many :admins
end
