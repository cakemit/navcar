class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  before_action :set_car, only: %i[show edit update destroy]
  before_action :set_user

  # GET cars_path <=> '/cars' VIEW
  def index
    if params[:query].present?
      @cars = policy_scope(Car).search_by_address(params[:query]).order(created_at: :desc)
    else
      @cars = policy_scope(Car).order(created_at: :desc)
    end
    owners = []
    @cars.each do |car|
      owners << car.user
    end
    @markers = owners.map do |owner|
      {
        lat: owner.latitude,
        lng: owner.longitude
      }
    end
  end

  # GET new_car_path <=> '/cars/new' VIEW
  def new
    @car = Car.new
    authorize @car
  end

  # POST cars_path <=> '/cars'
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

  # GET edit_car_path <=> '/cars/:id/edit' VIEW
  def edit
    authorize @car
  end

  # PATCH car_path <=> '/cars/:id'
  #   PUT car_path <=> '/cars/:id'
  def update
    authorize @car
    if @car.update(car_params)
      redirect_to car_path(@car)
    else
      render :edit
    end
  end

  # GET car_path '/cars/:id' VIEW
  def show
    authorize @car
  end

  # DELETE car_path <=> '/cars/:id'
  def destroy
    authorize @car
    @car.destroy
    redirect_to owner_car_path
  end

  # GET luxury_cars_path <=> '/cars/luxury'
  def luxury
    @cars = Car.where(category: "Luxury")
    authorize @cars
  end

  # GET vintage_cars_path <=> /cars/vintage
  def vintage
    @cars = Car.where(category: "Vintage")
    authorize @cars
  end

  # GET sport_cars_path <=> /cars/sport
  def sport
    @cars = Car.where(category: "Sport")
    authorize @cars
  end

  # GET off_road_cars_path <=> /cars/off_road
  def off_road
    @cars = Car.where(category: "Off-road")
    authorize @cars
  end

  # GET my_cars_cars_path => /cars/:id/owner
  def owner
    @mycars = Car.where(user_id: @user.id)
    authorize @mycars
  end

  # ----------------------------------------------------------------------------
  private

  def car_params
    params.require(:car).permit(:brand, :model, :year, :km,
                                :daily_rate, :city, :category, photos: [])
  end

  def set_car
    @car = Car.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
