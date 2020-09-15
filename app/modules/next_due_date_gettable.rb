module NextDueDateGettable
  def get_next_due_date(period, routine_time, current_time)
    # TODO test
    case period
    when "year"
      current_year = Time.new(current_time.year).utc
      t = current_time.to_i - current_year.to_i
      year = (t > routine_time)? current_time.year+1 : current_time.year
      puts "year: #{year}"
      due_date = Time.at(Time.new(year).to_i + routine_time).utc
    when "month"
      current_month = Time.new(current_time.year, current_time.month).utc
      t = current_time.to_i - current_month.to_i
      month = (t > routine_time)? current_month.month+1 : current_month.month
      year = (month > 12)? current_time.year+1 : current_time.year
      due_date = Time.at(Time.new(year, month%12).to_i + routine_time).utc
    when "weekday"
      weekday = current_time.wday
      current_weekday = current_time - weekday.day
      t = current_time.to_i - current_weekday.to_i
      delta = (t > routine_time)? 1.week.to_i-routine_time : routine_time-t
      due_date = Time.at(current_time.to_i+delta).utc
    when "day"
      current_day = Time.new(current_time.year, current_time.month, current_time.day)
      t = current_time.to_i - current_day.to_i
      delta = (t > routine_time)? 1.day.to_i-routine_time : routine_time-t
      due_date = Time.at(current_time.to_i+delta).utc
    end

    return due_date
  end
end
