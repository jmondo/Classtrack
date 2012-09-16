class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_student

  protected

  def access_denied(message = nil)
    flash[:notice] = message || "Access Denied"
    redirect_to "/"
    return false
  end

  def confirm_random_string
    if params[:s]
      session[:s] = params[:s]
    end
    access_denied unless student.confirm_random_string(session[:s])
  end

  def current_student
    @current_student ||= if (id = flash[:student_id])
      flash.delete(:student_id)
      Student.find_by_id(id)
    elsif session[:s]
      Student.find_by_random_string(session[:s])
    end
  end

end
