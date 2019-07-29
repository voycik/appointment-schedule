class AppointmentsController < ApplicationController  
  before_action :find_appointment, only: %i[show edit update destroy]
  def index
    @appointments = AppointmentDecorator.decorate_collection(Appointment.all)
  end

  def show
    @patient_card = @appointment.patient_card.decorate
  end

  def new
    @appointment = Appointment.new
    @patient_cards = PatientCard.all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    @patient_cards = PatientCard.all
    if @appointment.save
      flash[:success] = 'Pomyślnie zaplanowano wizytę.'
      redirect_to appointments_path
    else
      flash.now[:danger] = 'Nie udało się zaplanować wizyty. Sprawdź błędy i spróbuj ponownie.'
      render :new
    end
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

  def appointment_params
    params.require(:appointment).permit(:patient_card_id, :start_time, :end_time, :private_comment, :public_commen).merge!(user_id: 3)
  end
end
