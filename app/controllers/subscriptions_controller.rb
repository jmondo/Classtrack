class SubscriptionsController < ApplicationController
  before_filter :confirm_random_string, only: :destroy

  inherit_resources
  actions :destroy

  def destroy
    destroy! do |format|
      format.html { redirect_to student_path(student) }
    end
  end

  protected

  def interpolation_options
    { code: resource.course.code }
  end

  def student
    resource.student
  end
end
