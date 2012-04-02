class CoursesController < ApplicationController
  inherit_resources
  actions :index
  respond_to :json

  protected

  def collection
    @courses ||= Course.where(semester_id: Semester.active)
  end
end