class CreateSteps < ActiveRecord::Migration[7.2]
  def change
    create_table :steps do |t|
      t.references :rice_ball, null: false, foreign_key: true
      t.text :description, null: false
      t.integer :step_number, null: false

      t.timestamps
    end
  end
end
