class FamilyTreesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_family_tree, only: [:show]

  def create
    @family_tree = FamilyTree.new(family_tree_params)
    @family_tree.user = current_user  # Assuming each tree is associated with a user

    if @family_tree.save
      redirect_to dashboard_path, notice: 'Family tree was successfully created.'
    else
      render 'pages/dashboard', status: :unprocessable_entity
    end
  end

  def show
    @people = @family_tree.people
  end

  private

  def family_tree_params
    params.require(:family_tree).permit(:name, :description)
  end

  def set_family_tree
    @family_tree = FamilyTree.find(params[:id])
    unless @family_tree.user == current_user
      redirect_to dashboard_path, alert: "you do not have permission to view this family tree"
    end
  end
end
