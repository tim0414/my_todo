class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    tasks = current_user.tasks
    ret = tasks.map(&:to_output_format)
    return render json: ret
  end

  def create
    name = params.require(:name)
    note = params[:note]
    due_date = params.require(:due_date)
    uid = SecureRandom.hex(12)

    task = current_user.tasks.create(
      uid: uid,
      name: name,
      note: note,
      due_date: due_date,
      status: "incompletion"
    )

    return render json: task.to_output_format
  end

  def update
    @task_uid = params.require(:task_uid)
    field = params.require(:field)
    update_value = params.require(:update_value)

    unless target_task.blank?
      update_info = {field =>  update_value}
      ret = target_task.update(update_info)
    end

    return render json: target_task.to_output_format
  end

  def update_status
    @task_uid = params.require(:task_uid)
    status = params.require(:update_value)

    current_time = Time.now.utc
    if current_time > target_task.due_date
      # 在 delay 的狀況下 partial_completion 不更改狀態
      routine_task.update(status: "delayed_completion") if status == "completion"
    else
      routine_task.update(status: status)
    end

    return render json: target_task.to_output_format
  end

  def delete
    @task_uid = params.require(:task_uid)

    unless target_task.blank?
      target_task.delete
    end

    return render json: {}
  end

  private
  def target_task
    tasks = current_user.tasks
    target_task = tasks.select {|task| task.uid == @task_uid}.first
  end
end
