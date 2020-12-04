class RentalsController < ApplicationController
  before_action :set_rental, only: [ :show, :edit, :update ]
  before_action :set_car, only: [ :show, :new, :create, :edit, :update ]

  def index
    @rentals = Rental.where(car_id: params[:car_id])
  end

  def show
    time = @rental.finish_date - @rental.start_date
    @price = time * @rental.car.daily_rate
    authorize @rental
  end

  def new
    @rental = Rental.new
    @rental.car = @car
    @rental.user = current_user
    authorize @rental
  end

  def create
    @rental = Rental.new(rental_params)
    @rental.car = @car
    @rental.user = current_user
    authorize @rental

    if @rental.save!
      redirect_to car_rental_path(@car, @rental)
    else
      render :new
    end
  end

  def edit
  end

  def update
    authorize @rental
    if @rental.update(rental_params)
      redirect_to car_rental_path(@car, @rental)
    else
      render :edit
    end
  end

  def destroy
    authorize @rental
  end

  # ----------------------------------------------------------------------------
  private

  def rental_params
    params.require(:rental).permit(:start_date, :finish_date, :user_id, :car_id)
  end

  def set_rental
    # @rental = Rental.find(params[:id])
    @rental = Rental.find(params[:id])
  end

  def set_car
    @car = Car.find(params[:car_id])
  end
end
