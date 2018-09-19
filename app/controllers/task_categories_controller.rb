class TaskCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task_category, only: %i[show edit update destroy]

  def index
    @task_categories = current_user.task_categories
  end

  def show; end

  def new
    session[:return_to] = request.referer
    @task_category = TaskCategory.new
  end

  def edit; end

  def create
    @task_category = TaskCategory.new(task_category_params)

    if @task_category.save
      redirect_to session.delete(:return_to),
                  notice: t('created')
    else
      render :new
    end
  end

  def update
    if @task_category.update(task_category_params)
      redirect_to task_categories_path, notice: t('updated')
    else
      format.html { render :edit }
    end
  end

  def destroy
    @task_category.destroy
    redirect_to task_categories_url, notice: t('destroyed')
  end

  private

  def set_task_category
    @task_category = TaskCategory.find(params[:id])
  end

  def task_category_params
    params.fetch(:task_category, {}).permit(:name, :color, :user_id)
  end
end
