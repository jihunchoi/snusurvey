class CreateQuestionRadios < ActiveRecord::Migration
  def change
    create_table :question_radios do |t|

      t.timestamps
    end
  end
end
