class PeopleController < ApplicationController
  before_action :set_family_tree

  def create
    @person = @family_tree.people.new(person_params)
    if @person.save
      redirect_to family_tree_path(@family_tree), notice: 'Person was successful added.'
    else
      redirect_to family_tree_path(@family_tree), alert: 'Failed to add person.'
    end
  end

  private

  def set_family_tree
    @family_tree = FamilyTree.find(params[:family_tree_id])
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :date_of_birth)
  end
end
