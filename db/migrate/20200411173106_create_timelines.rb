class CreateTimelines < ActiveRecord::Migration[6.0]
  def change
    create_table :timelines do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
