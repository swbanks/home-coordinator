class Api::UsersController < ApplicationController
  def index
    users = []
    User.find_each do |user|
      users << {'id': user.id, 'name': user.name}
    end

    render json: users
  end
end