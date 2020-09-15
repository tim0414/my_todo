class Task < ApplicationRecord
  belongs_to :user
  enum status: { incompletion: 0, partial_completion: 1, delay: 2, completion: 3, delayed_completion: 4 }

  def to_output_format
    t = Time.now.utc
    if already_delayed?
      self.status = "delay"
      self.save
    end
    {
      uid: uid,
      name: name,
      note: note,
      status: status,
      due_date: due_date,
    }
  end

  def already_delayed?
    t = Time.now.utc
    due_date < t and (incompletion? or partial_completion?)
  end
end
