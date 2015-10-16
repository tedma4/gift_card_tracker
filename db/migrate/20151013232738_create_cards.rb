class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :company
      t.integer :amount, default: 25

      t.timestamps null: false
    end
  end
end
