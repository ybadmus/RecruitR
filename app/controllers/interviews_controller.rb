class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[ show update ]

  def index
    @interviews = Interview.all.order(created_at: :desc)
  end

  def show
    @score = Score.new
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

  def update
    respond_to do |format|
      if Interview.update(@interview.id, closed: true)
        format.html { redirect_to interviews_path, notice: "Interview was successfully closed." }
        format.json { render :show, status: :created, location: @interview }
      else
        format.html { render @interview, status: :unprocessable_entity }
        format.json { render json: @interview.errors, status: :unprocessable_entity }
      end                   
    end
  end

  def destroy
    @interview.destroy
    respond_to do |format|
      format.html { redirect_to interviews_url, notice: "Interview was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_interview
      @interview = Interview.find(params[:id])
    end
end