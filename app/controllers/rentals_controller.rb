class RentalsController < ApplicationController
  before_action :set_rental, only: [ :show, :edit, :update ]
  before_action :set_car, only: [ :show, :new, :create, :edit, :update ]
  before_action :set_user

  # GET rentals_path '/rentals' VIEW
  # GET car_rentals_path '/cars/:car_id/rentals' VIEW
  def index
    @rentals = Rental.where(car_id: params[:car_id])
  end


  # GET car_rental_path '/cars/:car_id/rentals/:id' VIEW
  def show
    time = @rental.finish_date - @rental.start_date
    @price = time * @rental.car.daily_rate
    authorize @rental
  end

  # GET new_car_rental_path '/cars/:car_id/rentals/new' VIEW
  def new
    @rental = Rental.new
    @rental.car = @car
    @rental.user = current_user
    authorize @rental
  end

  # POST car_rentals_path '/cars/:car_id/rentals'
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

  # GET edit_car_rental_path '/cars/:car_id/rentals/:id/edit' VIEW
  def edit
  end

  # PATCH car_rental_path '/cars/:car_id/rentals/:id'
  #   PUT car_rental_path '/cars/:car_id/rentals/:id'
  def update
    authorize @rental
    if @rental.update(rental_params)
      redirect_to car_rental_path(@car, @rental)
    else
      render :edit
    end
  end

  # DELETE car_rental_path '/cars/:car_id/rentals/:id'
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

  def set_user
    @user = current_user
  end
end
