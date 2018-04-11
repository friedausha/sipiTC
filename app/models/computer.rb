class Computer < ApplicationRecord
  validates :laboratory_id, :name, :spec, :status, presence: true
  belongs_to :laboratory
  has_many :reservations

  def change_available_dates(reservation_started:, reservation_ended:)
    update_attributes(reservation_started: reservation_started,
                      reservation_ended: reservation_ended)
  end

  def self.list_available(date: )
    Computer.where('status = ? or reservation_ended <=?', 0, date).all
  end
end
