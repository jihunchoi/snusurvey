class AddOrderToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :order, :float
  end
end
