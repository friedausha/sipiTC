class Reservation < ApplicationRecord
  validates :reason, :status, presence: true
  belongs_to :users
  belongs_to :computers
end
