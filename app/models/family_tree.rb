class FamilyTree < ApplicationRecord
  belongs_to :user
  has_many :people

  def member_count
    people.count
  end
end
