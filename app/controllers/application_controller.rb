class ApplicationController < ActionController::Base
  protect_from_forgery

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

end
