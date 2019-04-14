class JobsController < ApplicationController
  def index 
    @jobs = Job.all.order(:id)
  end

  def show 
    @job = Job.find(params[:id])
  end

  def new 
    @job = Job.new
  end

  def create 
    @job = Job.new(
      title: params[:job][:title],
      description: params[:job][:description],
      company: params[:job][:company]
    )
    if @job.save
      redirect_to jobs_path # goes all the way through the request cycle again
    else
      render :new # take whatever data the controller currently has and send only that data back to the browser; we want to hang on to the current job object
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    is_successful = @job.update(
      {
        title: params[:job][:title],
        description: params[:job][:description],
        company: params[:job][:company]
      }
    )

    if is_successful
      redirect_to job_path(@job.id) # OR params[:id]
    else
      # if unsuccessful, stays on the edit form
      render :edit
    end
  end
end
