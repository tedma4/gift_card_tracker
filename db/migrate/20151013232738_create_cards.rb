class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :company
      t.decimal :amount, precision: 12, scale: 3

      t.timestamps null: false
    end
  end
end
