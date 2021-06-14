class CandidatesController < ApplicationController
  before_action :set_candidate, only: %i[ show edit update destroy ]
  before_action :require_login

  # GET /candidates or /candidates.json
  def index
    @candidates = Candidate.includes(:position).all.order(created_at: :desc)
  end

  # GET /candidates/1 or /candidates/1.json
  def show
    @interview = Interview.new
  end

  # GET /candidates/new
  def new
    @candidate = Candidate.new
    load_positions
  end

  # GET /candidates/1/edit
  def edit
    load_positions
  end

  # POST /candidates or /candidates.json
  def create
    @candidate = Candidate.new(candidate_params)
    load_positions

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to candidates_path, notice: "Candidate was successfully created." }
        format.json { render :show, status: :created, location: @candidate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /candidates/1 or /candidates/1.json
  def update
    respond_to do |format|
      if @candidate.update(candidate_params)
        format.html { redirect_to candidates_path, notice: "Candidate was successfully updated." }
        format.json { render :show, status: :ok, location: @candidate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /candidates/1 or /candidates/1.json
  def destroy
    @candidate.destroy
    respond_to do |format|
      format.html { redirect_to candidates_url, notice: "Candidate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    def load_positions
      @positions = Position.all.order(name: :desc).pluck(:name, :id)
      @positions.unshift(["Select position", ""])
    end

    # Only allow a list of trusted parameters through.
    def candidate_params
      params.require(:candidate).permit(:fname, :lname, :email, :angelist, :linkedin, :position_id)
    end
end
