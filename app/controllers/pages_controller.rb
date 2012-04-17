class PagesController < ApplicationController

  def sms_configuration
    set_session_by_param
    please_pay_if_not_sent_from_gumroad!
  end

  protected

  def please_pay_if_not_sent_from_gumroad!
    if session[:payment_conf]
      redirect_to sms_path if params[:payment_conf]
    else
      flash[:alert] = "Please don't cheat. You're making your whole semester better for the price of one morning coffee."
      redirect_to root_path
    end
  end

  def set_session_by_param
    if params[:payment_conf] == "3scj7is"
      session[:payment_conf] = true
    end
  end

end
