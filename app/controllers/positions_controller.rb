class PositionsController < ApplicationController
  before_action :set_position, only: %i[show edit update destroy]
  before_action :require_login

  # GET /positions or /positions.json
  def index
    @positions = Position.includes(:skills, :candidates).all.order(created_at: :desc)
  end

  # GET /positions/1 or /positions/1.json
  def show; end

  # GET /positions/new
  def new
    @position = Position.new
    set_defaults
  end

  # GET /positions/1/edit
  def edit
    set_defaults
  end

  # POST /positions or /positions.json
  def create
    @position = Position.new(position_params)
    set_defaults
    build_skills

    if @position.save
      redirect_to positions_path, notice: 'Position was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /positions/1 or /positions/1.json
  def update
    build_skills

    if update_position_skills
      redirect_to positions_path, notice: 'Position was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /positions/1 or /positions/1.json
  def destroy
    @position.destroy
    redirect_to positions_url, notice: 'Position was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_position
    @position = Position.find(params[:id])
  end

  def set_defaults
    @defaults = @position.id.nil? ? [] : @position.skills.pluck(:id)
  end

  def update_position_skills
    @position.skills.destroy_all
    @position.update(position_params)
  end

  def build_skills
    params[:position][:skill_id].each do |skill|
      @position.position_skills.build(skill_id: skill) unless skill.empty?
    end
  end

  # Only allow a list of trusted parameters through.
  def position_params
    params.require(:position).permit(:name, :skill_id)
  end
end
