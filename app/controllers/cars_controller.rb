class CarsController < ApplicationController

before_action :set_car, only: [ :show, :edit, :update]

  def index
    @cars = Car.all
  end


  def show
  end

  def edit

  end

  def update
    @car = Car.update(car_params)

    if @car.save!
      redirect_to car_path
    else
      render :new
    end
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :year, :km, :daily_rate, :city)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
