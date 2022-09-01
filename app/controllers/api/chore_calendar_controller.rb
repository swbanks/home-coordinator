class Api::ChoreCalendarController < ApplicationController
  def index
    puts params[:user]
    puts params[:date]
    head :ok
  end

  def show
    chore_date = Date.parse(params[:date])
    chores = ChoreCalendarService.get_daily_chores_for_user(params[:user], chore_date)
    render json: chores.empty? ? [] : chores.to_json(only: [:checked, :user_completed], :include => {:chore => {:only => :name}})
  end
end
