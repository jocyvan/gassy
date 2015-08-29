module ApplicationHelper
  def get_day_this_month(first_or_last)
    if first_or_last == :first
      Date.today.at_beginning_of_month.to_s(:db)
    else
      Date.today.at_end_of_month.to_s(:db)
    end
  end

  def get_day_prev_month(first_or_last)
    if first_or_last == :first
      Date.today.at_beginning_of_month.prev_month.to_s(:db)
    else
      Date.today.at_end_of_month.prev_month.to_s(:db)
    end
  end

  def get_day_prev_2_month(first_or_last)
    if first_or_last == :first
      Date.today.at_beginning_of_month.prev_month.prev_month.to_s(:db)
    else
      Date.today.at_end_of_month.prev_month.prev_month.to_s(:db)
    end
  end
end
