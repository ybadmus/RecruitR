class RecruitersController < ApplicationController
  before_action :set_recruiter, only: %i[ show edit update destroy ]

  # GET /recruiters or /recruiters.json
  def index
    @recruiters = Recruiter.all
  end

  # GET /recruiters/1 or /recruiters/1.json
  def show
  end

  # GET /recruiters/new
  def new
    @recruiter = Recruiter.new
    @defaults = []
  end

  # GET /recruiters/1/edit
  def edit
    @defaults = RecruiterPosition.where(recruiter_id: @recruiter.id).pluck(:position_id)
  end

  # POST /recruiters or /recruiters.json
  def create
    @recruiter = Recruiter.new(recruiter_params)
    params[:recruiter][:position_id].each do |position|
      if !position.empty?
        @recruiter.recruiter_positions.build(:position_id => position)
      end
    end

    respond_to do |format|
      if @recruiter.save
        format.html { redirect_to recruiters_path, notice: "Recruiter was successfully created." }
        format.json { render :show, status: :created, location: @recruiter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recruiters/1 or /recruiters/1.json
  def update
    params[:recruiter][:position_id].each do |position|
      if !position.empty?
        @recruiter.recruiter_positions.build(:position_id => position)
      end
    end

    RecruiterPosition.where(recruiter_id: @recruiter.id).delete_all
    respond_to do |format|
      if @recruiter.update(recruiter_params)
        format.html { redirect_to recruiters_path, notice: "Recruiter was successfully updated." }
        format.json { render :show, status: :ok, location: @recruiter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recruiter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recruiters/1 or /recruiters/1.json
  def destroy
    @recruiter.destroy
    respond_to do |format|
      format.html { redirect_to recruiters_url, notice: "Recruiter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruiter
      @recruiter = Recruiter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recruiter_params
      params.require(:recruiter).permit(:name, :email, :position_id)
    end
end
