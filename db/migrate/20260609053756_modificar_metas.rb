class ModificarMetas < ActiveRecord::Migration[7.2]
  def change
    add_column :metas, :cantidad_meta, :integer

    rename_column :metas,
                  :kilometraje_inicio,
                  :alerta_km

    rename_column :metas,
                  :kilometraje_final,
                  :urgente_km

    remove_column :metas,
                  :nivel_imp,
                  :integer
  end
end