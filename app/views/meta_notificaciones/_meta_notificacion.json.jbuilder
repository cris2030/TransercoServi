json.extract! meta_notificacion, :id, :meta_id, :user_id, :estado, :created_at, :updated_at
json.url meta_notificacion_url(meta_notificacion, format: :json)
