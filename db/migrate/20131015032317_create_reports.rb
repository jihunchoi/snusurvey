class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :survey, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
