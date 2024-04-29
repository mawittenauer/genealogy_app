class CreateJoinTablePersonPerson < ActiveRecord::Migration[7.1]
  def change
    create_join_table :parents, :children do |t|
      t.index :parent_id
      t.index :child_id
    end
  end
end
