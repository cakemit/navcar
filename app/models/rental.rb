class Rental < ApplicationRecord
  belongs_to :car
  belongs_to :user
  validates :start_date, :finish_date, :amount, presence: true
  validate :start_date_must_be_greater_today, :finish_date_must_be_greater_start

  def start_date_must_be_greater_today
    if start_date < Date.today
      errors.add(:start_date, "Can't be in the past")
    end
  end

  def finish_date_must_be_greater_start
    if finish_date < start_date
      errors.add(:finish_date, "Must be after start date")
    end
  end
end
