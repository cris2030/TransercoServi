json.extract! servicio, :id, :unidad_id, :kilometraje, :fecha, :nom_mecanico, :created_at, :updated_at
json.url servicio_url(servicio, format: :json)
