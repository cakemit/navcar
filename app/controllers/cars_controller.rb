class CarsController < ApplicationController

# before_action :set_car

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new(car_params)
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :year, :km, :daily_rate, :city)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
