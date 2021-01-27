module ApplicationHelper
  def timer_background(block)
    if block.time_remaining[:minutes] > 15
      return 'timer_normal'
    elsif block.time_remaining[:minutes] > 5
      return 'timer_warning'
    else
      return 'timer_danger'
    end
  end
end
