class AddFAmilyTreeToPersons < ActiveRecord::Migration[7.1]
  def change
    add_reference :people, :family_tree, null: false, foreign_key: true
  end
end
