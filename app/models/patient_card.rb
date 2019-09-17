# frozen_string_literal: true

class PatientCard < ApplicationRecord
  validates :first_name, presence: true, length: { minimum: 3, maximum: 15 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 25 }
  validates :phone_number, presence: true, length: { minimum: 9 }
  validates_format_of :phone_number, with: /\d[0-9]\)*\z/, message: 'Nieprawidłowy numer telefonu'

  has_many :appointments
  has_many :users, through: :appointments
end
