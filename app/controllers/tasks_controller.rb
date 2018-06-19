class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete, :archive]

  # GET /tasks
  # GET /tasks.json
  def index
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = session[:form_input].present? ? Task.new(session.delete(:form_input)) : Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to week_path(start_date: start_date), notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to week_path(start_date: params[:start_date]), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def day
    day_range =  if params[:start_date]
                    params[:start_date].to_datetime.all_day
                  else 
                    Time.now.all_day
                  end
    @tasks = Task.where(start_time: day_range)
  end

  def week
    week_range =  if params[:start_date]
                    params[:start_date].to_datetime.all_week
                  else 
                    Time.now.all_week
                  end

    @tasks = Task.where(start_time: week_range)
  end

  def complete
    @task.completed = true
    if @task.save!
      flash[:notice] = "Task completed!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Ups! Something went wrong."
      redirect_back(fallback_location: root_path)
    end
  end

  def move_to_to_do
    @task.completed = false
    if @task.save!
      flash[:notice] = "Task moved to To Do List!"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "Ups! Something went wrong."
      redirect_back(fallback_location: root_path)
    end
  end

  def keep_form_input
    session[:form_input] = params[:task]
    redirect_to new_task_category_path
  end

  def archive
    @task.archived = true

    if @task.save!
      flash[:notice] = "Archived!"
    else
      flash[:alert] = "Ups! Something went wrong."
    end
    redirect_to root_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :start_time, :color, :description, :task_category_id)
    end

    def start_date
      Date.strptime("#{params[:task]['start_time(1i)']}-#{params[:task]['start_time(2i)']}-#{params[:task]['start_time(3i)']}").to_s
    end
end
