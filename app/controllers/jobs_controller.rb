class JobsController < ApplicationController
  def index 
    @jobs = Job.all.order(:id)
  end

  def show 
    @job = Job.find_by(id: params[:id])

    if @job.nil?
      redirect_to jobs_path
    end
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
    @job = Job.find_by(id: params[:id])
  end

  def update
    @job = Job.find_by(id: params[:id])
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

  def destroy
    # we only need instance variables when they are accessed in a view external from the controller.

    # If we're not accessing variables inside of a view, they should not be instance variables

    job = Job.find_by(id: params[:id])

    if job.destroy 
      redirect_to jobs_path
    else 
    end

  end

  private
  
  def job_params
    return params.require(:job).permit(:title, :description, :company)
  end
end
