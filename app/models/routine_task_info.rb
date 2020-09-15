class RoutineTaskInfo < ApplicationRecord
  include NextDueDateGettable
  belongs_to :user
  has_many :routine_tasks, dependent: :destroy
  enum period: { year: 0, month: 1, weekday: 2, day: 3 }

  def to_output_format
    {
      uid: uid,
      name: name,
      note: note,
      period: period,
      routine_time: routine_time,
    }
  end

  def create_next_routine_task(current_time)
    due_date = get_next_due_date(period, routine_time, current_time)
    uid = SecureRandom.hex(12)
    routine_tasks.create(
      uid: uid,
      due_date: due_date,
      status: "incompletion",
    )
  end

  def latest_routine_task
    routine_tasks.max {|t1, t2| t1.due_date <=> t2.due_date}
  end
end
