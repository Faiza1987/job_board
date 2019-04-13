class JobsController < ApplicationController
  def index 
    @jobs = Job.all.order(:id)
  end

  def show 
    @job = Job.find(params[:id])
  end

  def new 
  end
end
