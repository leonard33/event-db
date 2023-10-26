class Booking < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :tickets

  validates :number_of_tickets, presence: true, numericality: { only_integer: true }
  validates :ticket_number, presence: true
  validates :amount, presence: true
  validates :event_id, presence: true
  validates :user_id, presence: true
end
