class CreateQuestionScores < ActiveRecord::Migration
  def change
    create_table :question_scores do |t|
      t.integer :score

      t.timestamps
    end
  end
end
