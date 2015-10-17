class AddLastFour < ActiveRecord::Migration
  def change
    add_column :cards, :cc_num, :string
  end
end
