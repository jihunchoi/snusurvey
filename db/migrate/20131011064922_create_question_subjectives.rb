class CreateQuestionSubjectives < ActiveRecord::Migration
  def change
    create_table :question_subjectives do |t|
      t.string :content

      t.timestamps
    end
  end
end
