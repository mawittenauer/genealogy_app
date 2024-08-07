class PeopleController < ApplicationController
  before_action :set_family_tree
  before_action :set_person, only: [:destroy, :show, :edit, :update]

  def tree
    @person = @family_tree.people.find(params[:person_id])
    @data = @person.tree_data
  end

  def new
    @people = @family_tree.people
  end

  def show
    @relationships = @person.relationships
  end

  def destroy
    @person.destroy
    redirect_to family_tree_path(@family_tree), notice: 'Person was successfully deleted.'
  end

  def edit
  end

  def new_spouse
    @person = @family_tree.people.find(params[:person_id])
    @people = @family_tree.people
    @relationship = Relationship.new
    @relationship.person_one_id = params[:person_id]
    @relationship.relationship_type = 'spouse'
  end

  def new_father
    @person = @family_tree.people.find(params[:person_id])
    @people = @family_tree.people
    @possible_fathers = @family_tree.males_older_than(@person)
    @relationship = Relationship.new
    @relationship.person_two_id = params[:person_id]
    @relationship.relationship_type = 'parent'
  end

  def new_mother
    @person = @family_tree.people.find(params[:person_id])
    @people = @family_tree.people
    @possible_mothers = @family_tree.females_older_than(@person)
    @relationship = Relationship.new
    @relationship.person_two_id = params[:person_id]
    @relationship.relationship_type = 'parent'
  end

  def update
    if @person.update(person_params)
      redirect_to family_tree_person_path(@family_tree, @person), notice: 'Person was successfully updated.'
    else
      flash[:errors] = @person.errors.full_messages
      redirect_to edit_family_tree_person_path(@family_tree, @person)
    end
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
    params.require(:person).permit(:first_name, :last_name, :maiden_name, :date_of_birth, :bio, :nickname, :birthplace, :gender)
  end
end
