class Laboratory < ApplicationRecord
  validates :name, :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :inventories
end
