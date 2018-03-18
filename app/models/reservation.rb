class Reservation < ApplicationRecord
  validates :reason, :status, presence: true
  belongs_to :user
  belongs_to :computer
end
