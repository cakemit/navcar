class Car < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  validates :brand, :model, :year, :km, :city, :user_id, presence: true
end
