class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]
  def home
  end

  def dashboard
    @family_tree = FamilyTree.new
    @family_trees = current_user.family_trees
  end
end
