class ExercisesController < ApplicationController

  def index
    @exercises = current_user.exercises.where('workout_date >= ?', 7.days.ago)
  end

  def show
    @exercise = current_user.exercises.find params[:id]
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    if @exercise.save
      flash[:notice] = 'Exercise has been created.'
      redirect_to  user_exercise_path(current_user, @exercise)
    else  
      flash[:alert] = 'Exercise has not been created'
      render :new
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:duration_in_min, :workout, :workout_date, :user_id)
  end
end
