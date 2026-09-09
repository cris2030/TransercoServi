class AsignacionMaquinariaMeta < ApplicationRecord
  belongs_to :maquinaria
  belongs_to :meta

  validates :maquinaria_id,
            uniqueness: {
              scope: :meta_id,
              message: "ya tiene asignada esta meta"
            }
end
