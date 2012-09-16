class StudentsController < ApplicationController
  inherit_resources
  actions :all, except: [:edit]

  before_filter :confirm_random_string, only: [:show]

  def create
    if !build_resource.new_record?
      update
    else
      create! do |format|
        format.html do
          flash[:student_id] = resource.id
          redirect_to root_path
        end
      end
    end
  end

  def update
    update! do |success,failure|
      success.html do
        flash[:notice] = t("flash.students.update.notice")
        flash[:student_id] = resource.id
        redirect_to root_path
      end
      failure.html do
        # flash[:alert] = t("flash.students.update.alert")
        redirect_to root_path
      end
    end
  end

  protected

  def build_resource
    @student ||= Student.find_or_initialize_by_email(params[:student])
  end

  def student
    resource
  end

end
