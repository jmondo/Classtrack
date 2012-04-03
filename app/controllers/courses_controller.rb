class CoursesController < ApplicationController
  inherit_resources
  actions :index
  respond_to :json

  protected

  def collection
    @courses ||= Course.where(semester_id: Semester.active).where("title ilike ? or code ilike ? or instructors ilike ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
  end
end