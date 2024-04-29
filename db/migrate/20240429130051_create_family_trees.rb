class CreateFamilyTrees < ActiveRecord::Migration[7.1]
  def change
    create_table :family_trees do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
