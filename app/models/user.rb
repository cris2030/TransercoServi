class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_many :meta_notificaciones,
           class_name: "MetaNotificacion"

  has_many :metas,
           through: :meta_notificaciones
end