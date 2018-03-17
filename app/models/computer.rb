class Computer < ApplicationRecord
  validates :number, :spec, :status, presence: true
  belongs_to :laboratory
  has_many :reservations
end
