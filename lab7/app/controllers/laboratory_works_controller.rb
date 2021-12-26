class LaboratoryWorksController < ApplicationController

  def index
    @labs = LaboratoryWork.all
  end

  def show
    @lab = LaboratoryWork.find(params[:id])
  end

  def new
    @lab = LaboratoryWork.new
  end

  def create
    lab = LaboratoryWork.new(params.require(:laboratory_work).permit(:title, :text))
    lab.user_id = 1
    redirect_to root_path
    flash[:Error] = 'The report was not created' unless lab.save
  end

  def edit
    @lab = LaboratoryWork.find(params[:id])
  end

  def update
    @lab = LaboratoryWork.find(params[:id])
    @lab.update(params.permit(:title, :text))
    redirect_to root_url
  end

  def destroy
    @lab = LaboratoryWork.find(params[:id])
    @lab.destroy
    redirect_to root_url
  end

  def mark
    @lab = LaboratoryWork.find(params[:id])
  end

  def grade
    @lab = LaboratoryWork.find(params[:id])
    redirect_to root_path
    flash[:Error] = 'The mark was entered incorrectly' unless @lab.update(params.permit(:mark))
  end
end
