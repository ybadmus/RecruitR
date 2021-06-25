class RecruitersController < ApplicationController
  before_action :set_recruiter, only: %i[show edit update destroy]
  before_action :require_login

  # GET /recruiters or /recruiters.json
  def index
    @recruiters = Recruiter.all
  end

  # GET /recruiters/1 or /recruiters/1.json
  def show; end

  # GET /recruiters/new
  def new
    @recruiter = Recruiter.new
    set_defaults
  end

  # GET /recruiters/1/edit
  def edit
    set_defaults
  end

  # POST /recruiters or /recruiters.json
  def create
    @recruiter = Recruiter.new(recruiter_params)
    set_defaults
    build_positions

    if @recruiter.save
      redirect_to recruiters_path, notice: 'Recruiter was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recruiters/1 or /recruiters/1.json
  def update
    build_positions

    if update_recruiter_position
      redirect_to recruiters_path, notice: 'Recruiter was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /recruiters/1 or /recruiters/1.json
  def destroy
    @recruiter.destroy
    redirect_to recruiters_url, notice: 'Recruiter was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recruiter
    @recruiter = Recruiter.find(params[:id])
  end

  def build_positions
    params[:recruiter][:position_ids].each do |position|
      @recruiter.recruiter_positions.build(position_id: position) unless position.empty?
    end
  end

  def update_recruiter_position
    RecruiterPosition.where(recruiter_id: @recruiter.id).delete_all
    @recruiter.update(recruiter_params)
  end

  def set_defaults
    @defaults = @recruiter.id.nil? ? [] : RecruiterPosition.where(recruiter_id: @recruiter.id).pluck(:position_id)
    @positions = Position.all
  end

  # Only allow a list of trusted parameters through.
  def recruiter_params
    params.require(:recruiter).permit(:name, :email, :position_ids)
  end
end
