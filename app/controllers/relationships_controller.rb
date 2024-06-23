class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:destroy]
  before_action :set_family_tree, only: [:new]

  def new
    @people = @family_tree.people
    @relationship = Relationship.new
  end

  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      @family_tree = @relationship.person_one.family_tree
      redirect_to family_tree_path(@family_tree), notice: 'Relationship was successfully created.'
    else
      redirect_back(fallback_location: root_path, alert: 'Error creating relationship.')
    end
  end

  def destroy
    if @relationship.destroy
      redirect_back(fallback_location: root_path, notice: 'Relationship successfully deleted.')
    else
      redirect_back(fallback_location: root_path, alert: 'Error deleting relationship.')
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:person_one_id, :person_two_id, :relationship_type)
  end

  def set_relationship
    @relationship = Relationship.find(params[:id])
  end

  def set_family_tree
    @family_tree = FamilyTree.find(params[:family_tree_id])
    unless @family_tree.user == current_user
      redirect_to dashboard_path, alert: "you do not have permission to view this family tree"
    end
  end
end
