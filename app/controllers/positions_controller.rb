class PositionsController < ApplicationController
  before_action :set_position, only: %i[ show edit update destroy ]

  # GET /positions or /positions.json
  def index
    @positions = Position.all.order(name: :desc)
  end

  # GET /positions/1 or /positions/1.json
  def show
    @candidates = @position.candidates
  end

  # GET /positions/new
  def new
    @position = Position.new
    @defaults = []
  end

  # GET /positions/1/edit
  def edit
    @defaults = PositionSkill.where(position_id: @position.id).pluck(:skill_id)
  end

  # POST /positions or /positions.json
  def create  
    @position = Position.new(position_params)
    params[:position][:skill_id].each do |skill|
      if !skill.empty?
        @position.position_skills.build(:skill_id => skill)
      end
    end

    respond_to do |format|
      if @position.save 
        format.html { redirect_to positions_path, notice: "Position was successfully created." }
        format.json { render :show, status: :created, location: @position }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /positions/1 or /positions/1.json
  def update
    params[:position][:skill_id].each do |skill|
      if !skill.empty?
        @position.position_skills.build(:skill_id => skill)
      end
    end

    PositionSkill.where(position_id: @position.id).delete_all
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to @position, notice: "Position was successfully updated." }
        format.json { render :show, status: :ok, location: @position }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /positions/1 or /positions/1.json
  def destroy
    @position.destroy
    respond_to do |format|
      format.html { redirect_to positions_url, notice: "Position was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def position_params
      params.require(:position).permit(:name, :skill_id)
    end
end
