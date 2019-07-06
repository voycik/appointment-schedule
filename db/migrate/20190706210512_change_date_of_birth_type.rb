class ChangeDateOfBirthType < ActiveRecord::Migration[5.2]
  def change
    change_column :patient_cards, :date_of_birth, :date
  end
end
