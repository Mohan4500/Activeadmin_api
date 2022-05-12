class CreatePhotoLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :photo_libraries do |t|
      t.string :photo
      t.string :caption
      t.references :account, null: false, foreign_key: true
      t.timestamps
    end
  end
end
