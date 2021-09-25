class InterviewsController < ApplicationController
  before_action :set_interview, only: %i[show update]
  before_action :require_login

  def index
    @interviews = Interview.includes(:candidate, :recruiter, :score).all.order(created_at: :desc)
  end

  def show
    @score = Score.new
  end

  def create
    @interview = Interview.new(interview_params)
    @interview.interview_date = @interview.interview_date.empty? ? '' : "#{Date.parse(@interview.interview_date.split[0])} #{@interview.interview_date.split[1]}"

    if @interview.save
      Candidate.update(interview_params.candidate_id, matched: true)
      InterviewMailer.with(interview: @interview).new_interview_email.deliver_later
      GoogleCalendar :EventCreator.perform(@interview)
    else
      flash[:alert] = if @interview.interview_date.empty? && @interview.recruiter_id.nil?
                        'Recruiter name and Interview date can\'t be blank, please try again'
                      elsif @interview.interview_date.empty?
                        'Interview date can\'t be blank, please try again'
                      else
                        'Recruiter name can\'t be blank, please try again'
                      end
      redirect_to candidates_path
    end
  end

  def update
    if params[:cancel]
      cancel_interview
    else
      @score = Score.new(score_params)
      if @score.save
        save_score
      else
        flash[:alert] = @score.errors.full_messages.first
        render @score, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @interview.destroy
    redirect_to interviews_url, notice: 'Interview was successfully destroyed.'
  end

  private

  def set_interview
    @interview = Interview.find(params[:id])
  end

  def score_params
    params.require(:score).permit(:experience, :dynamism, :interest, :enthusiasm, :technical_skill)
  end

  def interview_params
    params.require(:interview).permit(:candidate_id, :recruiter_id, :interview_date)
  end

  def cancel_interview
    if Interview.update(@interview.id, closed: true)
      redirect_to interviews_path, notice: 'Interview was successfully canceled.'
    else
      flash[:alert] = @interview.errors.full_messages.first
      render @interview, status: :unprocessable_entity
    end
  end

  def save_score
    if Interview.update(@interview.id, closed: true, score_id: @score.id)
      redirect_to interviews_path, notice: 'Score for applicant successfully created.'
    else
      flash[:alert] = @interview.errors.full_messages.first
      render @interview, status: :unprocessable_entity
    end
  end
end
