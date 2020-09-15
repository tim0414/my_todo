class RoutineTaskInfosController < ApplicationController
  include NextDueDateGettable
  before_action :authenticate_user!

  def index
    routine_task_infos = current_user.routine_task_infos
    ret = routine_task_infos.map(&:to_output_format)
    return render json: ret
  end

  def create
    name = params.require(:name)
    period = params.require(:period)
    routine_time = params.require(:routine_time)
    note = params[:note]
    routine_task_info_uid = SecureRandom.hex(12)

    routine_task_info = current_user.routine_task_infos.create(
      uid: routine_task_info_uid,
      name: name,
      note: note,
      period: period,
      routine_time: routine_time,
    )

    current_time = Time.now.utc
    due_date = get_next_due_date(routine_task_info.period, routine_time, current_time)
    puts "due_date: #{due_date}"

    routine_task_uid = SecureRandom.hex(12)
    routine_task_info.routine_tasks.create(
      uid: routine_task_uid,
      status: "incompletion",
      due_date: due_date,
    )

    return render json: routine_task_info.to_output_format
  end

  def update
    @routine_task_info_uid = params.require(:routine_task_info_uid)
    field = params.require(:field)
    update_value = params.require(:update_value)

    unless target_routine_task_info.blank?
      update_info = { field => update_value }
      target_routine_task_info.update(update_info)
    end

    return render json: target_routine_task_info.to_output_format
  end

  def update_period
    @routine_task_info_uid = params.require(:routine_task_info_uid)
    period = params.require(:period)
    routine_time = params.require(:routine_time)

    routine_task = target_routine_task_info.latest_routine_task
    if routine_task.already_delayed?
      routine_task.status = "delay"
      routine_task.save
    else
      routine_task.delete
    end
    target_routine_task_info.update(period: period, routine_time: routine_time)
    target_routine_task_info.create_next_routine_task

    return render json: target_routine_task_info.to_output_format
  end

  def update_routine_time
    @routine_task_info_uid = params.require(:routine_task_info_uid)
    routine_time = params.require(:routine_time)

    routine_task = target_routine_task_info.latest_routine_task
    if routine_task.already_delayed?
      routine_task.status = "delay"
      routine_task.save
    else
      routine_task.delete
    end
    target_routine_task_info.update(period: period)
    target_routine_task_info.create_next_routine_task

    return render json: target_routine_task_info.to_output_format
  end

  def delete
    @routine_task_info_uid = params.require(:routine_task_info_uid)

    unless target_routine_task_info.blank?
      target_routine_task_info.delete
    end

    return render json: {}
  end

  private

  def target_routine_task_info
    routine_task_infos = current_user.routine_task_infos
    target_routine_task_info = routine_task_infos.select {|task| task.uid == @routine_task_info_uid}.first
  end
end
