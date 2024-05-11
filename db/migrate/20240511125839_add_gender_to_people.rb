class AddGenderToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :gender, :string, limit: 1
  end
end
