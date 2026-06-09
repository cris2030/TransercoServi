class AsignacionMeta < ApplicationRecord
  belongs_to :unidad
  belongs_to :meta

  validates :unidad_id,
            uniqueness: {
              scope: :meta_id,
              message: "ya tiene asignada esta meta"
            }
end
