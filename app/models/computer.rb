class Computer < ApplicationRecord
  validates :number, :laboratory_id, :spec, :status, presence: true
  belongs_to :laboratory
  has_many :reservations

  def change_status(status:)
    update_attributes(status: status)
  end

  def change_available_dates(reservation_started:, reservation_ended:)
    update_attributes(reservation_started: reservation_started,
                      reservation_ended: reservation_ended)
  end

  def self.list_available
    Computer.where(status: 0).all
  end

  def change_spec_and_note(spec:, note:)
    update_attributes(spec: spec, note: note)
  end
end
