class Car < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  has_many_attached :photos
  validates :brand, :model, :year, :km, :user_id, presence: true
  validates :category, presence: true, inclusion: { in: [ "Vintage", "Luxury", "Off-road", "Sport"] }

  include PgSearch::Model
  pg_search_scope :search_by_address,
    associated_against: {
      user: :address
    },
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
