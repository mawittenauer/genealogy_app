class FamilyTree < ApplicationRecord
  belongs_to :user
  has_many :people

  validates :name, presence: { message: 'is required' }
  validates :description, presence: { message: 'is required' }

  def males_older_than(person)
    people.where(gender: 'male').where("date_of_birth < ?", person.date_of_birth)
  end

  def females_older_than(person)
    people.where(gender: 'female').where("date_of_birth < ?", person.date_of_birth)
  end

  def member_count
    people.count
  end
end
