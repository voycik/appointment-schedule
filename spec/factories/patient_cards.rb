# frozen_string_literal: true

FactoryBot.define do
  factory :patient_card do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    date_of_birth { 45.years.ago }
    phone_number { 60_012_357 }
    comments { 'He has problems with left shoulder.' }
  end
end
