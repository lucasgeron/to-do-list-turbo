class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.order(created_at: :desc)
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
  
    respond_to do |format|
      format.turbo_stream do 
        if @task.save
          render turbo_stream: [
            turbo_stream.update('flash', partial: "layouts/flash", locals: { type:'notice', message:"Task was successfully created."}),
            turbo_stream.prepend("tasks", partial: "tasks/task", locals: { task: @task })
          ]
        else
          render turbo_stream: turbo_stream.update('flash', partial: "layouts/flash", locals: { type:'alert', message:@task.errors.full_messages.join(', ')})
        end
      end
    end
    
  end
  

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@task),
            turbo_stream.update('flash', partial: "layouts/flash", locals: { type:'notice', message:"Task ID:#{@task.id} was successfully updated."}),
          ]
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update('flash', partial: "layouts/flash", locals: { type:'alert', message:"Task ID: #{@task.id} - #{@task.errors.full_messages.join(', ')}"})
        end
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove(@task),
          turbo_stream.update('flash', partial: "layouts/flash", locals: { type:'notice', message:"Task ID:#{@task.id} was successfully deleted."}),
        ]
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:complete, :description)
    end

end
