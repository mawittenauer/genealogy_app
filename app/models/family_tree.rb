class FamilyTree < ApplicationRecord
  belongs_to :user
  has_many :people

  validates :name, presence: { message: 'is required' }
  validates :description, presence: { message: 'is required' }

  def member_count
    people.count
  end
end
