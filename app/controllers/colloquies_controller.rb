class ColloquiesController < ApplicationController
  # GET /colloquies
  # GET /colloquies.json
  def index
    @colloquies = Colloquy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @colloquies }
    end
  end

  # GET /colloquies/1
  # GET /colloquies/1.json
  def show
    @colloquy = Colloquy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @colloquy }
    end
  end

  # GET /colloquies/new
  # GET /colloquies/new.json
  def new
    @colloquy = Colloquy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @colloquy }
    end
  end

  # GET /colloquies/1/edit
  def edit
    @colloquy = Colloquy.find(params[:id])
  end

  # POST /colloquies
  # POST /colloquies.json
  def create
    @colloquy = Colloquy.new(params[:colloquy])

    respond_to do |format|
      if @colloquy.save
        format.html { redirect_to @colloquy, notice: 'Colloquy was successfully created.' }
        format.json { render json: @colloquy, status: :created, location: @colloquy }
      else
        format.html { render action: "new" }
        format.json { render json: @colloquy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /colloquies/1
  # PUT /colloquies/1.json
  def update
    @colloquy = Colloquy.find(params[:id])

    respond_to do |format|
      if @colloquy.update_attributes(params[:colloquy])
        format.html { redirect_to @colloquy, notice: 'Colloquy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @colloquy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colloquies/1
  # DELETE /colloquies/1.json
  def destroy
    @colloquy = Colloquy.find(params[:id])
    @colloquy.destroy

    respond_to do |format|
      format.html { redirect_to colloquies_url }
      format.json { head :no_content }
    end
  end
end
