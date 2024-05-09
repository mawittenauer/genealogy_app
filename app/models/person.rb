class Person < ApplicationRecord
  belongs_to :family_tree, optional: true
  # Relationships with other people
  has_many :relationships_as_person_one, class_name: 'Relationship', foreign_key: 'person_one_id', dependent: :destroy
  has_many :relationships_as_person_two, class_name: 'Relationship', foreign_key: 'person_two_id', dependent: :destroy

  # Through relationships
  has_many :related_people_as_person_one, through: :relationships_as_person_one, source: :person_two
  has_many :related_people_as_person_two, through: :relationships_as_person_two, source: :person_one

  validates :nickname, length: { maximum: 50 }

  def relationships
    Relationship.where("person_one_id = ? OR person_two_id = ?", self.id, self.id)
  end

  def full_name
  "#{first_name} #{last_name}"
  end

  def relationship_type_for(relationship)
    if id == relationship.person_one_id
      case relationship.relationship_type
      when 'parent'
        'Child'
      else
        relationship.relationship_type.humanize
      end
    else
      relationship.relationship_type.humanize
    end
  end
end
