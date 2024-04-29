class FamilyTreesController < ApplicationController
  before_action :authenticate_user!

  def create
    @family_tree = FamilyTree.new(family_tree_params)
    @family_tree.user = current_user  # Assuming each tree is associated with a user

    if @family_tree.save
      redirect_to dashboard_path, notice: 'Family tree was successfully created.'
    else
      render 'pages/dashboard', status: :unprocessable_entity
    end
  end

  private

  def family_tree_params
    params.require(:family_tree).permit(:name, :description)
  end
end
