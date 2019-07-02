# frozen_string_literal: true

class CreatePatientCards < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_cards do |t|
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.text :comments
      t.integer :phone_number

      t.timestamps
    end
  end
end
