class Api::V1::BookingsController < ApplicationController

  before_action :set_booking, only: %i[show update destroy]



  # GET /bookings

  def index

    @bookings = Booking.all



    render json: @bookings

  end



  # GET /bookings/1

  def show

    render json: @booking

  end



  # POST /bookings

  def create

    @booking = Booking.new(booking_params)



    if @booking.save

      render json: @booking, status: :created

    else

      render json: @booking.errors, status: :unprocessable_entity

    end

  end



  # PATCH/PUT /bookings/1

  def update

    if @booking.update(booking_params)

      render json: @booking

    else

      render json: @booking.errors, status: :unprocessable_entity

    end

  end



  # DELETE /bookings/1

  def destroy

    @booking.destroy

  end



  private



  # Use callbacks to share common setup or constraints between actions.

  def set_booking

    @booking = Booking.find(params[:id])

  end



  # Only allow a list of trusted parameters through.

  def booking_params

    params.require(:booking).permit(:number_of_tickets, :ticket_number, :amount, :event_id, :user_id, :status)

  end

end

