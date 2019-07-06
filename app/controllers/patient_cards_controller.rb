class PatientCardsController < ApplicationController

  before_action :find_patient, only: %i[show edit update destroy]

  def index
    @patients = PatientCard.all
  end

  def show
  end

  def new
    @patient = PatientCard.new
  end

  def create
    @patient = PatientCard.new(patient_card_params)
    if @patient.save
      flash[:success] = 'Pomyślnie dodano nowego pacjenta.'
      redirect_to patient_cards_path
    else
      flash.now[:danger] = 'Nie udało się dodać pacjenta. Sprawdź błędy i spróbuj ponownie.'
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

  def find_patient
    @patient = Patient.find(params[:id])
  end

  def patient_card_params
    params.require(:patient_card).permit(:first_name, :last_name, :date_of_birth, :phone_number, :comments)
  end
end
