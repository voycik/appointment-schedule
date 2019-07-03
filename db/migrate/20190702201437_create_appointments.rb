# frozen_string_literal: true

class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.references :user, foreign_key: true
      t.references :patient_card, foreign_key: true
      t.datetime :date
      t.text :private_comment
      t.text :public_comment
      t.timestamps
    end
  end
end
