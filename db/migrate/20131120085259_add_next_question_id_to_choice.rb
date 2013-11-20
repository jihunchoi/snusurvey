class AddNextQuestionIdToChoice < ActiveRecord::Migration
  def change
    add_column :choices, :next_question_id, :integer
  end
end
