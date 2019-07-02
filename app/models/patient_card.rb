# frozen_string_literal: true

class PatientCard < ApplicationRecord
  has_many :appointments
  has_many :users, through: :appointments
end
