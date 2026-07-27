class AddUniqueIndexToCymsas < ActiveRecord::Migration[7.2]
  def change
    add_index :cymsas, :gps_id, unique: true
  end
end
