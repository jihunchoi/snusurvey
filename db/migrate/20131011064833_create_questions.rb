class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :label
      t.integer :type

      t.timestamps
    end
  end
end
