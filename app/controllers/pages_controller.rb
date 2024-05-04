class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  before_action :redirect_if_authenticated, only: [:home]
  
  def home
  end

  def dashboard
    @family_tree = FamilyTree.new
    @family_trees = current_user.family_trees
  end

  private

  def redirect_if_authenticated
    redirect_to dashboard_path if user_signed_in?
  end
end
