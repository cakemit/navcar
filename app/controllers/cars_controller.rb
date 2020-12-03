class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  def index
    @cars = policy_scope(Car).order(created_at: :desc)
  end

  def new
    @car = Car.new
    @user = current_user
    authorize @car
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    authorize @car
    if @car.save
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

  private

  def car_params
    params.require(:car).permit(:brand, :model, :year, :km, :daily_rate, :city)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
