class RenameOrderWeightToQuestionNumberInQuestion < ActiveRecord::Migration
  def change
    rename_column :questions, :order_weight, :question_number
  end
end
