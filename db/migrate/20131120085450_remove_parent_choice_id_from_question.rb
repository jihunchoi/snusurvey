class RemoveParentChoiceIdFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :parent_choice_id
  end
end
