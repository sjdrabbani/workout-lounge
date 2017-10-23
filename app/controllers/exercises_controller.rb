class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercises = current_user.exercises.where('workout_date >= ?', 7.days.ago)
    @friends = current_user.friends
    set_current_room
    @message = Message.new
  end

  def show
  end

  def new
    @exercise = current_user.exercises.new
  end

  def edit
  end

  def update
    if @exercise.update_attributes(exercise_params)
      flash[:notice] = 'Exercise has been updated.'
      redirect_to user_exercise_path(current_user, @exercise)
    else
      flash.now[:alert] = 'Exercise has not been updated' 
      render :edit
    end
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    if @exercise.save
      flash[:notice] = 'Exercise has been created.'
      redirect_to  user_exercise_path(current_user, @exercise)
    else  
      flash.now[:alert] = 'Exercise has not been created'
      render :new
    end
  end

  def destroy
    @exercise.destroy

    flash[:notice] = 'Exercise has been deleted'
    redirect_to user_exercises_path(current_user)
  end
  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user_id)
  end

  def set_current_room
    if params[:room_id]
      @room = Room.find_by(id: params[:room_id])
    else
      @room = current_user.room
    end
    session[:current_room] = @room.id if @room.present?
  end
end
