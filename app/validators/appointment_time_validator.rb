class AppointmentTimeValidator < ActiveModel::Validator

  def validate(record)
    appointments = Appointment.where(user_id: record.user_id)
    if record.start_time
      appointments.each do |appointment|
        if appointment != record
          if appointment.start_time <= record.start_time && record.start_time <= appointment.end_time || record.start_time <= appointment.start_time && appointment.start_time <= record.end_time
            record.errors.add(:start_time, "Wybrany termin jest już zajęty!")
          end
        end
      end
    end
  end
end
