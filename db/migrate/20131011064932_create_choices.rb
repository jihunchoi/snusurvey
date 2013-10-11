class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :label
      t.boolean :checked

      t.timestamps
    end
  end
end
