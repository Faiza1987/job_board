class JobsController < ApplicationController
  def index 
    @jobs = Job.all.order(:id)
  end
end
