class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:destroy]

  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      redirect_back(fallback_location: root_path, notice: 'Relationship was successfully created.')
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
end
