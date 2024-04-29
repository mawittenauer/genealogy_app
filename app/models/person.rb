class Person < ApplicationRecord
  belongs_to :family_tree, optional: true
  has_many :parent_relationships, foreign_key: "child_id", class_name: "PersonRelationship"
  has_many :parents, through: :parent_relationships, source: :parent

  has_many :child_relationships, foreign_key: "parent_id", class_name: "PersonRelationship"
  has_many :children, through: :child_relationships, source: :child
end
