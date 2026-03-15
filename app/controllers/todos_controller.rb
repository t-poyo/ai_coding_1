class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: %i[show edit update destroy toggle_complete]

  def index
    @todos = current_user.todos

    @todos = case params[:filter]
    when "completed"   then @todos.complete
    when "incomplete"  then @todos.incomplete
    when "overdue"     then @todos.overdue
    else                    @todos.incomplete
    end

    @todos = case params[:sort]
    when "due_date"  then @todos.by_due_date
    when "priority"  then @todos.by_priority
    else                  @todos.order(created_at: :desc)
    end

    @filter = params[:filter] || "incomplete"
    @sort   = params[:sort]   || "created_at"
  end

  def show
  end

  def new
    @todo = current_user.todos.build
  end

  def edit
  end

  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      redirect_to todos_path, notice: "Todoを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: "Todoを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "Todoを削除しました"
  end

  def toggle_complete
    @todo.update(completed: !@todo.completed)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "todo_#{@todo.id}",
          partial: "todos/todo",
          locals: { todo: @todo }
        )
      end
      format.html { redirect_to todos_path }
    end
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :due_date, :priority, :completed)
  end
end
