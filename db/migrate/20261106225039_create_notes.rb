class CreateNotes < ActiveRecord::Migration[7.2]
  def change
    create_table :notes do |t|
      t.string :title
      t.string :author, null: false
      t.string :category, null: false
      t.string :description
      t.text :note, null: false

      t.timestamps
    end
  end
end
