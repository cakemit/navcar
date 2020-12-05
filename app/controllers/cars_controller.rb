class CarsController < ApplicationController
  before_action :set_car, only: %i[show edit update destroy]
  before_action :set_user

  def index
    @cars = policy_scope(Car).order(created_at: :desc)
  end

  def new
    @car = Car.new
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    authorize @car
    @car.user = @user
    if @car.save!
      redirect_to car_path(@car)
    else
      render :new
    end
  end

  def edit
    authorize @car
  end

  def update
    authorize @car
    if Car.update(car_params)
      redirect_to car_path(@car)
    else
      render :edit
    end
  end

  def show
    authorize @car
  end

  def destroy
    authorize @car
    @car.destroy
    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :year, :km, :daily_rate, :city, :category, photos: [])
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
