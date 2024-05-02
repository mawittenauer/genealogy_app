class RelationshipsController < ApplicationController
  def create
    @relationship = Relationship.new(relationship_params)
    if @relationship.save
      redirect_back(fallback_location: root_path, notice: 'Relationship was successfully created.')
    else
      redirect_back(fallback_location: root_path, alert: 'Error creating relationship.')
    end
  end

  private

  def relationship_params
    params.require(:relationship).permit(:person_one_id, :person_two_id, :relationship_type)
  end
end
