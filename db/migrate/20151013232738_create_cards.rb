class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :new
      t.string :create
      t.string :update
      t.string :destroy

      t.timestamps null: false
    end
  end
end
