class RentalsController < ApplicationController
  before_action :set_rental, only: [ :show, :destroy ]
  before_action :set_car, only: [ :show, :new, :create ]

  # GET rentals_path '/rentals' VIEW
  def index
    @user = current_user
    @rentals = policy_scope(Rental).order(created_at: :desc)
  end
  
  # GET car_rental_path '/cars/:car_id/rentals/:id' VIEW
  def show
    authorize @rental
  end

  # GET new_car_rental_path '/cars/:car_id/rentals/new' VIEW
  def new
    @rental = Rental.new
    @car = Car.find(params[:car_id])
    authorize @rental
  end

  # POST car_rentals_path '/cars/:car_id/rentals'
  def create
    @rental = Rental.new(rental_params)
    @rental.car = @car
    @rental.user = current_user
    days = @rental.finish_date - @rental.start_date
    @amount = days * @rental.car.daily_rate
    authorize @rental
    if @rental.save
      redirect_to car_rental_path(@car, @rental)
    else
      render :new
    end
  end

  # DELETE rental_path '/rentals/:id'
  def destroy
    authorize @rental
    @rental.destroy
    redirect_to rentals_path
  end

  # ----------------------------------------------------------------------------
  private

  def rental_params
    params.require(:rental).permit(:start_date, :finish_date, :user_id, :car_id)
  end

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def set_car
    @car = Car.find(params[:car_id])
  end

end
