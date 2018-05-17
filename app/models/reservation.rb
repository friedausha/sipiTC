class Reservation < ApplicationRecord
  validates :reason, :status, :user_id, :inventory_id, :start_date, :end_date,
            presence: true
  belongs_to :user
  belongs_to :inventory

  def update_status(status: )
    self.update_attributes!(status: status)
  end
end
