class ExercisesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :index

  # GET /exercises
  # GET /exercises.json
  def index
    @per_page = params[:per_page]
    @query = params[:query]
    @part = params[:part]
    @exercise_type = params[:exercise_type]
    @answer_type = params[:answer_type]

    @exercises = Exercise.search(@query, @part, @exercise_type, @answer_type, current_user)

    respond_to do |format|
      format.html do
        @exercises = @exercises.paginate(:page => params[:page], :per_page => @per_page)
      end
      format.json { render json: @exercises }
    end
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
    @exercise = Exercise.find(params[:id])
    raise_exception_unless(@exercise.can_be_read_by?(current_user))

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exercise }
    end
  end

  # GET /exercises/new
  # GET /exercises/new.json
  def new
    @exercise = Exercise.new
    raise_exception_unless(@exercise.can_be_created_by?(current_user))

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exercise }
    end
  end

  # GET /exercises/1/edit
  def edit
    @exercise = Exercise.find(params[:id])
    raise_exception_unless(@exercise.can_be_updated_by?(current_user))
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @exercise = Exercise.new(params[:exercise])
    raise_exception_unless(@exercise.can_be_created_by?(current_user))

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to @exercise, notice: 'Exercise was successfully created.' }
        format.json { render json: @exercise, status: :created, location: @exercise }
      else
        format.html { render action: "new" }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exercises/1
  # PUT /exercises/1.json
  def update
    @exercise = Exercise.find(params[:id])
    raise_exception_unless(@exercise.can_be_updated_by?(current_user))

    respond_to do |format|
      if @exercise.update_attributes(params[:exercise])
        format.html { redirect_to @exercise, notice: 'Exercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise = Exercise.find(params[:id])
    raise_exception_unless(@exercise.can_be_destroyed_by?(current_user))

    @exercise.destroy

    respond_to do |format|
      format.html { redirect_to exercises_url }
      format.json { head :no_content }
    end
  end
end
