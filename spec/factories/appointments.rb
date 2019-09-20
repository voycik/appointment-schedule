# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    user_id { Pysio.first }
    patient_card_id  { PatientCard.last }
    start_time { Time.now + 1.day}
    end_time { Time.now + 25.hours }
  end
end
