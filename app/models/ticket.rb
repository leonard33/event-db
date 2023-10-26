class Ticket < ApplicationRecord
  belongs_to :booking

  validates :category, presence: true
  validates :booking_id, presence: true
end
