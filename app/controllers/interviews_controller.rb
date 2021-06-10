class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[ show ]

  def index
    @interviews = Interview.all.order(updated_at: :desc)
  end

  def show
  end

  def create
    @interview = Interview.new({candidate_id: params[:candidate_id],
      recruiter_id: params[:recruiter_id], interview_date: params[:interview_date], score_id: nil})

    respond_to do |format|
      if @interview.save && Candidate.update(params[:candidate_id], matched: true)
        format.html { redirect_to interviews_path, notice: "Interview was successfully created." }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { redirect_to candidate_path params[:candidate_id] }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_interview
      @interview = Interview.find(params[:id])
    end
end