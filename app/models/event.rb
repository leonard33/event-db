class Event < ApplicationRecord
  belongs_to :category
  has_many :bookings, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :amount, presence: true
  validates :event_datetime, presence: true
  validates :image_url, presence: true
  validates :rating, presence: true
  validates :location, presence: true
  validates :category_id, presence: true
end
