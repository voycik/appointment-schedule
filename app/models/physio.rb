# frozen_string_literal: true

class Physio < User
  has_many :appointments
  has_many :patient_cards, through: :appointments
end
