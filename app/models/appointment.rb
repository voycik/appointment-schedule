# frozen_string_literal: true

class Appointment < ApplicationRecord
  validates :user_id, :patient_card_id, :start_time, :end_time, presence: true
  belongs_to :user
  belongs_to :patient_card
end
