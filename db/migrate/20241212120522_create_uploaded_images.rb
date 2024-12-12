class CreateUploadedImages < ActiveRecord::Migration[7.2]
  def change
    create_table :uploaded_images do |t|
      t.string :title

      t.timestamps
    end
  end
end
