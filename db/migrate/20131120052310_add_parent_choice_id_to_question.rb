class AddParentChoiceIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :parent_choice_id, :integer
  end
end
