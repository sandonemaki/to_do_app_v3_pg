class TasksController < ApplicationController
  before_action :task_id_nil?, only: [:edit, :update, :destroy]

  STATUSES =  { undone: 0, done: 1 }
  puts STATUSES
  def index
    # Array
    tasks = Task.where(status: STATUSES[:undone]).order(created_at: :desc).pluck(:id, :image_status, :content, :created_at)
    tasks_view_model = PresenterIndex.new(tasks_ary: tasks)
    render("index", locals: {tasks: tasks_view_model})
  end

  def fin_index
    # Array
    tasks = Task.where(status: STATUSES[:done]).order(created_at: :desc).pluck(:id, :image_status, :content, :created_at)
    tasks_view_model = PresenterIndex.new(tasks_ary: tasks)
    render("fin_index", locals: {tasks: tasks_view_model})
  end

  def new
    task = Task.new #Task<ActiveRecord>
    task_content = task.content
    task_errors = task.errors #Hash #ActiveModel::Errors
    tasks_view_model = PresenterNew.new(content: task_content, errors: task_errors)
    render("new", locals: {task: tasks_view_model})
  end

  def create
    #Task<ActiveRecord>
    task = Task.new(
      content: params[:content],
      status: STATUSES[:undone],
      image_status: "undone.png"
    )
    if task.save
      redirect_to("/")
    else
      task_content = task.content
      task_errors = task.errors
      task_view_model = PresenterNew.new(content: task_content, errors: task_errors)
      render("new", locals: {task: task_view_model})
    end
  end

  def edit
    task = Task.find_by(id: params[:id])
    task_id = task.id
    task_content = task.content
    task_errors = task.errors
    task_view_model = PresenterEdit.new(content: task_content, errors: task_errors, id: task_id)
    render("edit", locals: {task: task_view_model})
  end

  def update
    task = Task.find_by(id: params[:id])
    task_content = params[:content]
    if task.save
      flash[:notice] = "やることを編集しました"
      redirect_to("/")
    else
      task_id = task.id
      task_content = task.content #ActiveModel::Errors
      task_errors = task.errors
      task_view_model = PresenterEdit.new(content: task_content, errors: task_errors, id: task_id)
      render("edit", locals: {task: task_view_model})
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task.destroy
      flash[:notice] = "タスクを削除しました"
      redirect_to(request.referer)
    else
      flash[:notice] = "タスクの削除に失敗しました"
      redirect_to(request.referer)
    end
  end

  def done
    task = Task.find_by(id: params[:id])
    task.status = STATUSES[:done]
    task.image_status = "done.png"
    if task.save
      redirect_to("/")
    else
      flash[:notice] = "保存に失敗しました"
      redirect_to(request.referer)
    end
  end

  def undone
    task = Task.find_by(id: params[:id])
    task.status = STATUSES[:undone]
    task.image_status = "undone.png"
    if task.save!
      redirect_to("/tasks/fin_index")
    else
      flash[:notice] = "保存に失敗しました"
      redirect_to(request.referer)
    end
  end
end
