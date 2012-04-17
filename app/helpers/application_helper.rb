module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end

  def bootstrap_flash_key(key)
    new_key = case key
    when :alert
      'alert-error'
    when :notice
      'alert-success'
    end
    new_key
  end
end
