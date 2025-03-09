class CreateRiceBalls < ActiveRecord::Migration[7.2]
  def change
    create_table :rice_balls do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
