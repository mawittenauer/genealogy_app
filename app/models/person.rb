class Person < ApplicationRecord
  belongs_to :family_tree, optional: true
  # Relationships with other people
  has_many :relationships_as_person_one, class_name: 'Relationship', foreign_key: 'person_one_id', dependent: :destroy
  has_many :relationships_as_person_two, class_name: 'Relationship', foreign_key: 'person_two_id', dependent: :destroy

  # Through relationships
  has_many :related_people_as_person_one, through: :relationships_as_person_one, source: :person_two
  has_many :related_people_as_person_two, through: :relationships_as_person_two, source: :person_one

  validates :first_name, presence: { message: 'is required' }
  validates :last_name, presence: { message: 'is required' }
  validates :gender, presence: { message: 'is required' }
  validates :date_of_birth, presence: { message: 'is required' }
  validates :nickname, length: { maximum: 50 }
  
  # Validates that the gender is either 'M' or 'F'
  enum gender: { male: 'M', female: 'F' }

  def relationships
    Relationship.where("person_one_id = ? OR person_two_id = ?", self.id, self.id)
  end

  def spouse
    spouse_relationship_one = Relationship.where("person_one_id = ? AND relationship_type = ?", self.id, "spouse")
    spouse_relationship_two = Relationship.where("person_two_id = ? AND relationship_type = ?", self.id, "spouse")
    if spouse_relationship_one.length > 0
      spouse_relationship_one.map { |r| r.person_two }[0]
    else
      spouse_relationship_two.map { |r| r.person_one }[0]
    end
  end

  def parents
    parent_relationships = Relationship.where("person_two_id = ? AND relationship_type = ?", self.id, "parent")
    parent_relationships.map { |r| r.person_one }
  end

  def mother
    parents.select { |p| p.gender == 'female' }[0]
  end

  def father
    parents.select { |p| p.gender == 'male' }[0]
  end

  def children
    child_relationships = Relationship.where("person_one_id = ? AND relationship_type = ?", self.id, "parent")
    child_relationships.map { |r| r.person_two }
  end

  def siblings
    sibling_relationships = Relationship.where("person_one_id IN (?) AND relationship_type = ?", self.parents.map { |p| p.id }, "parent")
    sibling_relationships = sibling_relationships.select { |r| r.person_two_id != self.id }
    sibling_relationships.map { |r| r.person_two }.uniq
  end

  def tree_data
    person_mother = self.mother
    person_father = self.father
    data = [
      { id: self.id, mid: self.mother&.id, fid: self.father&.id, name: self.full_name, gender: self.gender, date_of_birth: self.date_of_birth, bio: self.bio }
    ];

    if person_father
      data.push({ id: person_father.id, pids: [self.mother&.id], name: person_father.full_name, gender: 'male', date_of_birth: person_father.date_of_birth, bio: person_father.bio })
    end

    if person_mother
      data.push({ id: person_mother.id, pids: [self.father&.id], name: person_mother.full_name, gender: 'female', date_of_birth: person_mother.date_of_birth, bio: person_mother.bio })
    end

    data.to_json()
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
