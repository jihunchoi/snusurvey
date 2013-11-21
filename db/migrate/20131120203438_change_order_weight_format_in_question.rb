class ChangeOrderWeightFormatInQuestion < ActiveRecord::Migration
  def change
    change_column :questions, :order_weight, :integer
  end
end
