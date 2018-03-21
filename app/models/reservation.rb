class Reservation < ApplicationRecord
  validates :reason, :status, :start_date, :end_date, presence: true
  belongs_to :user
  belongs_to :computer
end
