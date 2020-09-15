class RoutineTasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @routine_task_info_uid = params.require(:routine_task_info_uid)
    current_time = Time.now.utc
    if routine_task_info.latest_routine_task.due_date < current_time
      routine_task_info.create_next_routine_task(current_time)
    end
    ret = routine_task_info.routine_tasks.map(&:to_output_format)

    return render json: ret
  end

  def update
    @routine_task_info_uid = params.require(:routine_task_info_uid)
    routine_task_uid = params.require(:routine_task_uid)
    status = params.require(:status)

    current_time = Time.now.utc
    routine_task = routine_task_info.routine_tasks.select {|task| task.uid == routine_task_uid}.first

    if current_time > routine_task.due_date
      # 在 delay 的狀況下 partial_completion 不更改狀態
      routine_task.update(status: "delayed_completion") if status == "completion"
    else
      routine_task.update(status: status)
    end

    return render json: routine_task.to_output_format
  end

  private
  def routine_task_info
    routine_task_info ||= RoutineTaskInfo.find_by(uid: @routine_task_info_uid)
  end
end
