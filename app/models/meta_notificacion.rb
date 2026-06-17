class MetaNotificacion < ApplicationRecord
  self.table_name = "meta_notificaciones"

  belongs_to :meta
  belongs_to :user

  validates :estado,
            inclusion: {
              in: %w[alerta cumplido urgente]
            }
end