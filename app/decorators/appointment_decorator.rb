class AppointmentDecorator < Draper::Decorator
  delegate_all
  decorates_association :patient_card
end
