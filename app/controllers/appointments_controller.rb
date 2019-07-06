class AppointmentsController < ApplicationController
  before_action :find_appointment, only: %i[show edit update destroy]
  def index
    @appointments = Appointment.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_appointment
    @appointment = Appointment.find(params[:id])
  end
end
