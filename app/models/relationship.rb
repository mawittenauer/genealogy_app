class Relationship < ApplicationRecord
  belongs_to :person_one, class_name: 'Person'
  belongs_to :person_two, class_name: 'Person'

  # Validation to ensure relationship uniqueness
  validates :person_one_id, uniqueness: { scope: [:person_two_id, :relationship_type] }
  validates :relationship_type, presence: true

  # You might want to define constants or an enum for relationship types
  RELATIONSHIP_TYPES = ['parent', 'child', 'sibling', 'spouse'].freeze
end
