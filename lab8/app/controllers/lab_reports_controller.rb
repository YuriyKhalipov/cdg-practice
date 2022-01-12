class LabReportsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @lab_report = LabReport.find_by id: params[:id]
    @lab_report.destroy
    redirect_to lab_reports_path
  end

  def mark
    @lab_report = LabReport.find_by id: params[:id]
  end
  
  def edit
    @lab_report = LabReport.find_by id: params[:id]
  end

  def show
    @lab_report = LabReport.find_by id: params[:id]
  end

  def update
    @lab_report = LabReport.find_by id: params[:id]
    if @lab_report.update update_params
      redirect_to lab_reports_path
    else
      flash[:Error] = 'Error'
    end
  end

  def index
  	@lab_reports = LabReport.all
  end

  def new
    @lab_report = LabReport.new
  end

  def create
    @lab_report = LabReport.new lab_report_params

    if @lab_report.save
      redirect_to lab_reports_path
    else
      render :new
    end
  end

  def lab_report_params
    params.require(:lab_report).permit(:title, :description, :grade).merge(user_id: current_user.id)
  end

  def update_params
    params.require(:lab_report).permit(:title, :description, :grade)
  end
end