class PeopleController < ApplicationController
  before_action :set_family_tree
  before_action :set_person, only: [:destroy, :show]

  def show
    @relationships = @person.relationships
    @related_people = @person.related_people
  end

  def create
    @person = @family_tree.people.new(person_params)
    if @person.save
      redirect_to family_tree_path(@family_tree), notice: 'Person was successful added.'
    else
      redirect_to family_tree_path(@family_tree), alert: 'Failed to add person.'
    end
  end

  def destroy
    @person.destroy
    redirect_to family_tree_path(@family_tree), notice: 'Person was successfully deleted.'
  end

  private

  def set_family_tree
    @family_tree = FamilyTree.find(params[:family_tree_id])
    unless @family_tree.user == current_user
      redirect_to dashboard_path, alert: "you do not have permission to view this family tree"
    end
  end

  def set_person
    @person = @family_tree.people.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :date_of_birth)
  end
end
