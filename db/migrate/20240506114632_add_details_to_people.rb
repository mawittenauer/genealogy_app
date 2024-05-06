class AddDetailsToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :nickname, :string
    add_column :people, :birthplace, :string
    add_column :people, :bio, :text
  end
end
