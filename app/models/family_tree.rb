class FamilyTree < ApplicationRecord
  belongs_to :user
  has_many :people
end
