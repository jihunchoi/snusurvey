class AddEndAtToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :end_at, :datetime
  end
end
