class AppointmentDecorator < Draper::Decorator
  delegate_all
  decorates_association :patient_card

  def hour
    start_time.strftime("%R")
  end

end
