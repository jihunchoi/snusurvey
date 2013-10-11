class CreateQuestionCheckboxes < ActiveRecord::Migration
  def change
    create_table :question_checkboxes do |t|

      t.timestamps
    end
  end
end
