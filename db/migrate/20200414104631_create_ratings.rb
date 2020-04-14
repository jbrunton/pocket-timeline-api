class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.references :timeline, null: false, foreign_key: true
      t.float :normalized_score

      t.timestamps
    end
  end
end
