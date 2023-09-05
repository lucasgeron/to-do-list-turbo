module TasksHelper
  def get_svg_icon(task)
    if task.complete?
      return 'M9 15L3 9m0 0l6-6M3 9h12a6 6 0 010 12h-3'
    else
      return 'M4.5 12.75l6 6 9-13.5'
    end
  end
end
