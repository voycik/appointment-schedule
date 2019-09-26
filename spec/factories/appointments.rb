# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    user_id { Physio.first.id }
    patient_card_id  { PatientCard.last.id }
    start_time { Time.now + 1.day}
    end_time { Time.now + 25.hours }
  end
end
