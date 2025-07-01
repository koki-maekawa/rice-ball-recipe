class CreateRiceBallTags < ActiveRecord::Migration[7.2]
  def change
    create_table :rice_ball_tags do |t|
      t.references :rice_ball, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
