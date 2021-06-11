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
    set_default
  end

  # GET /recruiters/1/edit
  def edit
    set_default
  end

  # POST /recruiters or /recruiters.json
  def create
    @recruiter = Recruiter.new(recruiter_params)

    build_positions @recruiter

    if @recruiter.save
      redirect_to recruiters_path, notice: "Recruiter was successfully created." 
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recruiters/1 or /recruiters/1.json
  def update
    build_positions @recruiter

    if update_recruiter_position @recruiter
      redirect_to recruiters_path, notice: "Recruiter was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

 # DELETE /recruiters/1 or /recruiters/1.json
  def destroy
    @recruiter.destroy
    flash[:notice] = "Recruiter was successfully destroyed." 
    redirect_to recruiters_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruiter
      @recruiter = Recruiter.find(params[:id])
    end

    def build_positions recruiter
      params[:recruiter][:position_ids].each do |position|
        if !position.empty?
          recruiter.recruiter_positions.build(:position_id => position)
        end
      end
    end

    def update_recruiter_position recruiter
      RecruiterPosition.where(recruiter_id: recruiter.id).delete_all
      recruiter.update(recruiter_params)
    end

    def set_default
      @defaults = !@recruiter.id.nil? ? RecruiterPosition.where(recruiter_id: @recruiter.id).pluck(:position_id) : []
    end

    # Only allow a list of trusted parameters through.
    def recruiter_params
      params.require(:recruiter).permit(:name, :email, :position_ids)
    end
end