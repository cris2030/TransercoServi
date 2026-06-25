class AddMotorHoursToServicios < ActiveRecord::Migration[7.2]
  def change
    add_column :servicios, :motor_hours, :float
  end
end
