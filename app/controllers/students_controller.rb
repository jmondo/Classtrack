class StudentsController < ApplicationController
  inherit_resources

  def create
    create! do |format|
      format.html { redirect_to root_path }
    end
  end
end
