class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy complete archive]

  def index; end

  def show; end

  def new
    set_redirect_path

    @task = if session[:form_input].present?
              Task.new(session.delete(:form_input))
            else
              Task.new
            end
  end

  def edit; end

  def create
    @task = Task.new(task_params)
    @task.user = current_user

    if @task.save
      path = session.delete(:redirect_path) || week_path(start_date: start_date)
      redirect_to path, notice: t('created')
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: t('updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to week_path(start_date: params[:start_date]),
                notice: t('destroyed')
  end

  def day
    day_range = if params[:start_date]
                  params[:start_date].to_datetime.all_day
                else
                  Time.now.all_day
                end

    @tasks = current_user.tasks.where(start_time: day_range)
  end

  def week
    @week_range = if params[:start_date]
                    params[:start_date].to_datetime.all_week
                  else
                    Time.now.all_week
                  end

    @tasks = current_user.tasks.where(start_time: @week_range)
  end

  def complete
    @task.completed = true

    if @task.save!
      flash[:notice] = t('completed')
    else
      flash[:alert] = t('something_went_wrong')
    end

    redirect_back(fallback_location: root_path)
  end

  def move_to_to_do
    @task.completed = false

    if @task.save!
      flash[:notice] = 'Task moved to To Do List!'
    else
      flash[:alert] = 'Ups! Something went wrong.'
    end

    redirect_back(fallback_location: root_path)
  end

  def keep_form_input
    session[:form_input] = params[:task]
    redirect_to new_task_category_path
  end

  def archive
    @task.archived = true

    if @task.save!
      flash[:notice] = t('archived')
    else
      flash[:alert] = t('something_went_wrong')
    end

    redirect_to root_path
  end

  private

  def set_redirect_path
    referer = request.referer
    session[:redirect_path] = referer if referer && referer.include?('/day')
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :start_time, :color,
                                 :description, :task_category_id)
  end

  def start_date
    Date.strptime("#{params[:task]['start_time(1i)']}" \
                  "-#{params[:task]['start_time(2i)']}" \
                  "-#{params[:task]['start_time(3i)']}").to_s
  end
end
