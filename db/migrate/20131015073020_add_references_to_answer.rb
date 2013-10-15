class AddReferencesToAnswer < ActiveRecord::Migration
  def change
    add_column :answers, :report_id, :integer
    add_column :answers, :question_id, :integer
    add_column :answers, :choice_id, :integer
  end
end
