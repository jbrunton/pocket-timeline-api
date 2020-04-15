class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.references :timeline, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :level, null: false
      t.float :normalized_score
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
