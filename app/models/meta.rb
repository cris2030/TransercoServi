class Meta < ApplicationRecord
  has_many :asignacion_metas,
           dependent: :destroy

  has_many :unidades,
           through: :asignacion_metas

  validates :nombre, presence: true, uniqueness: true

  has_many :meta_notificaciones,
         class_name: "MetaNotificacion",
         foreign_key: "meta_id",
         dependent: :destroy
         
  has_many :usuarios_notificados,
           through: :meta_notificaciones,
           source: :user

  validates :color,
            presence: true,
            inclusion: {
              in: %w[red yellow green orange purple]
            }
  validates :cantidad_meta,
          presence: true,
          numericality: {
            only_integer: true,
            greater_than: 0
          }

  validates :alerta_km,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :urgente_km,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            }

  validates :cantidad_meta_horas,
          numericality: {
            only_integer: true,
            greater_than: 0
          },
          allow_nil: true

  validates :alerta_horas,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            allow_nil: true

  validates :urgente_horas,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            allow_nil: true

  def to_s
    nombre
  end

  def alerta_desde
    cantidad_meta - alerta_km
  end

  def urgente_desde
    cantidad_meta + urgente_km
  end

  def alerta_desde_horas
    cantidad_meta_horas - alerta_horas
  end

  def urgente_desde_horas
    cantidad_meta_horas + urgente_horas
  end

  def estado(km_actual)

    if km_actual >= urgente_desde
      :urgente

    elsif km_actual >= cantidad_meta
      :cumplido

    elsif km_actual >= alerta_desde
      :alerta

    else
      nil
    end

  end

  def estado_horas(horas_actuales)

    return nil if horas_actuales.nil?
    return nil unless cantidad_meta_horas.present?

    if horas_actuales >= urgente_desde_horas
      :urgente

    elsif horas_actuales >= cantidad_meta_horas
      :cumplido

    elsif horas_actuales >= alerta_desde_horas
      :alerta

    else
      nil
    end
  end
    
  def km_restantes(km_actual)
    cantidad_meta - km_actual
  end
  
  def horas_restantes(horas_actuales)

    return nil if horas_actuales.nil?

    cantidad_meta_horas - horas_actuales
  end

end