class AddEditableToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :editable, :boolean
  end
end
