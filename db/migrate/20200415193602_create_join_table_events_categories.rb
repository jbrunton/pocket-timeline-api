class CreateJoinTableEventsCategories < ActiveRecord::Migration[6.0]
  def change
    create_join_table :events, :categories do |t|
      t.index :event_id
      t.index :category_id
    end
  end
end
