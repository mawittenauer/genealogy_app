class PeopleController < ApplicationController
  before_action :set_family_tree
  before_action :set_person, only: [:destroy, :show, :edit, :update]

  def tree
    @person = @family_tree.people.find(params[:person_id])
    @person_mother = @person.mother
    @person_father = @person.father
    @data = [
      { id: @person.id, mid: @person.mother&.id, fid: @person.father&.id, name: @person.full_name, gender: @person.gender, date_of_birth: @person.date_of_birth, bio: @person.bio }
    ];

    if @person_father
      @data.push({ id: @person_father.id, pids: [@person.mother&.id], name: @person_father.full_name, gender: 'male', date_of_birth: @person_father.date_of_birth, bio: @person_father.bio })
    end

    if @person_mother
      @data.push({ id: @person_mother.id, pids: [@person.father&.id], name: @person_mother.full_name, gender: 'female', date_of_birth: @person_mother.date_of_birth, bio: @person_mother.bio })
    end

    @data = @data.to_json()
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
    params.require(:person).permit(:first_name, :last_name, :date_of_birth, :bio, :nickname, :birthplace, :gender)
  end
end
