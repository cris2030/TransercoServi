class CreateMetaNotificaciones < ActiveRecord::Migration[7.2]
  def change
    create_table :meta_notificaciones do |t|
      t.references :meta, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :estado

      t.timestamps
    end
  end
end
