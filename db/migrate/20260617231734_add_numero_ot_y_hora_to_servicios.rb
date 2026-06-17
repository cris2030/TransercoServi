class AddNumeroOtYHoraToServicios < ActiveRecord::Migration[7.2]
  def change
    add_column :servicios, :numero_ot, :string
    add_column :servicios, :hora, :time
  end
end
