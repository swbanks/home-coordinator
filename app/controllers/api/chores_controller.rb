class Api::ChoresController < ApplicationController
  # renders all the chores
  def index
    chores = []
    Chore.find_each do |chore|
      chores << {'id': chore.id, 'name': chore.name}
    end

    render json: chores
  end

  # create a new chore
  def create
    chore = Chore.create!({name: params[:name]})
    render json: {
      'id': chore.id,
      'name': chore.name
    }
  end

  # display a specific chore by id
  def show
    chore = Chore.find(params[:id])
    render json: {
      'id': chore.id,
      'name': chore.name
    }
  end

  # update a specific chore
  def update
  end

  # delete a specific chore
  def destroy
    chore = Chore.find(params[:id])
    chore.destroy!
    head :no_content
  end

  def update_family_verse
    chore = Chore.where("name LIKE 'Family Verse - %'").first
    chore.update!(name: "Family Verse - #{params[:verse]}")
    head :no_content
  end
end
