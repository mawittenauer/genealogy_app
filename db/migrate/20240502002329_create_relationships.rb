class CreateRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :relationships do |t|
      t.integer :person_one_id
      t.integer :person_two_id
      t.string :relationship_type

      t.timestamps
    end
  end
end
