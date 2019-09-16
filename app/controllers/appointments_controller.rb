class AppointmentsController < ApplicationController
  before_action :find_appointment, only: %i[show edit update destroy]
  before_action :patient_cards, only: %i[new create]
  def index
    @appointments = AppointmentDecorator.decorate_collection(Appointment.all)
  end

  def show
    @patient_card = @appointment.patient_card.decorate
  end

  def new
    @appointment = Appointment.new
    if params[:patient_card_id]
      @patient = PatientCard.find(params[:patient_card_id].to_i)
      @url = patient_card_appointments_path(@patient)
    else
      @url = appointments_path
    end

  end

  def create
    @appointment = Appointment.new(appointment_params)
    if params[:patient_card_id]
      @appointment.patient_card_id = params[:patient_card_id].to_i
    end
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
    params.require(:appointment).permit(:patient_card_id, :start_time, :end_time, :private_comment, :public_comment).merge!(user_id: 3)
  end

  def patient_cards
    @patient_cards = PatientCardDecorator.decorate_collection(PatientCard.all)
  end
end
