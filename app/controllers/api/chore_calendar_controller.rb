class Api::ChoreCalendarController < ApplicationController
  def index
    puts params[:user]
    puts params[:date]
    head :ok
  end

  def show
    # chore_date = Date.parse(params[:date])
    chore_date = Date.strptime(params[:date], '%m/%d/%Y')
    chores = ChoreCalendarService.get_daily_chores_for_user(params[:user], chore_date)
    render json: chores.empty? ? [] : chores.to_json(only: [:id, :checked, :user_completed], :include => {:chore => {:only => :name}})
  end

  def update
    ChoreCalendarService.update_daily_chores(params[:_json])
    head :no_content
  end

  def create
    ChoreCalendarService.create_ad_hoc_chore(chore_id: params[:chore_id], user_id: params[:user_id], date: Date.parse(params[:date]))
    head :created
  rescue ChoreCalendarService::ChoreOrUserNotFound
    head :bad_request
  end

  def delete_old
    chore_date = Date.parse(params[:date])
    ChoreCalendarService.delete_old_chores(chore_date)
    head :no_content
  end

  def create_month
    ChoreSchedulerService.create_month
    head :created
  rescue ChoreSchedulerService::ChoreMonthAlreadyCreatedError
    head :bad_request
  end
end
