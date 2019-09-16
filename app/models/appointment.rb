# frozen_string_literal: true

class Appointment < ApplicationRecord
  include ActiveModel::Validations
  validates_with AppointmentTimeValidator
  validates :user_id, :patient_card_id, :start_time, :end_time, presence: true
  belongs_to :user
  belongs_to :patient_card
end
