class DropQuestionXTable < ActiveRecord::Migration
  def change
    drop_table :question_radios
    drop_table :question_checkboxes
    drop_table :question_scores
    drop_table :question_subjectives
  end
end
