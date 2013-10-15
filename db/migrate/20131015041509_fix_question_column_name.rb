class FixQuestionColumnName < ActiveRecord::Migration
  def change
    rename_column :questions, :order, :order_weight
  end
end
